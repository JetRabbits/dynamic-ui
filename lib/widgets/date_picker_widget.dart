import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as pickers;

class DatePickerWidget extends StatefulWidget {
  final String labelText;

  final VoidCallback? onPressed;

  final String name;

  final String? errorText;

  late DateTime initialValue;

  DatePickerWidget(
      {Key? key, required this.labelText, this.onPressed, this.errorText, initialValue, required this.name})
      : super(key: key){
    this.initialValue = initialValue ?? DateTime.now();
  }

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FormBuilderTextField(name: widget.name,
            validator: FormBuilderValidators.dateString(
                context, errorText: widget.errorText),
            inputFormatters: [],
            initialValue: "$value"),
        ElevatedButton.icon(
            onPressed: () {
              Scaffold.of(context).showBottomSheet((context) =>
                  Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 3,
                      child: pickers.DayPicker.single(
                          selectedDate: widget.initialValue,
                          onChanged: (DateTime v) {
                            setState(() {
                              value = v;
                            });
                          },
                          firstDate: DateTime(widget.initialValue.year),
                          lastDate: DateTime(widget.initialValue.year, 12)),
              ));
            },
            icon: Icon(Icons.calendar_today),
            label: Text(widget.labelText)),
      ],
    );
  }
}
