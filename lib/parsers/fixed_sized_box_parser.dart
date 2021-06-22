import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:flutter/widgets.dart';

class FixedSizedBoxWidgetParser extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    return SizedBox(
      width: map["width"]?.toDouble(),
      height: map["height"]?.toDouble(),
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }

  @override
  String get widgetName => "SizedBox";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as SizedBox;
    return <String, dynamic>{
      "type": "SizedBox",
      "width": realWidget.width,
      "height": realWidget.height,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => SizedBox;
}
