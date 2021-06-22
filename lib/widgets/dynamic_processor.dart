import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

///
/// Process one by one user tasks from bmpn server
///
class DynamicProcessor extends StatefulWidget {
  final Function(String? event) onEvent;
  final String initialJson;
  final ClickListener clickListener;

  final Widget? errorWidget;

  DynamicProcessor(
      {Key? key,
      this.initialJson = "{}",
      required this.onEvent,
      required this.clickListener,
      this.errorWidget})
      : super(key: key);

  @override
  _DynamicProcessorState createState() => _DynamicProcessorState();
}

class _DynamicProcessorState extends State<DynamicProcessor> {
  late String currentJson;

  static final Logger _logger = Logger("DynamicProcessor");

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
              : const CircularProgressIndicator();
        },
      ),
    );
  }

  Future<Widget> _buildWidget(BuildContext context) async {
    try {
      _logger.info("currentJson: \n$currentJson");
      return DynamicWidgetBuilder.build(
              currentJson, context, widget.clickListener) ??
          Container();
    } catch (e, stacktrace) {
      print(stacktrace);
      _logger.severe('Error during build dynamic content $e', e, stacktrace);
      return Center(
          child: widget.errorWidget ??
              Text(
                "Problem with dynamic content: $stacktrace",
                maxLines: 100,
              ));
    }
  }

  @override
  void onClicked(String? event) => widget.onEvent(event);
}
