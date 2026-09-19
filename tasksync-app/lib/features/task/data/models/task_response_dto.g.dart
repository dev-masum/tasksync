// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskResponseDto _$TaskResponseDtoFromJson(Map<String, dynamic> json) =>
    TaskResponseDto(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      isComplete: json['isComplete'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TaskResponseDtoToJson(TaskResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'dueDate': instance.dueDate.toIso8601String(),
      'isComplete': instance.isComplete,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
