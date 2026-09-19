import 'package:app/features/task/domain/entities/task.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_response_dto.g.dart';

@JsonSerializable()
class TaskResponseDto {
  final int id;
  @JsonKey(name: 'userId')
  final int userId;
  final String title;
  final String description;
  @JsonKey(name: 'dueDate')
  final DateTime dueDate;
  @JsonKey(name: 'isComplete')
  final bool isComplete;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  const TaskResponseDto({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isComplete,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaskResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TaskResponseDtoToJson(this);

  Task toEntity() {
    return Task(
      id: id,
      userId: userId,
      title: title,
      description: description,
      dueDate: dueDate,
      isComplete: isComplete,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
