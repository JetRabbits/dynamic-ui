// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replace_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplaceAction _$ReplaceActionFromJson(Map<String, dynamic> json) {
  return ReplaceAction(
    id: json['id'] as String,
    type: json['type'] as String,
    pattern: json['pattern'] as String,
    value: json['value'] as String,
    key: json['key'] as String,
  );
}

Map<String, dynamic> _$ReplaceActionToJson(ReplaceAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'key': instance.key,
      'pattern': instance.pattern,
      'value': instance.value,
    };
