// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAction _$PostActionFromJson(Map<String, dynamic> json) {
  return PostAction(
    id: json['id'] as String,
    type: json['type'] as String,
    url: json['url'] as String,
    payload: json['payload'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$PostActionToJson(PostAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'url': instance.url,
      'payload': instance.payload,
    };
