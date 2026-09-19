import 'package:flutter/material.dart';

part 'colors.dart';
part 'dark/dark_default.dart';
part 'dark/dark_saturated.dart';
part 'light/light_default.dart';
part 'light/light_saturated.dart';

abstract class TasksyncTheme {
  const TasksyncTheme();

  Color get seedColor;

  TasksyncColors get colors;

  ColorScheme get colorScheme;

  ThemeData get theme => ThemeData(
    colorScheme: colorScheme,
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      labelLarge: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
      labelSmall: TextStyle(fontSize: 6, fontWeight: FontWeight.w600),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(),
      errorBorder: OutlineInputBorder(),
      disabledBorder: OutlineInputBorder(),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    ),
  );
}
