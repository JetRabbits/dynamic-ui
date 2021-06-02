library dynamic_ui;

import 'package:dynamic_ui/handlers/handlers.dart';
import 'package:dynamic_ui/parsers/divider_widget_parser.dart';
import 'package:dynamic_ui/parsers/file_picker_widget_parser.dart';
import 'package:dynamic_ui/parsers/form_builder_parser.dart';
import 'package:dynamic_ui/parsers/spacer_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget.dart';

import 'parsers/dynamic_text_form_widget_parser.dart';
import 'parsers/elevated_button_parser.dart';

export 'package:dynamic_ui/widgets/dynamic_processor.dart';
export 'package:dynamic_ui/widgets/dynamic_text_form_field.dart';
export 'package:dynamic_widget/dynamic_widget.dart';
export 'package:flutter_form_builder/flutter_form_builder.dart';

void setupDynamics() {
  DynamicWidgetBuilder.addParser(ElevatedButtonParser());
  DynamicWidgetBuilder.addParser(FilePickerButtonParser());
  DynamicWidgetBuilder.addParser(DynamicTextFormFieldParser());
  DynamicWidgetBuilder.addParser(FormBuilderParser());
  DynamicWidgetBuilder.addParser(SpaceWidgetParser());
  DynamicWidgetBuilder.addParser(DividerWidgetParser());
}

