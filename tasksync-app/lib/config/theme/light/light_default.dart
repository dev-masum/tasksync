part of '../theme.dart';

final class LightDefault extends TasksyncTheme {
  const LightDefault();

  @override
  TasksyncColors get colors => TasksyncColors(
    success: Colors.green,
    warning: Colors.yellow,
    danger: Colors.red,
    info: Colors.blue,
  );

  @override
  ColorScheme get colorScheme =>
      ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.light);

  @override
  Color get seedColor => Colors.blue;
}
