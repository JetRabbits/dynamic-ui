import 'dart:convert';

import 'package:dynamic_ui/blocs/actions_bloc/actions_bloc.dart';
import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:dynamic_ui/utils/parameters_utils.dart';
import 'package:dynamic_ui/widgets/template_widget.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart' show BuildContext, Container;
import 'package:flutter_draft/flutter_draft.dart';
import 'package:get_it/get_it.dart';

class TemplateWidgetParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    TemplateWidget realWidget = widget as TemplateWidget;
    return <String, dynamic>{"type": widgetName, "child": realWidget.child};
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    return TemplateWidget(
        child: map['child'] != null
            ? DynamicWidgetBuilder.buildFromMap(
                jsonDecode(substituteParams(jsonEncode(map['child']),
                    GetIt.I<ActionsBloc>().state.data.context)),
                buildContext,
                listener)!
            : Container());
  }

  @override
  String get widgetName => "Template";

  @override
  Type get widgetType => TemplateWidget;
}
