part of 'auth_check_cubit.dart';

sealed class AuthCheckState extends Equatable {
  const AuthCheckState();

  @override
  List<Object?> get props => [];
}

final class AuthCheckInitial extends AuthCheckState {}

final class AuthCheckLoading extends AuthCheckState {}

final class AuthCheckAuthenticated extends AuthCheckState {}

final class AuthCheckUnauthenticated extends AuthCheckState {}

final class AuthCheckFailure extends AuthCheckState {
  final String message;
  const AuthCheckFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
