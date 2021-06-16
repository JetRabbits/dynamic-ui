import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


@deprecated
class DynamicTextFormFieldParser extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    String? clickEvent =
    map.containsKey("click_event") ? map['click_event'] : "";

    try {
      return DynamicTextFormField(
            name: map['name'],
            autoValidateMode: map['autoValidateMode'] != null ? AutovalidateMode.values[map['autoValidateMode'] as int]: null,
            title: map['title'],
            initialValue: map['initialValue'],
            maxLines: map['maxLines'] != null ? map['maxLines'] as int : null,
            minLines: map['minLines'] != null ? map['minLines'] as int : null,
            width: map['width'] != null ? (map['width'] as num).toDouble() : null,
            obscureText: map['obscureText'],
            textCapitalization: TextCapitalization.none,
          );
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      throw e;
    }
  }

  @override
  String get widgetName => "DynamicTextFormField";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as DynamicTextFormField;

    return <String, dynamic>{
      "type": widgetName,
      "title": realWidget.title,
      "obscureText": realWidget.obscureText,
      "width": realWidget.width,
      "initialValue": realWidget.initialValue,
      "minLines": realWidget.minLines,
      "maxLines": realWidget.maxLines,
      "autoValidateMode": realWidget.autoValidateMode?.index,
      "name": realWidget.name,
    };
  }

  @override
  Type get widgetType => DynamicTextFormField;
}


