import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:dynamic_ui/widgets/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class FormBuilderDatePickerParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as FormBuilderDatePicker;
    return <String, dynamic>{
      "type": widgetName,
      "labelText": realWidget.labelText,
      "dateFormat": realWidget.dateFormat,
      "initialValue": realWidget.initialValue.toIso8601String(),
      "autovalidateMode": realWidget.autovalidateMode.index,
      "name": realWidget.name
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    return FormBuilderDatePicker(
        labelText: map['labelText'] ?? '',
        dateFormat: map['dateFormat'] ?? 'dd.MM.yyyy',
        initialValue: DateTime.tryParse(map['initialValue']),
        autovalidateMode: map['autovalidateMode'] != null
            ? AutovalidateMode.values[map['autovalidateMode'] as int]
            : AutovalidateMode.disabled,
        name: map['name'] ?? 'date');
  }

  @override
  String get widgetName => "FormBuilderDatePicker";

  @override
  Type get widgetType => FormBuilderDatePicker;
}
