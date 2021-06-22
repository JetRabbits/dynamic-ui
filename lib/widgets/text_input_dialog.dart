import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        ElevatedButton,
        MaterialPageRoute,
        Scaffold,
        StatelessWidget,
        Widget;
import 'package:flutter/widgets.dart';
import 'package:flutter_draft/flutter_draft.dart';
import 'package:logging/logging.dart';

class TextInputDialog extends StatefulWidget {
  static final logger = Logger('TextInputDialog');
  final FormBuilderTextField child;

  const TextInputDialog({Key? key, required this.child}) : super(key: key);

  @override
  _TextInputDialogState createState() =>
      _TextInputDialogState(child.initialValue ?? "");
}

class _TextInputDialogState extends State<TextInputDialog> {
  String value;

  final GlobalKey<FormBuilderState> _form = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {

    return FormBuilderTextField(
        onTap: () async {
          var result = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => buildDialogPage()));
          print(result);
          setState(() {
            FormBuilder.of(context)!.patchValue({widget.child.name: result});
            value = result.toString();
          });
        },
        name: widget.child.name,
        validator: widget.child.validator,
        maxLines: widget.child.maxLines,
        enabled: widget.child.enabled,
        decoration: widget.child.decoration);
  }

  Widget buildDialogPage() {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            FormBuilder(key: _form, child: widget.child),
            ElevatedButton(onPressed: _onSaved, child: Text('СОХРАНИТЬ'))
          ],
        ),
      )),
    );
  }

  _TextInputDialogState(this.value);

  _onSaved() {
    if (_form.currentState!.saveAndValidate()) {
      Navigator.of(context).pop(_form.currentState!.value[widget.child.name]);
    }
  }
}
