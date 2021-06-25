import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:dynamic_ui/utils/parser_utils.dart';
import 'package:dynamic_ui/widgets/date_picker_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class FormBuilderDatePickerParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as FormBuilderDatePicker;
    return <String, dynamic>{
      "type": widgetName,
      "labelText": realWidget.buttonText,
      "errorText": realWidget.errorText,
      "closeButton":
          DynamicWidgetBuilder.export(realWidget.closeButton, buildContext),
      "dateFormat": realWidget.dateFormat,
      "pickerDialogStyle": realWidget.pickerDialogStyle.index,
      "bottomSheetHeight": realWidget.bottomSheetHeight,
      "initialValue": realWidget.initialValue.toIso8601String(),
      "autovalidateMode": realWidget.autovalidateMode.index,
      "hintText": realWidget.decoration.hintText,
      "labelText": realWidget.decoration.labelText,
      "fillColor": realWidget.decoration.fillColor?.value.toRadixString(16),
      "filled": realWidget.decoration.filled,
      "decorationIcon":
          DynamicWidgetBuilder.export(realWidget.decoration.icon, buildContext),
      "enabledBorderColor": realWidget
          .decoration.enabledBorder?.borderSide.color.value
          .toRadixString(16),
      "enabledBorderWidth":
          realWidget.decoration.enabledBorder?.borderSide.width,
      "borderType": realWidget.decoration.border.runtimeType.toString(),
      "borderRadius": realWidget.decoration.border is OutlineInputBorder
          ? (realWidget.decoration.border as OutlineInputBorder)
              .borderRadius
              .topLeft
              .x
          : 0,
      "borderColor": realWidget.decoration.border?.borderSide.color.value
          .toRadixString(16),
      "borderStyle": realWidget.decoration.border?.borderSide.style.index,
      "borderWidth": realWidget.decoration.border?.borderSide.width,
      "errorBorderColor": realWidget
          .decoration.errorBorder?.borderSide.color.value
          .toRadixString(16),
      "errorBorderWidth": realWidget.decoration.errorBorder?.borderSide.width,
      "enabled": realWidget.decoration.enabled,
      "counterText": realWidget.decoration.counterText,
      "counter": DynamicWidgetBuilder.export(
          realWidget.decoration.counter, buildContext),
      "errorStyle": exportTextStyle(realWidget.decoration.errorStyle),
      "counterStyle": exportTextStyle(realWidget.decoration.counterStyle),
      "helperStyle": exportTextStyle(realWidget.decoration.helperStyle),
      "hintStyle": exportTextStyle(realWidget.decoration.hintStyle),
      "prefixStyle": exportTextStyle(realWidget.decoration.prefixStyle),
      "suffixStyle": exportTextStyle(realWidget.decoration.suffixStyle),
      "labelStyle": exportTextStyle(realWidget.decoration.labelStyle),
      "errorMaxLines": realWidget.decoration.errorMaxLines,
      "isDense": realWidget.decoration.isDense,
      "name": realWidget.name
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    return FormBuilderDatePicker(
      buttonText: map['buttonText'] ?? '',
      buttonPrimaryColor: parseHexColor(map['buttonPrimaryColor']),
      buttonOnPrimaryColor: parseHexColor(map['buttonOnPrimaryColor']),
      errorText: map['errorText'] ?? '',
      dateFormat: map['dateFormat'] ?? 'dd.MM.yyyy',
      name: map['name'] ?? 'date',
      initialValue: map['initialValue'] != null
          ? DateTime.tryParse(map['initialValue'])
          : null,
      bottomSheetHeight: map['bottomSheetHeight']?.toDouble(),
      closeButton: DynamicWidgetBuilder.buildFromMap(
          map['closeButton'], buildContext, listener),
      pickerDialogStyle: map['pickerDialogStyle'] != null
          ? PickerDialogStyle.values[map['pickerDialogStyle'] as int]
          : PickerDialogStyle.BOTTOM_SHEET,
      autovalidateMode: map['autovalidateMode'] != null
          ? AutovalidateMode.values[map['autovalidateMode'] as int]
          : AutovalidateMode.disabled,
      decoration:
          InputDecoration(
            hintText: map['hintText'],
            labelText: map['labelText'],
            filled: map['filled'],
            fillColor: parseHexColor(map['fillColor']),
            icon: DynamicWidgetBuilder.buildFromMap(
                map["decorationIcon"], buildContext, listener),
            enabledBorder: map['borderType'] != null
                ? parseBorder('enabledBorder', map)
                : null,
            border: map['borderType'] != null ? parseBorder('border', map) : null,
            errorBorder: map['borderType'] != null
                ? parseBorder('errorBorder', map)
                : null,
            enabled: map['enabled'] ?? true,
            counterText: map['counterText'],
            counter: DynamicWidgetBuilder.buildFromMap(
                map['counter'], buildContext, listener),
            isDense: map['isDense'],
            errorStyle: parseTextStyle(map['errorStyle']),
            prefixStyle: parseTextStyle(map['prefixStyle']),
            suffixStyle: parseTextStyle(map['suffixStyle']),
            counterStyle: parseTextStyle(map['counterStyle']),
            errorMaxLines: map['errorMaxLines'],
      ),
    );
  }

  @override
  String get widgetName => "FormBuilderDatePicker";

  @override
  Type get widgetType => FormBuilderDatePicker;
}
