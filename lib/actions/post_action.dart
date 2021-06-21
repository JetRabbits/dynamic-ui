import 'package:json_annotation/json_annotation.dart';

import 'action.dart';

part 'post_action.g.dart';

@JsonSerializable()
class PostAction extends Action {
  final String url;
  final Map<String, dynamic> payload;

  PostAction({required String id, String type = 'post', required this.url, required this.payload})
      : super(type: type, id: id, toJson: (Action action) => _$PostActionToJson(action as PostAction), fromJson: (dynamic json) => _$PostActionFromJson(json));

  @override
  Future<void> perform(Map<String, dynamic> parameters) {
    print(parameters);
    // payload.map<MapEntry<String, String>>((key, value) => MapEntry(key, value.re))values
    return Future.value();
  }
}
