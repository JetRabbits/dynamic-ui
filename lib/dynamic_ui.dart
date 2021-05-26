library dynamic_ui;

import 'package:dynamic_ui/parsers/file_picker_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'parsers/elevated_button_parser.dart';

void setupDynamics(){
  DynamicWidgetBuilder.addParser(ElevatedButtonParser());
  DynamicWidgetBuilder.addParser(FilePickerButtonParser());
}