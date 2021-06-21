import 'action_register.dart';

abstract class Action {
  final String id;
  final String type;

  Future<void> perform(Map<String, dynamic> parameters);

  Action(
      {required this.id,
      required this.type,
      required fromJson,
      required toJson}) {
    ActionRegister.addAction(type, toJson, fromJson);
  }
}
