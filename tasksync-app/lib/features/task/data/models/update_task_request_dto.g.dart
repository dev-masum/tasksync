// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_task_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTaskRequestDto _$UpdateTaskRequestDtoFromJson(
  Map<String, dynamic> json,
) => UpdateTaskRequestDto(
  title: json['title'] as String?,
  description: json['description'] as String?,
  dueDate: UpdateTaskRequestDto._optionalDateTimeFromJson(
    json['dueDate'] as String?,
  ),
  isComplete: json['isComplete'] as bool?,
);

Map<String, dynamic> _$UpdateTaskRequestDtoToJson(
  UpdateTaskRequestDto instance,
) => <String, dynamic>{
  'title': ?instance.title,
  'description': ?instance.description,
  'dueDate': ?UpdateTaskRequestDto._optionalDateTimeToJson(instance.dueDate),
  'isComplete': ?instance.isComplete,
};
