import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:dynamic_ui/widgets/file_picker_widget.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormFieldValidatorParser {
  static dynamic toJson(FormFieldValidator<String> value) {
    if (value == FormBuilderValidators.required){
      return {'type': 'required', 'errorText': ''};
    }

  }
  static FormFieldValidator<String> fromJson(dynamic json, BuildContext context) {
    String type = json['type']!;
    String errorText = json['errorText'];
    switch (type){
      case 'required':
        return FormBuilderValidators.required(
            context,
            errorText: errorText);
      case 'max':
        return FormBuilderValidators.max(context, json['value'] as num, inclusive: json['inclusive'], errorText: errorText);
      case 'min':
        return FormBuilderValidators.min(context, json['value'] as num, inclusive: json['inclusive'], errorText: errorText);
      case 'minLength':
        return FormBuilderValidators.minLength(context, json['value'] as int, allowEmpty: json['allowEmpty'], errorText: errorText);
      case 'maxLength':
        return FormBuilderValidators.maxLength(context, json['value'] as int, errorText: errorText);
      case 'creditCard':
        return FormBuilderValidators.creditCard(context, errorText: errorText);
      case 'match':
        return FormBuilderValidators.match(context, json['value'], errorText: errorText);
      case 'dateString':
        return FormBuilderValidators.dateString(context, errorText: errorText);
      case 'match':
        return FormBuilderValidators.email(context, errorText: errorText);
      case 'equal':
        return FormBuilderValidators.equal(context, json['value'], errorText: errorText);
      case 'integer':
        return FormBuilderValidators.integer(context, errorText: errorText);
      case 'numeric':
        return FormBuilderValidators.numeric(context, errorText: errorText);
      case 'notEqual':
        return FormBuilderValidators.notEqual(context, json['value'], errorText: errorText);
      case 'url':
        return FormBuilderValidators.url(context, errorText: errorText);
      default:
        throw 'Not corrected validator';
    }
  }
}

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
            validators: [ ... (map['validators'] as List<dynamic>).where((element) => element !=null).map((s) => FormFieldValidatorParser.fromJson(s, buildContext))],
            maxLines: map['maxLines'] != null ? map['maxLines'] as int : null,
            minLines: map['minLines'] != null ? map['minLines'] as int : null,
            width: map['width'] != null ? map['width'] as double : null,
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
      "validators": [ ... realWidget.validators!.map((e) => FormFieldValidatorParser.toJson(e))],
    };
  }

  @override
  Type get widgetType => DynamicTextFormField;
}


