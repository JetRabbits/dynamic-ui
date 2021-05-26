import 'dart:developer';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

///
/// Process one by one user tasks from bmpn server
///
class DynamicProcessor extends StatefulWidget {
  final Function(String? event) onEvent;
  final String initialJson;

  DynamicProcessor({Key? key, this.initialJson = "{}", required this.onEvent})
      : super(key: key);

  @override
  _DynamicProcessorState createState() => _DynamicProcessorState();
}

class _DynamicProcessorState extends State<DynamicProcessor>
    with ClickListener {
  late String currentJson;

  @override
  void initState() {
    currentJson = widget.initialJson;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Widget>(
        future: _buildWidget(context),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? SizedBox.expand(
                  child: snapshot.data,
                )
              : CircularProgressIndicator();
        },
      ),
    );
  }

  Future<Widget> _buildWidget(BuildContext context) async {
    try {
      return DynamicWidgetBuilder.build(currentJson, context, this) ??
          Container();
    } catch (e, stacktrace) {
      log('Error during build dynamic content $e',
          name: "DynamicProcessor",
          level: Level.SEVERE.value,
          error: e,
          stackTrace: stacktrace);
      return Center(child: Text("Ошибка построения динамического контента"));
    }
  }

  @override
  void onClicked(String? event) => widget.onEvent(event);
}
