// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpAction _$HttpActionFromJson(Map<String, dynamic> json) {
  return HttpAction(
    id: json['id'] as String,
    type: json['type'] as String,
    headers: (json['headers'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    method: json['method'] as String,
    url: json['url'] as String,
    payload: json['payload'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$HttpActionToJson(HttpAction instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'type': instance.type,
    'url': instance.url,
    'payload': instance.payload,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('headers', instance.headers);
  val['method'] = instance.method;
  return val;
}
