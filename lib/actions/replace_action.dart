import 'package:flutter_draft/flutter_draft.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';

part 'replace_action.g.dart';

@JsonSerializable()
class ReplaceAction extends Action {
  final String key;
  final String pattern;
  final String value;

  ReplaceAction(
      {required String id,
      String type = 'replace',
      required this.pattern,
      required this.value,
      required this.key})
      : super(type: type, id: id);

  static Map<String, dynamic> toJson(Action instance) =>
      _$ReplaceActionToJson(instance as ReplaceAction);

  static Action fromJson(dynamic json) => _$ReplaceActionFromJson(json);
  static final _logger = Logger('ReplaceAction');

  @override
  Future<void> perform(
      BuildContext context, Map<String, dynamic> parameters) async {
    _logger.info("key = $key, pattern=$pattern, value=$value");
    if (parameters[key] != null) {
      parameters[key] =
          parameters[key].toString().replaceAll(RegExp(pattern), value);
    }
  }
}
