import 'package:dynamic_ui/dynamic_ui.dart';
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
      "hintText": realWidget.decoration.hintText,
      "labelText": realWidget.decoration.labelText,
      "decorationIcon": realWidget.decoration.icon,
      "validator": FormFieldValidatorParser.getRegisteredBuilder(realWidget.name)?.toJson(),
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext, ClickListener? listener) {
    return FormBuilderTextField(
      name: map['name'],
      autovalidateMode: map['autovalidateMode'] != null ? AutovalidateMode.values[map['autovalidateMode'] as int]: AutovalidateMode.disabled,
      initialValue: map['initialValue'],
      maxLines: map['maxLines'] != null ? map['maxLines'] as int : 1,
      minLines: map['minLines'] != null ? map['minLines'] as int : null,
      obscureText: map['obscureText'],
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(hintText: map['hintText'], labelText: map['labelText']),
      validator: FormFieldValidatorParser.fromJson(map['validator'], buildContext),
    );
  }

  @override
  String get widgetName => "FormBuilderTextField";

  @override
  Type get widgetType => FormBuilderTextField;
}