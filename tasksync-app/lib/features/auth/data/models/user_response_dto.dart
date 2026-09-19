import 'package:json_annotation/json_annotation.dart';

part 'user_response_dto.g.dart';

@JsonSerializable()
class UserResponseDto {
  final int id;
  final String fullname;
  final String email;
  final DateTime createdAt;

  const UserResponseDto({
    required this.id,
    required this.fullname,
    required this.email,
    required this.createdAt,
  });

  factory UserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseDtoToJson(this);
}
