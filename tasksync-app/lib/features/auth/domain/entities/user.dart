import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String fullname;
  final String email;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, fullname, email, createdAt];
}
