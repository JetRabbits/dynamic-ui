
import 'package:dynamic_ui/utils/parameters_utils.dart';
import 'package:flutter_draft/flutter_draft.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

part 'launch_action.g.dart';

@JsonSerializable()
class LaunchAction extends Action {
  final String url;

  LaunchAction(
      {required String id,
      String type = 'launch',
      required this.url})
      : super(type: type, id: id);

  static Map<String, dynamic> toJson(Action instance) =>
      _$LaunchActionToJson(instance as LaunchAction);

  static Action fromJson(dynamic json) => _$LaunchActionFromJson(json);
  static final _logger = Logger('LaunchAction');

  @override
  Future<void> perform(BuildContext context, Map<String, dynamic> parameters) async {
    var urlString = substituteParams(url, parameters);
    _logger.info(urlString);
    await launch(urlString);
  }
}
