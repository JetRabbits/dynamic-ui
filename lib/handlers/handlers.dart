import 'dart:developer';

import 'package:dynamic_ui/blocs/actions_bloc/actions_bloc.dart';
import 'package:flutter/widgets.dart' show BuildContext;

abstract class UriHandler {
  Future<void> handle(Uri uri, [Map<String, dynamic>? parameters]);
}

class HandlersRegistry {
  static final Map<String, UriHandler> handlers = {};

  static void register(String schema, UriHandler handler) {
    handlers.putIfAbsent(schema, () => handler);
  }

  static void unregister(String schema) {
    handlers.remove(schema);
  }
}

class HandlerProcessor {
  static final _loggerName = 'HandlerProcessor';

  Future<void> process(List<Uri> commands,
      [Map<String, dynamic>? parameters]) async {
    for (var uri in commands) {
      var handler = HandlersRegistry.handlers[uri.scheme];
      if (handler == null)
        throw "Not found handler for $uri. Please register it";
      try {
        await handler.handle(uri, parameters);
      } catch (e, stacktrace) {
        print(e);
        print(stacktrace);
        log('Error during handling uri $uri',
            stackTrace: stacktrace, name: _loggerName);
        break;
      }
    }
  }
}

class PostHandler extends UriHandler {
  @override
  Future<void> handle(Uri uri, [Map<String, dynamic>? parameters]) {
    throw UnimplementedError();
  }
}

class ActionsHandler extends UriHandler {
  final ActionsBloc actionsBloc;

  ActionsHandler(this.actionsBloc);

  @override
  Future<void> handle(Uri uri, [Map<String, dynamic>? parameters]) async {
    var buildContext = parameters?['buttonContext'] as BuildContext?;
    if (buildContext == null) return;
    parameters!['actionsBloc'] = actionsBloc;
    await actionsBloc.execute(buildContext);
  }
}
