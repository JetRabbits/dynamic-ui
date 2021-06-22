import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:flutter/widgets.dart';

class FormFieldValidatorBuilder {
  final String type;
  final String? errorText;
  final List<FormFieldValidatorBuilder>? children;
  final dynamic value;

  FormFieldValidatorBuilder(
      {required this.type, this.children, this.errorText, this.value});

  FormFieldValidator<String?> build(BuildContext context) {
    switch (type) {
      case 'compose':
        return FormBuilderValidators.compose(children!
            .map<FormFieldValidator<String>>((v) => v.build(context))
            .toList());
      case 'required':
        return FormBuilderValidators.required(context, errorText: errorText);
      case 'url':
        return FormBuilderValidators.url(context, errorText: errorText);
      case 'notEqual':
        return FormBuilderValidators.notEqual(context, value,
            errorText: errorText);
      case 'equal':
        return FormBuilderValidators.equal(context, value,
            errorText: errorText);
      case 'dateString':
        return FormBuilderValidators.dateString(context, errorText: errorText);
      case 'min':
        return FormBuilderValidators.min(context, value as num,
            errorText: errorText);
      case 'max':
        return FormBuilderValidators.max(context, value as num,
            errorText: errorText);
      case 'minLength':
        return FormBuilderValidators.minLength(context, value as int,
            errorText: errorText);
      case 'maxLength':
        return FormBuilderValidators.maxLength(context, value as int,
            errorText: errorText);
      case 'creditCard':
        return FormBuilderValidators.creditCard(context, errorText: errorText);
      case 'match':
        return FormBuilderValidators.match(context, value.toString(),
            errorText: errorText);
      case 'email':
        return FormBuilderValidators.email(context, errorText: errorText);
      case 'integer':
        return FormBuilderValidators.integer(context, errorText: errorText);
      case 'numeric':
        return FormBuilderValidators.numeric(context, errorText: errorText);
      default:
        throw "Validator of type: '$type' unsupported";
    }
  }

  dynamic toJson() {
    switch (type) {
      case 'compose':
        return {
          'children': children!.map<dynamic>((v) => v.toJson()).toList(),
          'type': type
        };
      case 'notEqual':
      case 'equal':
      case 'min':
      case 'max':
      case 'maxLength':
      case 'minLength':
      case 'match':
        return {'type': type, 'value': value, 'errorText': errorText};
      default:
        return {'type': type, 'errorText': errorText};
    }
  }
}

class FormFieldValidatorParser {
  static final Map<String, FormFieldValidatorBuilder>
      formFieldValidatorBuilders = {};

  static FormFieldValidatorBuilder? getRegisteredBuilder(String name) =>
      formFieldValidatorBuilders[name];

  static FormFieldValidatorBuilder register(
      String fieldName, FormFieldValidatorBuilder builder) {
    return formFieldValidatorBuilders[fieldName] = builder;
  }

  static dynamic toJson(FormFieldValidatorBuilder builder) {
    return builder.toJson();
  }

  static FormFieldValidator<String>? fromJson(
      dynamic json, BuildContext context) {
    if (json == null || json['type'] == null) return null;
    return FormFieldValidatorBuilder(
            type: json['type'],
            children: (json['children'] as List)
                .map<FormFieldValidatorBuilder>((e) =>
                    FormFieldValidatorBuilder(
                        type: e['type'],
                        value: e['value'],
                        errorText: e['errorText']))
                .toList(),
            value: json['value'])
        .build(context);
  }
}
