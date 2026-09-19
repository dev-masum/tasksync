part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final User user;
  const ProfileLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

final class ProfileFailure extends ProfileState {
  final String message;
  const ProfileFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
