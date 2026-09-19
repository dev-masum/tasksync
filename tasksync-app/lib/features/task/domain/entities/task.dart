import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isComplete;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Task({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isComplete,
    required this.createdAt,
    required this.updatedAt,
  });

  Task copyWith({
    int? id,
    int? userId,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Task(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isComplete: isComplete ?? this.isComplete,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        dueDate,
        isComplete,
        createdAt,
        updatedAt,
      ];
}
