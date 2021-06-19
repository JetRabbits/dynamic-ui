import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import 'form_field_validators_parser.dart';

class FormBuilderTextFieldParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    FormBuilderTextField realWidget = widget as FormBuilderTextField;
    return <String, dynamic>{
      "type": widgetName,
      "obscureText": realWidget.obscureText,
      "initialValue": realWidget.initialValue,
      "minLines": realWidget.minLines,
      "maxLines": realWidget.maxLines,
      "autoValidateMode": realWidget.autovalidateMode.index,
      "name": realWidget.name,
      "validator":
          FormFieldValidatorParser.getRegisteredBuilder(realWidget.name)
              ?.toJson(),
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
      "style": exportTextStyle(realWidget.style),
      "errorStyle": exportTextStyle(realWidget.decoration.errorStyle),
      "counterStyle": exportTextStyle(realWidget.decoration.counterStyle),
      "helperStyle": exportTextStyle(realWidget.decoration.helperStyle),
      "hintStyle": exportTextStyle(realWidget.decoration.hintStyle),
      "prefixStyle": exportTextStyle(realWidget.decoration.prefixStyle),
      "suffixStyle": exportTextStyle(realWidget.decoration.suffixStyle),
      "labelStyle": exportTextStyle(realWidget.decoration.labelStyle),
      "errorMaxLines": realWidget.decoration.errorMaxLines,
      "isDense": realWidget.decoration.isDense,
      "textCapitalization": realWidget.textCapitalization.index,
    };
  }

  InputBorder? parseBorder(String borderKeyPrefix, Map<String, dynamic> map) {
    var type = map['borderType'];
    if (type != null) {
      switch (type) {
        case 'OutlineInputBorder':
          return OutlineInputBorder(
              borderSide: BorderSide(
                  style: map['borderStyle'] != null
                      ? BorderStyle.values[map['borderStyle']]
                      : BorderStyle.solid,
                  color: map[borderKeyPrefix + 'Color'],
                  width: map[borderKeyPrefix + 'Width']),
              borderRadius: BorderRadius.circular(map["borderRadius"]));
        case 'UnderlineInputBorder':
          return UnderlineInputBorder(
              borderSide: BorderSide(
                  style: map['borderStyle'] != null
                      ? BorderStyle.values[map['borderStyle']]
                      : BorderStyle.solid,
                  color: map[borderKeyPrefix + 'Color'],
                  width: map[borderKeyPrefix + 'Width']),
              borderRadius: BorderRadius.circular(map["borderRadius"]));
        default:
          throw 'Unsupported type of border $type';
      }
    }
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    return FormBuilderTextField(
        name: map['name'],
        autovalidateMode: map['autovalidateMode'] != null
            ? AutovalidateMode.values[map['autovalidateMode'] as int]
            : AutovalidateMode.disabled,
        initialValue: map['initialValue'],
        maxLines: map['maxLines'] != null ? map['maxLines'] as int : 1,
        minLines: map['minLines'] != null ? map['minLines'] as int : null,
        obscureText: map['obscureText'],
        textCapitalization: map['textCapitalization'] != null
            ? TextCapitalization.values[map['textCapitalization']]
            : TextCapitalization.none,
        style: parseTextStyle(map['style']),
        validator:
            FormFieldValidatorParser.fromJson(map['validator'], buildContext),
        decoration: InputDecoration(
          hintText: map['hintText'],
          labelText: map['labelText'],
          filled: map['filled'],
          fillColor: map['fillColor'],
          icon: DynamicWidgetBuilder.buildFromMap(
              map["decorationIcon"], buildContext, listener),
          enabledBorder: map['borderType'] != null
              ? parseBorder('enabledBorder', map)
              : null,
          border: map['borderType'] != null ? parseBorder('border', map) : null,
          errorBorder: map['borderType'] != null
              ? parseBorder('errorBorder', map)
              : null,
          enabled: map['enabled'],
          counterText: map['counterText'],
          counter: DynamicWidgetBuilder.buildFromMap(
              map['counter'], buildContext, listener),
          isDense: map['isDense'],
          errorStyle: parseTextStyle(map['errorStyle']),
          prefixStyle: parseTextStyle(map['prefixStyle']),
          suffixStyle: parseTextStyle(map['suffixStyle']),
          counterStyle: parseTextStyle(map['counterStyle']),
          errorMaxLines: map['errorMaxLines'],
        ));
  }

  @override
  String get widgetName => "FormBuilderTextField";

  @override
  Type get widgetType => FormBuilderTextField;
}
