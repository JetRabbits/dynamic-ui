import 'action.dart';
typedef ActionSerializer = Map<String, dynamic> Function(Action);
typedef ActionDeserializer = Action Function(dynamic);

class ActionRegister {
  static Map<String,  ActionDeserializer> deserializers = {};
  static Map<String, ActionSerializer> serializers = {};
  static void addAction(String s, ActionSerializer serializer, ActionDeserializer deserializer) {
    deserializers[s] = deserializer;
    serializers[s] = serializer;
  }
}
