import 'package:app/features/auth/presentation/cubit/register_cubit.dart';
import 'package:app/features/auth/presentation/cubit/register_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registration successful! Please log in.'),
                backgroundColor: Colors.green,
              ),
            );

            context.pop();
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<RegisterFormCubit, RegisterFormState>(
                builder: (context, formState) {
                  return TextFormField(
                    onChanged: (value) => context
                        .read<RegisterFormCubit>()
                        .fullNameChanged(value),
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'Enter your full name',
                      errorText: formState.showErrorMessages
                          ? formState.fullName.errorMessage
                          : null,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<RegisterFormCubit, RegisterFormState>(
                builder: (context, formState) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) =>
                        context.read<RegisterFormCubit>().emailChanged(value),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      errorText: formState.showErrorMessages
                          ? formState.email.errorMessage
                          : null,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<RegisterFormCubit, RegisterFormState>(
                builder: (context, formState) {
                  return ValueListenableBuilder<bool>(
                    valueListenable: _isPasswordVisible,
                    builder: (context, isVisible, child) {
                      return TextFormField(
                        obscureText: !isVisible,
                        onChanged: (value) => context
                            .read<RegisterFormCubit>()
                            .passwordChanged(value),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          errorText: formState.showErrorMessages
                              ? formState.password.errorMessage
                              : null,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              _isPasswordVisible.value = !isVisible;
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, registerState) {
                  final isLoading = registerState is RegisterLoading;

                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (context.read<RegisterFormCubit>().validate()) {
                              final formState = context
                                  .read<RegisterFormCubit>()
                                  .state;
                              context.read<RegisterCubit>().register(
                                fullname: formState.fullName.value,
                                email: formState.email.value,
                                password: formState.password.value,
                              );
                            }
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Register'),
                  );
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
