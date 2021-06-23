// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchAction _$LaunchActionFromJson(Map<String, dynamic> json) {
  return LaunchAction(
    id: json['id'] as String,
    type: json['type'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$LaunchActionToJson(LaunchAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'url': instance.url,
    };
