import 'dart:developer';

import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class UriHandler {
  Future<void> handle(Uri uri, [Map<String, dynamic>? parameters]);
}


class HandlersRegistry {
  final Map<String, UriHandler> _handlers = {};

  void register(String schema, UriHandler handler) {
    _handlers.putIfAbsent(schema, () => handler);
  }

  void unregister(String schema) {
    _handlers.remove(schema);
  }
}

class HandlerProcessor {
  static final _loggerName = 'HandlerProcessor';
  final HandlersRegistry registry;

  Future<void> process(List<Uri> commands,
      [Map<String, dynamic>? parameters]) async {
    for (var uri in commands) {
      var handler = registry._handlers[uri.scheme];
      if (handler ==
          null) throw "Not found handler for $uri. Please register it";
      try {
        await handler.handle(uri, parameters);
      }
      catch (e, stacktrace) {
        print(e);
        print(stacktrace);
        log('Error during handling uri $uri', stackTrace: stacktrace,
            name: _loggerName);
        break;
      }
    }
  }

  HandlerProcessor(this.registry);
}

class PostHandler extends UriHandler {
  @override
  Future<void> handle(Uri uri, [Map<String, dynamic>? parameters]) {
    throw UnimplementedError();
  }

}

class FormHandler extends UriHandler {
  static final _loggerName = "FormHandler";

  FormHandler();

  @override
  Future<void> handle(Uri uri, [Map<String, dynamic>? parameters]) async {
    log('handle', name: _loggerName);
    if (uri.scheme == 'form') {
      switch (uri.pathSegments[0]) {
        case 'post':
          {
            var formKey = uri.pathSegments[1];
            var formBuilderStateKey = parameters![formKey] as GlobalKey<
                FormBuilderState>;
            var formBuilderState = formBuilderStateKey.currentState!;
            if (formBuilderStateKey.currentState!.saveAndValidate()) {
              // var postParams = formBuilderState.value;
              // await http.post(url, body: body).then((http.Response response) {
              //   final int statusCode = response.statusCode;
              //
              //   if (statusCode < 200 || statusCode > 400 || json == null) {
              //     throw new Exception("Error while fetching data");
              //   }
              //   return Post.fromJson(json.decode(response.body));
              // });
            }
            break;
          }
      }
    }
    return Future<void>.value();
  }

}
