import 'package:json_annotation/json_annotation.dart';

part 'create_task_request_dto.g.dart';

@JsonSerializable()
class CreateTaskRequestDto {
  final String title;
  final String description;
  @JsonKey(name: 'dueDate', toJson: _dateTimeToJson, fromJson: _dateTimeFromJson)
  final DateTime dueDate;

  const CreateTaskRequestDto({
    required this.title,
    required this.description,
    required this.dueDate,
  });

  static String _dateTimeToJson(DateTime date) => date.toUtc().toIso8601String();
  static DateTime _dateTimeFromJson(String date) => DateTime.parse(date);

  factory CreateTaskRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateTaskRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTaskRequestDtoToJson(this);
}

