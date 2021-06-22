import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:dynamic_ui/widgets/action_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:flutter_draft/flutter_draft.dart';
import 'package:logging/logging.dart';

part 'actions_bloc_state.dart';

class ActionsBloc extends Cubit<ActionsBlocState> {
  static final logger = Logger('ActionsBloc');

  ActionsBloc()
      : super(ActionsBlocState(ActionsBlocStateType.INIT, ActionsBlocData()));

  void put(String key, dynamic data) {
    state.data.context[key] = data;
  }

  void clear(String key, dynamic data) {
    state.data.context.clear();
  }

  void startUpdate() {
    emit(ActionsBlocState(ActionsBlocStateType.LOADING, state.data));
  }

  void finishUpdate() {
    emit(ActionsBlocState(ActionsBlocStateType.LOADED, state.data));
  }

  Future<void> execute(BuildContext context) async {
    emit(ActionsBlocState(ActionsBlocStateType.LOADING, state.data));
    List<Action> actions = ActionManager.of(context)?.actions ?? <Action>[];
    if (actions.isEmpty) return SynchronousFuture(null);
    var formBuilder = FormBuilder.of(context);
    if (formBuilder != null) {
      if (!formBuilder.saveAndValidate()) return;
    } else {
      logger.info('No form builder for parameters to be processed');
    }

    var parameters = formBuilder?.value ?? Map<String, dynamic>();
    state.data.context.addAll(parameters);
    late Action currentAction;
    try {
      for (var action in actions) {
        currentAction = action;
        logger.info(
            "action: '${currentAction.id}', context data: ${state.data.context}");
        await action.perform(context, state.data.context);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Error during execute action id: '${currentAction.id}', context data: ${state.data.context}",
          error,
          stacktrace);
    }
    emit(ActionsBlocState(ActionsBlocStateType.LOADED, state.data));
  }
}
