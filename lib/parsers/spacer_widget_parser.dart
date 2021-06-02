import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class SpaceWidgetParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    Spacer realWidget = widget as Spacer;
    return <String, dynamic>{"flex": realWidget.flex};
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext, ClickListener? listener) {
    return Spacer(flex: map['flex'] != null ? map['flex']: null);
  }

  @override
  String get widgetName => "spacer";

  @override
  Type get widgetType => Spacer;

}