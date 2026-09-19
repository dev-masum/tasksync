import 'package:app/config/di/injection.dart';
import 'package:app/config/router/auth_state_notifier.dart';
import 'package:app/config/router/router.dart';
import 'package:app/core/cubit/l10n_cubit.dart';
import 'package:app/core/cubit/theme_cubit.dart';
import 'package:app/features/auth/presentation/cubit/auth_check_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class TasksyncApp extends StatelessWidget {
  const TasksyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCheckCubit, AuthCheckState>(
      listener: (context, state) {
        if (state is AuthCheckAuthenticated) {
          getIt<AuthStateNotifier>().setAuthenticated('');
        } else if (state is AuthCheckUnauthenticated) {
          getIt<AuthStateNotifier>().setUnauthenticated();
        }
      },
      child: BlocBuilder<L10nCubit, L10nState>(
        builder: (context, l10nState) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp.router(
                routerConfig: router,
                theme: themeState.lightTheme.theme,
                darkTheme: themeState.darkTheme.theme,
                themeMode: themeState.themeMode,
                locale: l10nState.locale,
                localizationsDelegates: GlobalMaterialLocalizations.delegates,
              );
            },
          );
        },
      ),
    );
  }
}

