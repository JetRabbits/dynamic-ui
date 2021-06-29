import 'dart:convert';
import 'dart:io';

import 'package:dynamic_ui/utils/parameters_utils.dart';
import 'package:flutter_draft/flutter_draft.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';

part 'http_action.g.dart';

@JsonSerializable()
class HttpAction extends Action {
  final String url;
  final Map<String, dynamic> payload;
  final Map<String, String>? headers;
  final String method;

  HttpAction(
      {required String id,
      String type = 'http',
      this.headers = const {},
      this.method = 'post',
      required this.url,
      required this.payload})
      : super(type: type, id: id);

  static Map<String, dynamic> toJson(Action instance) =>
      _$HttpActionToJson(instance as HttpAction);

  static Action fromJson(dynamic json) => _$HttpActionFromJson(json);
  static final _logger = Logger('HttpAction');

  @override
  Future<void> perform(
      BuildContext context, Map<String, dynamic> parameters) async {
    _logger.info(parameters);
    String template = jsonEncode(payload);
    var resultForPost = substituteParams(template, parameters);
    late Response response;
    switch (method) {
      case 'post':
        var _headers = Map<String, String>()
          ..addAll(headers)
          ..putIfAbsent(
              HttpHeaders.contentTypeHeader, () => ContentType.json.toString());
        response = await post(Uri.parse(substituteParams(url, parameters)),
            headers: _headers, body: resultForPost);
        break;
      case 'get':
        response = await get(Uri.parse(substituteParams(url, parameters)),
            headers: headers);
        break;
      default:
        throw "Unsupported http method: '$method'";
    }
    _logger.info("response: ${response.body}");

    Map<String, dynamic> _responses =
        parameters.putIfAbsent("responses", () => <String, dynamic>{});
    _responses[id] = response.body;

    return Future.value();
  }
}
