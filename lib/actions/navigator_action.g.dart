// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigator_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigatorAction _$NavigatorActionFromJson(Map<String, dynamic> json) {
  return NavigatorAction(
    id: json['id'] as String,
    type: json['type'] as String,
    operation: fromJsonNavigatorOperation(json['operation']),
    route: json['route'] as String?,
  );
}

Map<String, dynamic> _$NavigatorActionToJson(NavigatorAction instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('operation', toJsonNavigatorOperation(instance.operation));
  writeNotNull('route', instance.route);
  return val;
}
