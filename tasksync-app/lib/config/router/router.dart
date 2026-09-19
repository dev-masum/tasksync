import 'package:app/config/di/injection.dart';
import 'package:app/config/screens/not_found_screen.dart';
import 'package:app/features/battery/presentation/cubit/battery_cubit.dart';
import 'package:app/features/auth/presentation/cubit/login_cubit.dart';
import 'package:app/features/auth/presentation/cubit/login_form_cubit.dart';
import 'package:app/features/auth/presentation/cubit/register_cubit.dart';
import 'package:app/features/auth/presentation/cubit/register_form_cubit.dart';
import 'package:app/features/auth/presentation/screens/login_screen.dart';
import 'package:app/features/auth/presentation/screens/register_screen.dart';
import 'package:app/features/task/presentation/cubit/task_action_cubit.dart';
import 'package:app/features/task/presentation/cubit/task_detail_cubit.dart';
import 'package:app/features/task/presentation/cubit/task_form_cubit.dart';
import 'package:app/features/task/presentation/cubit/task_list_cubit.dart';
import 'package:app/features/task/presentation/screens/add_task_screen.dart';
import 'package:app/features/task/presentation/screens/edit_task_screen.dart';
import 'package:app/features/task/presentation/screens/home_screen.dart';
import 'package:app/features/task/presentation/screens/view_task_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'auth_state_notifier.dart';
import 'routes.dart';

final router = GoRouter(
  initialLocation: AppRoutes.login.path,
  refreshListenable: getIt<AuthStateNotifier>(),
  redirect: (context, state) {
    final authState = getIt<AuthStateNotifier>().value;

    final isLoggingIn = state.matchedLocation == AppRoutes.login.path;
    final isRegistering = state.matchedLocation == AppRoutes.register.path;
    final isAuthRoute = isLoggingIn || isRegistering;

    return switch (authState) {
      AuthInitial() => null,
      Unauthenticated() => isAuthRoute ? null : AppRoutes.login.path,
      Authenticated() => isAuthRoute ? AppRoutes.home.path : null,
    };
  },

  routes: [
    GoRoute(
      name: AppRoutes.login.name,
      path: AppRoutes.login.path,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<LoginFormCubit>()),
          BlocProvider(create: (_) => getIt<LoginCubit>()),
        ],
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.register.name,
      path: AppRoutes.register.path,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<RegisterFormCubit>()),
          BlocProvider(create: (_) => getIt<RegisterCubit>()),
        ],
        child: const RegisterScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.home.name,
      path: AppRoutes.home.path,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<TaskListCubit>()),
          BlocProvider(create: (_) => getIt<BatteryCubit>()),
        ],
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.addTask.name,
      path: AppRoutes.addTask.path,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<TaskFormCubit>()),
          BlocProvider(create: (_) => getIt<TaskActionCubit>()),
        ],
        child: const AddTaskScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.editTask.name,
      path: AppRoutes.editTask.path,
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<TaskDetailCubit>()..fetchTask(id)),
            BlocProvider(create: (_) => getIt<TaskFormCubit>()),
            BlocProvider(create: (_) => getIt<TaskActionCubit>()),
          ],
          child: EditTaskScreen(taskId: id),
        );
      },
    ),
    GoRoute(
      name: AppRoutes.viewTask.name,
      path: AppRoutes.viewTask.path,
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
        return ViewTaskScreen(taskId: id);
      },
    ),
  ],
  errorBuilder: (context, state) {
    return NotFoundScreen(path: state.matchedLocation, name: state.name);
  },
);
