import 'dart:developer';

import 'package:flutter/cupertino.dart';

abstract class UriHandler {
  Future<void> handle(Uri uri, [Map<String, dynamic>? parameters]);
}


class HandlersRegistry {
  final Map<String, UriHandler> _handlers = {};
  void register(String schema, UriHandler handler){
    _handlers.putIfAbsent(schema, () => handler);
  }
  void unregister(String schema){
    _handlers.remove(schema);
  }
}

class HandlerProcessor {
  static final _loggerName = 'HandlerProcessor';
  final HandlersRegistry registry;

  Future<void> process(List<Uri> commands, [Map<String, dynamic>? parameters]) async {
      for (var uri in commands) {
            var handler = registry._handlers[uri.scheme];
            if (handler == null) throw "Not found handler for $uri. Please register it";
            try {
              await handler.handle(uri, parameters);
            }
            catch (e, stacktrace) {
              log('Error during handling uri $uri', name: _loggerName);
              break;
            }
          }
  }

  HandlerProcessor(this.registry);
}

