import 'dart:convert';
import 'dart:io';

import 'package:dynamic_ui/utils/parameters_utils.dart';
import 'package:flutter_draft/flutter_draft.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';

part 'post_action.g.dart';

@JsonSerializable()
class PostAction extends Action {
  final String url;
  final Map<String, dynamic> payload;

  PostAction(
      {required String id,
      String type = 'post',
      required this.url,
      required this.payload})
      : super(type: type, id: id);

  static Map<String, dynamic> toJson(Action instance) =>
      _$PostActionToJson(instance as PostAction);

  static Action fromJson(dynamic json) => _$PostActionFromJson(json);
  static final _logger = Logger('PostAction');

  @override
  Future<void> perform(BuildContext context, Map<String, dynamic> parameters) async {
    print(parameters);
    String template = jsonEncode(payload);
    var resultForPost = substituteParams(template, parameters);
    Response response = await post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        },
        body: resultForPost);
    _logger.info("response: ${response.body}");
    return Future.value();
  }
}
