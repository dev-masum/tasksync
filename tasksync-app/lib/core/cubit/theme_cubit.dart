import 'package:app/config/theme/theme.dart';
import 'package:app/core/storage/prefs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'theme_state.dart';

const themeKey = 'com.tasksync.app.theme';

@lazySingleton
class ThemeCubit extends Cubit<ThemeState> {
  final SharedPrefsStorage _prefsStorage;

  ThemeCubit(this._prefsStorage) : super(const ThemeState.initial());

  void load() {
    final theme = _prefsStorage.getString(themeKey);

    final themeMode = switch (theme) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    emit(state.copyWith(themeMode: themeMode));
  }

  void switchTheme(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));

    final theme = switch (themeMode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };

    _prefsStorage.setString(themeKey, theme);
  }

  void changeLightTheme(TasksyncTheme lightTheme) {
    emit(state.copyWith(lightTheme: lightTheme));
  }

  void changeDarkTheme(TasksyncTheme darkTheme) {
    emit(state.copyWith(darkTheme: darkTheme));
  }
}
