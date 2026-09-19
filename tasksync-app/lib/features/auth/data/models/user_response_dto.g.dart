// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseDto _$UserResponseDtoFromJson(Map<String, dynamic> json) =>
    UserResponseDto(
      id: (json['id'] as num).toInt(),
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$UserResponseDtoToJson(UserResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'email': instance.email,
      'createdAt': instance.createdAt.toIso8601String(),
    };
