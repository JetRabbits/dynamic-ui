import 'package:dynamic_ui/actions/action.dart' as a;
import 'package:dynamic_ui/actions/action_register.dart';
import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:dynamic_ui/widgets/action_manager.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class ActionManagerParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    ActionManager realWidget = widget as ActionManager;
    return <String, dynamic>{
      "type": widgetName,
      "actions": realWidget.actions.map((action) {
        ActionSerializer serializer = ActionRegister.serializers[action.type]!;
        return serializer(action);
      }).toList(),
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    return ActionManager(
        actions: (map['actions'] as List).map<a.Action>((json) {
          String type = json['type'];
          ActionDeserializer deserializer = ActionRegister.deserializers[type]!;
          return deserializer(json);
        }).toList(),
        child: map['child'] != null
            ? DynamicWidgetBuilder.buildFromMap(
                map['child'], buildContext, listener)!
            : Container());
  }

  @override
  String get widgetName => "ActionManager";

  @override
  Type get widgetType => ActionManager;
}
