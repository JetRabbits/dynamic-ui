part of 'actions_bloc.dart';

class ActionsBlocData {
  Map<String, dynamic> context = <String, dynamic>{};
}

enum ActionsBlocStateType { INIT, LOADING, LOADED }

class ActionsBlocState {
  final ActionsBlocStateType type;
  final ActionsBlocData data;

  ActionsBlocState(this.type, this.data);
}
