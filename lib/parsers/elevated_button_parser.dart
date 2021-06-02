import 'package:dynamic_ui/utils/uri_based_click_listener.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ElevatedButtonParser extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    String? clickEvent =
    map.containsKey("click_event") ? map['click_event'] : "";

    var button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: map.containsKey('color') ? parseHexColor(map['color']) : null,
        onPrimary: map.containsKey('textColor') ? parseHexColor(map['textColor']) : null,
        onSurface: map.containsKey('disabledColor') ? parseHexColor(map['disabledColor']) : null,
        elevation: map.containsKey('disabledElevation')
            ? map['disabledElevation']?.toDouble()
            : 0.0,
        padding: map.containsKey('padding')
            ? parseEdgeInsetsGeometry(map['padding'])
            : null,
      ),
      child: DynamicWidgetBuilder.buildFromMap(
          map['child'], buildContext, listener),
      onPressed: () {
        if (listener is UriBasedClickListener){
          listener.parameters.putIfAbsent("context", () => buildContext);
        }
        listener!.onClicked(clickEvent);
      },
    );

    return button;
  }

  @override
  String get widgetName => "ElevatedButton";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as ElevatedButton;
    var padding = realWidget.style?.padding as EdgeInsets?;

    return <String, dynamic>{
      "type": widgetName,
      "color": realWidget.style?.backgroundColor != null
          ? realWidget.style!.backgroundColor!.resolve(Set.of([MaterialState.selected]))?.value.toRadixString(16)
          : null,
      // "disabledColor": realWidget.style?.foregroundColor != null
      //     ? realWidget.disabledColor!.value.toRadixString(16)
      //     : null,
      // "disabledElevation": realWidget.style?.elevation.resolve(realWidget.s),
      // "disabledTextColor": realWidget.disabledTextColor != null
      //     ? realWidget.disabledTextColor!.value.toRadixString(16)
      //     : null,
      // "elevation": realWidget.elevation,
      // "padding": padding != null
      //     ? "${padding.left},${padding.top},${padding.right},${padding.bottom}"
      //     : null,
      // "textColor": realWidget.style.foregroundColor.resolve(()) != null
      //     ? realWidget.textColor!.value.toRadixString(16)
      //     : null,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => ElevatedButton;
}


