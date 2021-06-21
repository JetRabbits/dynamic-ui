import 'package:dynamic_ui/actions/action.dart' as a;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:logging/logging.dart';



class ActionManager extends StatelessWidget {
  final List<a.Action> actions;
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

  Future<void> execute(BuildContext context) async {
    if (actions.isEmpty) return SynchronousFuture(null);
    var formBuilderContext = FormBuilder.of(context);
    if (formBuilderContext != null) {
      if (!formBuilderContext.saveAndValidate()) return;
    } else {
       logger.warning('No form builder for parameters to be processed');
    }

    var parameters = formBuilderContext?.value ?? Map<String, dynamic>();
    late a.Action currentAction;
    try {
      for (var action in actions) {
        currentAction = action;
        logger.info("action: '${currentAction.id}', parameters: $parameters");
        await action.perform(parameters);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Error during execute action id: '${currentAction.id}', parameters: $parameters",
          error,
          stacktrace);
    }
  }
}
