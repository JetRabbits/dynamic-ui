import 'package:flutter/widgets.dart' show BuildContext, Navigator;
import 'package:flutter_draft/flutter_draft.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';

part 'navigator_action.g.dart';

enum NavigatorOperation { CLOSE, GO }

dynamic toJsonNavigatorOperation(NavigatorOperation operation) {
  return operation.toString().replaceAll(operation.runtimeType.toString(), "").toLowerCase();
}

NavigatorOperation fromJsonNavigatorOperation(dynamic json) {
  return NavigatorOperation.values
      .where((element) => toJsonNavigatorOperation(element).contains(json.toString()))
      .first;
}

@JsonSerializable()
class NavigatorAction extends Action {
  @JsonKey(
      toJson: toJsonNavigatorOperation, fromJson: fromJsonNavigatorOperation)
  final NavigatorOperation operation;

  final String? route;

  NavigatorAction(
      {required String id,
      String type = 'navigator',
      this.operation = NavigatorOperation.GO,
      this.route})
      : super(type: type, id: id);

  static Map<String, dynamic> toJson(Action instance) =>
      _$NavigatorActionToJson(instance as NavigatorAction);

  static Action fromJson(dynamic json) => _$NavigatorActionFromJson(json);
  static final _logger = Logger('NavigatorAction');

  @override
  Future<void> perform(BuildContext context, Map<String, dynamic> parameters) async {
    switch (operation) {
      case NavigatorOperation.GO:
        _logger.info("going to '$route'");
        Navigator.of(context).pushNamed(route!);
        return;
      case NavigatorOperation.CLOSE:
        _logger.info("closing current route");
        Navigator.of(context).pop();
        return;
    }
  }
}
