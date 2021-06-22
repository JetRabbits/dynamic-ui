import 'package:dynamic_ui/handlers/handlers.dart';
import 'package:dynamic_widget/dynamic_widget.dart';

class UriBasedClickListener extends ClickListener {
  final HandlerProcessor handlerProcessor;

  UriBasedClickListener(this.handlerProcessor);

  final Map<String, dynamic> parameters = {};

  @override
  void onClicked(String? event) {
    if (event != null) {
      var commands = event.split(";").map<Uri>((s) => Uri.parse(s)).toList();
      handlerProcessor.process(commands, parameters);
    }
  }
}
