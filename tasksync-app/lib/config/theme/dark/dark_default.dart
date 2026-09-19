part of '../theme.dart';

final class DarkDefault extends TasksyncTheme {
  const DarkDefault();

  @override
  TasksyncColors get colors => TasksyncColors(
    success: Colors.green,
    warning: Colors.yellow,
    danger: Colors.red,
    info: Colors.blue,
  );

  @override
  ColorScheme get colorScheme =>
      ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark);

  @override
  Color get seedColor => Colors.blue;
}
