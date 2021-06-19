import 'package:flutter/material.dart';

class ActionsWidget extends StatelessWidget {
  final Map<String, dynamic> actions;

  static ActionsWidget? of(BuildContext context){
    return context.findAncestorWidgetOfExactType<ActionsWidget>();
  }

  const ActionsWidget({Key? key, required this.actions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
