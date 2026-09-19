import 'package:json_annotation/json_annotation.dart';

part 'update_task_request_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class UpdateTaskRequestDto {
  final String? title;
  final String? description;
  @JsonKey(name: 'dueDate', toJson: _optionalDateTimeToJson, fromJson: _optionalDateTimeFromJson)
  final DateTime? dueDate;
  @JsonKey(name: 'isComplete')
  final bool? isComplete;

  const UpdateTaskRequestDto({
    this.title,
    this.description,
    this.dueDate,
    this.isComplete,
  });

  static String? _optionalDateTimeToJson(DateTime? date) => date?.toUtc().toIso8601String();
  static DateTime? _optionalDateTimeFromJson(String? date) =>
      date != null ? DateTime.parse(date) : null;

  factory UpdateTaskRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateTaskRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTaskRequestDtoToJson(this);
}

