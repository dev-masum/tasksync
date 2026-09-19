import 'package:app/features/task/presentation/cubit/task_action_cubit.dart';
import 'package:app/features/task/presentation/cubit/task_detail_cubit.dart';
import 'package:app/features/task/presentation/cubit/task_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditTaskScreen extends StatefulWidget {
  final int taskId;

  const EditTaskScreen({
    super.key,
    required this.taskId,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Task #${widget.taskId}')),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TaskActionCubit, TaskActionState>(
            listener: (context, state) {
              if (state is TaskActionFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is TaskActionSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Task updated successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );

                context.pop(true);
              }
            },
          ),
          BlocListener<TaskDetailCubit, TaskDetailState>(
            listener: (context, state) {
              if (state is TaskDetailLoaded) {
                _titleController.text = state.task.title;
                _descriptionController.text = state.task.description;
                context.read<TaskFormCubit>().initForm(
                      title: state.task.title,
                      description: state.task.description,
                      dueDate: state.task.dueDate,
                    );
              }
            },
          ),
        ],
        child: BlocBuilder<TaskDetailCubit, TaskDetailState>(
          builder: (context, state) {
            if (state is TaskDetailLoading || state is TaskDetailInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TaskDetailFailure) {
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
                      onPressed: () => context
                          .read<TaskDetailCubit>()
                          .fetchTask(widget.taskId),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is TaskDetailLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<TaskFormCubit, TaskFormState>(
                      builder: (context, formState) {
                        return TextFormField(
                          controller: _titleController,
                          onChanged: (value) => context
                              .read<TaskFormCubit>()
                              .titleChanged(value),
                          decoration: InputDecoration(
                            labelText: 'Title',
                            hintText: 'Enter task title',
                            errorText: formState.showErrorMessages
                                ? formState.title.errorMessage
                                : null,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<TaskFormCubit, TaskFormState>(
                      builder: (context, formState) {
                        return TextFormField(
                          controller: _descriptionController,
                          maxLines: 3,
                          onChanged: (value) => context
                              .read<TaskFormCubit>()
                              .descriptionChanged(value),
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Enter task description',
                            errorText: formState.showErrorMessages
                                ? formState.description.errorMessage
                                : null,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<TaskFormCubit, TaskFormState>(
                      builder: (context, formState) {
                        final dateText = formState.dueDate.value != null
                            ? formState.dueDate.value!
                                .toLocal()
                                .toString()
                                .split(' ')[0]
                            : 'Select Due Date';

                        return ListTile(
                          title: Text(dateText),
                          trailing: const Icon(Icons.calendar_today),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: formState.dueDate.value ??
                                  DateTime.now(),
                              firstDate: DateTime.now().subtract(
                                const Duration(days: 365),
                              ),
                              lastDate: DateTime.now()
                                  .add(const Duration(days: 365)),
                            );
                            if (picked != null) {
                              if (context.mounted) {
                                context
                                    .read<TaskFormCubit>()
                                    .dueDateChanged(picked);
                              }
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<TaskActionCubit, TaskActionState>(
                      builder: (context, actionState) {
                        final isLoading = actionState is TaskActionLoading;

                        return ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (context
                                      .read<TaskFormCubit>()
                                      .validate()) {
                                    final formState =
                                        context.read<TaskFormCubit>().state;
                                    context.read<TaskActionCubit>().updateTask(
                                          id: widget.taskId,
                                          title: formState.title.value,
                                          description:
                                              formState.description.value,
                                          dueDate: formState.dueDate.value,
                                        );
                                  }
                                },
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2),
                                )
                              : const Text('Save Changes'),
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

