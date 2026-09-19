import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object?> get props => [];
}

final class Authenticated extends AuthState {
  final String token;
  const Authenticated({required this.token});

  @override
  List<Object?> get props => [token];
}

final class Unauthenticated extends AuthState {
  const Unauthenticated();

  @override
  List<Object?> get props => [];
}

@lazySingleton
final class AuthStateNotifier extends ValueNotifier<AuthState> {
  AuthStateNotifier() : super(const AuthInitial());

  void setAuthenticated(String token) {
    value = Authenticated(token: token);
  }

  void setUnauthenticated() {
    value = const Unauthenticated();
  }
}
