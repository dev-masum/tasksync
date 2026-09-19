part of 'battery_cubit.dart';

sealed class BatteryState extends Equatable {
  const BatteryState();

  @override
  List<Object?> get props => [];
}

final class BatteryInitial extends BatteryState {}

final class BatteryLoading extends BatteryState {}

final class BatteryLoaded extends BatteryState {
  final int level;

  const BatteryLoaded(this.level);

  @override
  List<Object?> get props => [level];
}

final class BatteryError extends BatteryState {
  final String message;

  const BatteryError(this.message);

  @override
  List<Object?> get props => [message];
}
