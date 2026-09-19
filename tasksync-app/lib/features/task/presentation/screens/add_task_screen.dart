import 'package:app/features/task/presentation/cubit/task_action_cubit.dart';
import 'package:app/features/task/presentation/cubit/task_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: BlocListener<TaskActionCubit, TaskActionState>(
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
                content: Text('Task created successfully!'),
                backgroundColor: Colors.green,
              ),
            );

            context.pop(true);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<TaskFormCubit, TaskFormState>(
                builder: (context, formState) {
                  return TextFormField(
                    onChanged: (value) =>
                        context.read<TaskFormCubit>().titleChanged(value),
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
                    maxLines: 3,
                    onChanged: (value) =>
                        context.read<TaskFormCubit>().descriptionChanged(value),
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
                      ? formState.dueDate.value!.toLocal().toString().split(
                          ' ',
                        )[0]
                      : 'Select Due Date';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(dateText),
                        trailing: const Icon(Icons.calendar_today),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color:
                                formState.showErrorMessages &&
                                    !formState.dueDate.isValid
                                ? Colors.red
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now().subtract(
                              const Duration(days: 1),
                            ),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          if (picked != null) {
                            if (context.mounted) {
                              context.read<TaskFormCubit>().dueDateChanged(
                                picked,
                              );
                            }
                          }
                        },
                      ),
                      if (formState.showErrorMessages &&
                          !formState.dueDate.isValid)
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                          child: Text(
                            formState.dueDate.errorMessage!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
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
                            if (context.read<TaskFormCubit>().validate()) {
                              final formState = context
                                  .read<TaskFormCubit>()
                                  .state;
                              context.read<TaskActionCubit>().createTask(
                                title: formState.title.value,
                                description: formState.description.value,
                                dueDate: formState.dueDate.value!,
                              );
                            }
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Create Task'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
