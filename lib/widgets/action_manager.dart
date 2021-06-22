import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    show BuildContext, Widget, StatelessWidget;
import 'package:flutter_draft/flutter_draft.dart';
import 'package:logging/logging.dart';

class ActionManager extends StatelessWidget {
  final List<Action> actions;
  static final logger = Logger('ActionManager');
  final Widget child;

  const ActionManager({Key? key, required this.actions, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }

  static ActionManager? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<ActionManager>();
}
