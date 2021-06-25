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
      "errorText": realWidget.errorText,
      "closeButton": DynamicWidgetBuilder.export(realWidget.closeButton, buildContext),
      "dateFormat": realWidget.dateFormat,
      "pickerDialogStyle": realWidget.pickerDialogStyle.index,
      "bottomSheetHeight": realWidget.bottomSheetHeight,
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
      errorText: map['errorText'] ?? '',
      dateFormat: map['dateFormat'] ?? 'dd.MM.yyyy',
      name: map['name'] ?? 'date',
      initialValue: map['initialValue'] != null ? DateTime.tryParse(map['initialValue']): null,
      bottomSheetHeight: map['bottomSheetHeight']?.toDouble(),
      closeButton: DynamicWidgetBuilder.buildFromMap(
          map['closeButton'], buildContext, listener),
      pickerDialogStyle: map['pickerDialogStyle'] != null
          ? PickerDialogStyle.values[map['pickerDialogStyle'] as int]
          : PickerDialogStyle.BOTTOM_SHEET,
      autovalidateMode: map['autovalidateMode'] != null
          ? AutovalidateMode.values[map['autovalidateMode'] as int]
          : AutovalidateMode.disabled,
    );
  }

  @override
  String get widgetName => "FormBuilderDatePicker";

  @override
  Type get widgetType => FormBuilderDatePicker;
}
