import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:flutter/widgets.dart';

class FormFieldValidatorHolder {

  final FormFieldValidator validator;
  final String? errorText;
  dynamic toJson(){

  }
  FormFieldValidatorHolder(this.validator, this.errorText);

}

class FormFieldValidatorParser {
  static dynamic toJson(FormFieldValidator<String>? validator, ) {
    if (validator == FormBuilderValidators.required) {
      return {'type': 'required', 'errorText': ''};
    }
    if (validator == FormBuilderValidators.compose) {
      return {'type': 'compose', 'validators' : [] };
    }
    if (validator == FormBuilderValidators.url) {
      return {'type': 'url', 'errorText': 'Требуется поле типа URL'};
    }
    if (validator == FormBuilderValidators.notEqual) {
      return {'type': 'notEqual', 'errorText': 'Поле не равно значению'};
    }
    if (validator == FormBuilderValidators.equal) {
      return {'type': 'equal', 'errorText': 'Поле должно быть равно значению'};
    }
    if (validator == FormBuilderValidators.dateString) {
      return {'type': 'equal', 'errorText': 'Требуется поле дата'};
    }
    if (validator == FormBuilderValidators.min) {
      return {'type': 'min', 'value': 0, 'errorText': 'Минимальное значение'};
    }
    if (validator == FormBuilderValidators.max) {
      return {'type': 'max', 'value': 10, 'errorText': 'Максимальное значение'};
    }
    if (validator == FormBuilderValidators.minLength) {
      return {'type': 'minLength', 'value': 10, 'errorText': 'Минимальная длина'};
    }
    if (validator == FormBuilderValidators.maxLength) {
      return {'type': 'maxLength', 'value': 10, 'errorText': 'Максимальное длина'};
    }
    if (validator == FormBuilderValidators.creditCard) {
      return {'type': 'creditCard', 'errorText': 'Максимальное длина'};
    }
    if (validator == FormBuilderValidators.match) {
      return {'type': 'match', 'value': '', 'errorText': 'Неверный формат'};
    }
    if (validator == FormBuilderValidators.dateString) {
      return {'type': 'dateString', 'errorText': 'Требуется ввести дату'};
    }
    if (validator == FormBuilderValidators.email) {
      return {'type': 'email', 'errorText': 'Требуется ввести почту'};
    }
    if (validator == FormBuilderValidators.integer) {
      return {'type': 'integer', 'errorText': 'Требуется ввести целое число'};
    }
    if (validator == FormBuilderValidators.numeric) {
      return {'type': 'numeric', 'errorText': 'Требуется ввести число'};
    }
    return null;
  }

  static FormFieldValidator<String> fromJson(
      dynamic json, BuildContext context) {
    String type = json['type']!;
    String errorText = json['errorText'];
    switch (type) {
      case 'compose':
        return FormBuilderValidators.compose((json['validators'] as List)
            .map<FormFieldValidator<String>>(
                (e) => FormFieldValidatorParser.fromJson(e, context))
            .toList());
      case 'required':
        return FormBuilderValidators.required(context, errorText: errorText);
      case 'max':
        return FormBuilderValidators.max(context, json['value'] as num,
            inclusive: json['inclusive'], errorText: errorText);
      case 'min':
        return FormBuilderValidators.min(context, json['value'] as num,
            inclusive: json['inclusive'], errorText: errorText);
      case 'minLength':
        return FormBuilderValidators.minLength(context, json['value'] as int,
            allowEmpty: json['allowEmpty'], errorText: errorText);
      case 'maxLength':
        return FormBuilderValidators.maxLength(context, json['value'] as int,
            errorText: errorText);
      case 'creditCard':
        return FormBuilderValidators.creditCard(context, errorText: errorText);
      case 'match':
        return FormBuilderValidators.match(context, json['value'],
            errorText: errorText);
      case 'dateString':
        return FormBuilderValidators.dateString(context, errorText: errorText);
      case 'match':
        return FormBuilderValidators.email(context, errorText: errorText);
      case 'equal':
        return FormBuilderValidators.equal(context, json['value'],
            errorText: errorText);
      case 'integer':
        return FormBuilderValidators.integer(context, errorText: errorText);
      case 'numeric':
        return FormBuilderValidators.numeric(context, errorText: errorText);
      case 'notEqual':
        return FormBuilderValidators.notEqual(context, json['value'],
            errorText: errorText);
      case 'url':
        return FormBuilderValidators.url(context, errorText: errorText);
      default:
        throw 'Not corrected validator';
    }
  }
}
