import 'package:app/config/di/injection.dart';
import 'package:app/config/router/auth_state_notifier.dart';
import 'package:app/config/router/routes.dart';
import 'package:app/features/auth/presentation/cubit/profile_cubit.dart';
import 'package:app/features/battery/presentation/cubit/battery_cubit.dart';
import 'package:app/features/task/domain/entities/task.dart';
import 'package:app/features/task/presentation/cubit/task_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskListCubit>().fetchTasks();
    context.read<BatteryCubit>().fetchBatteryLevel();
    context.read<ProfileCubit>().fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskSync Home'),
        actions: [
          BlocBuilder<BatteryCubit, BatteryState>(
            builder: (context, batteryState) {
              if (batteryState is BatteryLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.battery_std, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${batteryState.level}%',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              getIt<AuthStateNotifier>().setUnauthenticated();
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskListCubit, TaskListState>(
        builder: (context, state) {
          if (state is TaskListLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskListError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<TaskListCubit>().fetchTasks(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is TaskListLoaded) {
            final tasks = state.filteredTasks;

            return Column(
              children: [
                const _ProfileHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: SegmentedButton<TaskFilter>(
                    segments: const [
                      ButtonSegment(value: TaskFilter.all, label: Text('All')),
                      ButtonSegment(
                        value: TaskFilter.active,
                        label: Text('Active'),
                      ),
                      ButtonSegment(
                        value: TaskFilter.completed,
                        label: Text('Completed'),
                      ),
                    ],
                    selected: {state.filter},
                    onSelectionChanged: (selected) {
                      context.read<TaskListCubit>().filterChanged(
                        selected.first,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: tasks.isEmpty
                      ? const Center(child: Text('No tasks found.'))
                      : RefreshIndicator(
                          onRefresh: () =>
                              context.read<TaskListCubit>().fetchTasks(),
                          child: ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              final task = tasks[index];
                              return _TaskTile(task: task);
                            },
                          ),
                        ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await context.pushNamed<bool>(AppRoutes.addTask.name);
          if (context.mounted && result == true) {
            context.read<TaskListCubit>().fetchTasks();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: LinearProgressIndicator(),
          );
        }
        if (state is ProfileLoaded) {
          final user = state.user;
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer
                  .withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    user.fullname.isNotEmpty
                        ? user.fullname[0].toUpperCase()
                        : 'U',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullname,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _TaskTile extends StatelessWidget {
  final Task task;

  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        context.read<TaskListCubit>().deleteTask(task.id);
      },
      child: ListTile(
        leading: Checkbox(
          value: task.isComplete,
          onChanged: (value) {
            if (value != null) {
              context.read<TaskListCubit>().toggleTaskComplete(task.id, value);
            }
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isComplete
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          '${task.description}\nDue: ${task.dueDate.toLocal().toString().split(' ')[0]}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: true,
        onTap: () => context.pushNamed(
          AppRoutes.viewTask.name,
          pathParameters: {'id': '${task.id}'},
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () async {
            final result = await context.pushNamed<bool>(
              AppRoutes.editTask.name,
              pathParameters: {'id': '${task.id}'},
            );
            if (context.mounted && result == true) {
              context.read<TaskListCubit>().fetchTasks();
            }
          },
        ),
      ),
    );
  }
}
