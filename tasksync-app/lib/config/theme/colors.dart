part of 'theme.dart';

final class TasksyncColors extends ThemeExtension<TasksyncColors> {
  const TasksyncColors({
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
  });

  final Color success;
  final Color warning;
  final Color danger;
  final Color info;

  @override
  TasksyncColors copyWith({
    Color? success,
    Color? warning,
    Color? danger,
    Color? info,
  }) {
    return TasksyncColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      info: info ?? this.info,
    );
  }

  @override
  TasksyncColors lerp(covariant TasksyncColors? other, double t) {
    if (other == null) return this;

    return TasksyncColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}
