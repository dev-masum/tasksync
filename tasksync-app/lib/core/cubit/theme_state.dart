part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  const ThemeState(this.lightTheme, this.darkTheme, this.themeMode);

  const ThemeState.initial()
    : this(const LightDefault(), const DarkDefault(), ThemeMode.system);

  final TasksyncTheme lightTheme;
  final TasksyncTheme darkTheme;
  final ThemeMode themeMode;

  ThemeState copyWith({
    TasksyncTheme? lightTheme,
    TasksyncTheme? darkTheme,
    ThemeMode? themeMode,
  }) => ThemeState(
    lightTheme ?? this.lightTheme,
    darkTheme ?? this.darkTheme,
    themeMode ?? this.themeMode,
  );

  @override
  List<Object?> get props => [lightTheme, darkTheme, themeMode];

  List<TasksyncTheme> get lightThemes => const [
    LightDefault(),
    LightSaturated(),
  ];

  List<TasksyncTheme> get darkThemes => const [DarkDefault(), DarkSaturated()];
}
