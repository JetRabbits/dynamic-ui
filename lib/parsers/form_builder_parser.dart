import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:dynamic_ui/widgets/file_picker_widget.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormBuilderParser extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    try {
      return FormBuilder(
            key: ValueKey<String>(map['key'] as String),
            child:
                DynamicWidgetBuilder.buildFromMap(map['child'], buildContext, listener)!,
            autovalidateMode: map['autovalidateMode'] != null ? AutovalidateMode.values[map['autovalidateMode'] as int] : null,
            enabled: map['enabled'],
            skipDisabled: map['skipDisabled'],
            initialValue: map['initialValue']
          );
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      throw e;
    }
  }

  @override
  String get widgetName => "FormBuilder";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as FormBuilder;

    return <String, dynamic>{
      "key": realWidget.key.toString(),
      "type": widgetName,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext),
      "autoValidateMode": realWidget.autovalidateMode?.index,
      "initialValue": realWidget.initialValue,
      "enabled": realWidget.enabled,
      "skipDisabled": realWidget.skipDisabled
    };
  }

  @override
  Type get widgetType => FormBuilder;
}
