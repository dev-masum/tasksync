// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_task_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTaskRequestDto _$CreateTaskRequestDtoFromJson(
  Map<String, dynamic> json,
) => CreateTaskRequestDto(
  title: json['title'] as String,
  description: json['description'] as String,
  dueDate: CreateTaskRequestDto._dateTimeFromJson(json['dueDate'] as String),
);

Map<String, dynamic> _$CreateTaskRequestDtoToJson(
  CreateTaskRequestDto instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'dueDate': CreateTaskRequestDto._dateTimeToJson(instance.dueDate),
};
