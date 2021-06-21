import 'package:dynamic_ui/utils/uri_based_click_listener.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension MaterialStatePropertyColorExt on MaterialStateProperty {
  String? toHexString(MaterialState state){
    try {
      return this.resolve(Set.of([state])).value.toRadixString(16);
    } catch (e) {
      print('Can not resolve property $state to hex string');
    }
    return null;
  }
  String? toResolvedString(MaterialState state){
    try {
      return this.resolve(Set.of([state])).value.toString();
    } catch (e) {
      print('Can not resolve property $state to string');
    }
    return null;
  }
}

class ElevatedButtonParser extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    String? clickEvent =
        map.containsKey("click_event") ? map['click_event'] : "";

    GlobalKey _elevatedButtonKey = GlobalKey();
    var button = ElevatedButton(
      key: _elevatedButtonKey,
      style: ElevatedButton.styleFrom(
          primary:
              map.containsKey('color') ? parseHexColor(map['color']) : null,
          onPrimary: map.containsKey('textColor')
              ? parseHexColor(map['textColor'])
              : null,
          onSurface: map.containsKey('disabledTextColor')
              ? parseHexColor(map['disabledTextColor'])
              : null,
          elevation: map.containsKey('disabledElevation')
              ? map['disabledElevation']?.toDouble()
              : 0.0,
          padding: map.containsKey('padding')
              ? parseEdgeInsetsGeometry(map['padding'])
              : null,
          side: map['side'] != null
              ? BorderSide(
                  color: parseHexColor(map['side']!['color']) ?? const Color(0xFF000000),
                  width: map['side']!['width'] ?? 1.0): null),
      child: DynamicWidgetBuilder.buildFromMap(
          map['child'], buildContext, listener),
      onPressed: () {
        print('elevated button click');
        if (listener is UriBasedClickListener) {
          listener.parameters.putIfAbsent("context", () => buildContext);
          listener.parameters.putIfAbsent("buttonContext", () => _elevatedButtonKey.currentContext);
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

    return <String, dynamic>{
      "type": widgetName,
      "color": realWidget.style?.backgroundColor?.toHexString(MaterialState.selected),
      "textColor": realWidget.style?.foregroundColor?.toHexString(MaterialState.selected),
      "disabledColor": realWidget.style?.backgroundColor?.toHexString(MaterialState.disabled),
      "disabledTextColor": realWidget.style?.foregroundColor?.toHexString(MaterialState.disabled),
      "elevation": realWidget.style?.elevation?.toResolvedString(MaterialState.selected),
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext),
      "side": realWidget.style?.side != null
          ? {
              "color": realWidget.style!.side!
                  .resolve(Set.of([MaterialState.selected]))?.color
                  .value
                  .toRadixString(16),
              "width": realWidget.style!.side!
                  .resolve(Set.of([MaterialState.selected]))
                  ?.width
            }
          : null
    };
  }

  @override
  Type get widgetType => ElevatedButton;
}
