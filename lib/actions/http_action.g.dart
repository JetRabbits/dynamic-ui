// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpAction _$HttpActionFromJson(Map<String, dynamic> json) {
  return HttpAction(
    id: json['id'] as String,
    type: json['type'] as String,
    url: json['url'] as String,
    payload: json['payload'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$HttpActionToJson(HttpAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'url': instance.url,
      'payload': instance.payload,
    };
