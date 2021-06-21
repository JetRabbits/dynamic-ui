

abstract class Action {
  final String id;
  final String type;

  Future<void> perform(Map<String, dynamic> parameters);

  Action(
      {required this.id,
      required this.type});
}
