import 'package:app/config/di/injection.dart';
import 'package:app/config/router/auth_state_notifier.dart';
import 'package:app/config/router/routes.dart';
import 'package:app/features/auth/presentation/cubit/login_cubit.dart';
import 'package:app/features/auth/presentation/cubit/login_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is LoginSuccess) {
            getIt<AuthStateNotifier>().setAuthenticated(state.token);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<LoginFormCubit, LoginFormState>(
                builder: (context, formState) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) =>
                        context.read<LoginFormCubit>().emailChanged(value),
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
              BlocBuilder<LoginFormCubit, LoginFormState>(
                builder: (context, formState) {
                  return ValueListenableBuilder<bool>(
                    valueListenable: _isPasswordVisible,
                    builder: (context, isVisible, child) {
                      return TextFormField(
                        obscureText: !isVisible,
                        onChanged: (value) =>
                            context.read<LoginFormCubit>().passwordChanged(value),
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
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, loginState) {
                  final isLoading = loginState is LoginLoading;

                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (context.read<LoginFormCubit>().validate()) {
                              final formState =
                                  context.read<LoginFormCubit>().state;
                              context.read<LoginCubit>().login(
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
                        : const Text('Login'),
                  );
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.pushNamed(AppRoutes.register.name),
                child: const Text("Don't have an account? Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
