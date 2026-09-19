part of '../theme.dart';

final class LightSaturated extends TasksyncTheme {
  const LightSaturated();

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
