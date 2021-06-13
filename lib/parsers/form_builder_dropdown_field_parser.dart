import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import 'form_field_validators_parser.dart';

class FormBuilderDropDownParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    FormBuilderDropdown realWidget = widget as FormBuilderDropdown;
    return <String, dynamic>{
      "type": widgetName,
      "initialValue": realWidget.initialValue,
      "items": realWidget.items.map((e) => e.toString()).toList(),
      "autoValidateMode": realWidget.autovalidateMode.index,
      "name": realWidget.name,
      "validator": FormFieldValidatorParser.toJson(realWidget.validator),
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    return FormBuilderDropdown<String>(
      name: map['name'],
      autovalidateMode: map['autovalidateMode'] != null
          ? AutovalidateMode.values[map['autovalidateMode'] as int]
          : AutovalidateMode.disabled,
      initialValue: map['initialValue'],
      validator:
          FormFieldValidatorParser.fromJson(map['validator'], buildContext),
      items: (map['items'] as List)
          .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
              value: e.toString(), child: Text(e.toString())))
          .toList(),
    );
  }

  @override
  String get widgetName => "FormBuilderDropdown";

  @override
  Type get widgetType => FormBuilderDropdown;
}
