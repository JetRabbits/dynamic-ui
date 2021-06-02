import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class DividerWidgetParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    Divider realWidget = widget as Divider;
    return <String, dynamic>{
      "height": realWidget.height,
      "thickness": realWidget.thickness,
      "indent": realWidget.indent,
      "endIndent": realWidget.endIndent,
      "color": realWidget.color != null
          ? realWidget.color!.value.toRadixString(16)
          : null,
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    return Divider(
      height: map['height'] != null ? map['flex'] : null,
      thickness: map['thickness'] != null ? map['thickness'] : null,
      indent: map['indent'] != null ? map['indent'] : null,
      endIndent: map['endIndent'] != null ? map['endIndent'] : null,
      color: map.containsKey('color') ? parseHexColor(map['color']) : null,
    );
  }

  @override
  String get widgetName => "divider";

  @override
  Type get widgetType => Divider;
}
