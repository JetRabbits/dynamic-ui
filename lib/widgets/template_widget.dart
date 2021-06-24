import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    show BuildContext, Widget, StatelessWidget;
import 'package:flutter_draft/flutter_draft.dart';

class TemplateWidget extends StatelessWidget {
  final Widget child;

  const TemplateWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }

  static TemplateWidget? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<TemplateWidget>();
}
