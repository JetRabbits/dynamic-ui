library dynamic_ui;

import 'package:dynamic_ui/handlers/handlers.dart';
import 'package:dynamic_ui/parsers/action_manager_parser.dart';
import 'package:dynamic_ui/parsers/date_picker_widget_parser.dart';
import 'package:dynamic_ui/parsers/divider_widget_parser.dart';
import 'package:dynamic_ui/parsers/file_picker_widget_parser.dart';
import 'package:dynamic_ui/parsers/fixed_sized_box_parser.dart';
import 'package:dynamic_ui/parsers/form_builder_dropdown_field_parser.dart';
import 'package:dynamic_ui/parsers/form_builder_parser.dart';
import 'package:dynamic_ui/parsers/form_builder_text_field_parser.dart';
import 'package:dynamic_ui/parsers/spacer_widget_parser.dart';
import 'package:dynamic_ui/parsers/template_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter_draft/flutter_draft.dart';
import 'package:get_it/get_it.dart';

import 'actions/http_action.dart';
import 'actions/launch_action.dart';
import 'actions/navigator_action.dart';
import 'blocs/actions_bloc/actions_bloc.dart';
import 'parsers/dynamic_text_form_widget_parser.dart';
import 'parsers/elevated_button_parser.dart';

export 'package:dynamic_ui/widgets/dynamic_processor.dart';
export 'package:dynamic_ui/widgets/dynamic_text_form_field.dart';
export 'package:dynamic_widget/dynamic_widget.dart';
export 'package:flutter_form_builder/flutter_form_builder.dart';

export 'actions/http_action.dart';
export 'actions/launch_action.dart';
export 'actions/navigator_action.dart';

void setupDynamics() {
  GetIt.I.registerSingleton(ActionsBloc());

  DynamicWidgetBuilder.addParser(ElevatedButtonParser());
  DynamicWidgetBuilder.addParser(FilePickerButtonParser());
  DynamicWidgetBuilder.addParser(DynamicTextFormFieldParser());
  DynamicWidgetBuilder.addParser(FormBuilderParser());
  DynamicWidgetBuilder.addParser(SpaceWidgetParser());
  DynamicWidgetBuilder.addParser(DividerWidgetParser());
  DynamicWidgetBuilder.addParser(FormBuilderDropDownParser());
  DynamicWidgetBuilder.addParser(FormBuilderTextFieldParser());
  DynamicWidgetBuilder.addParser(FormBuilderDatePickerParser());
  DynamicWidgetBuilder.addParser(FixedSizedBoxWidgetParser());
  DynamicWidgetBuilder.addParser(ActionManagerParser());
  DynamicWidgetBuilder.addParser(TemplateWidgetParser());

  HandlersRegistry.register("actions", ActionsHandler(GetIt.I()));

  ActionRegister.addAction('http', HttpAction.toJson, HttpAction.fromJson);
  ActionRegister.addAction(
      'launch', LaunchAction.toJson, LaunchAction.fromJson);
  ActionRegister.addAction(
      'navigator', NavigatorAction.toJson, NavigatorAction.fromJson);
}
