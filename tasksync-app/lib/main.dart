import 'package:app/config/app/app.dart';
import 'package:app/config/di/injection.dart';
import 'package:app/core/cubit/l10n_cubit.dart';
import 'package:app/core/cubit/theme_cubit.dart';
import 'package:app/features/auth/presentation/cubit/auth_check_cubit.dart';
import 'package:app/features/auth/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencyInjection();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<L10nCubit>()),
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<AuthCheckCubit>()..checkAuth()),
        BlocProvider(create: (_) => getIt<ProfileCubit>()),
      ],
      child: const TasksyncApp(),
    ),
  );
}

