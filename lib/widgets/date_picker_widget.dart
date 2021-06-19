import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class FormBuilderDatePicker extends StatelessWidget {
  final String labelText;

  final String name;

  final String? errorText;

  late DateTime initialValue;

  final String dateFormat;
  final GlobalKey _rowKey = GlobalKey();

  final AutovalidateMode autovalidateMode;

  final calendarTextWidget = GlobalKey<FormFieldState>();

  ///
  /// [dateFormat] DateFormat pattern see intl DateFormat for details
  ///
  FormBuilderDatePicker(
      {Key? key,
      required this.dateFormat,
      required this.labelText,
      this.errorText,
      required this.name,
      DateTime? initialValue,
      this.autovalidateMode = AutovalidateMode.disabled})
      : super(key: key) {
    this.initialValue = initialValue ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      key: _rowKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FormBuilderTextField(
            key: calendarTextWidget,
            autovalidateMode: autovalidateMode,
            name: name,
            initialValue: DateFormat(dateFormat).format(initialValue),
            readOnly: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                fillColor: Colors.white,
                filled: true),
          ),
        ),
        const SizedBox(width: 12),
        Material(
          child: SizedBox(
            height: 48,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Color(0xFF1890FF)),
                onPressed: () {
                  print(Scaffold.of(_rowKey.currentContext!));
                  Scaffold.of(_rowKey.currentContext!)
                      .showBottomSheet((context) => _buildBottomSheet(context));
                },
                icon: Icon(Icons.calendar_today),
                label: Text(
                  labelText,
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheet(context) {
    return Container(
      height: 400,
      child: Column(
        children: [
          CalendarDatePicker(
            initialDate: DateTime.now(),
            currentDate: DateTime.now(),
            onDateChanged: (value) {
              var formBuilderState = FormBuilder.of(_rowKey.currentContext!);
              formBuilderState
                  ?.patchValue({name: DateFormat(dateFormat).format(value)});
              Navigator.of(context).pop();
            },
            firstDate: DateTime(2021),
            lastDate: DateTime(2022),
          ),
          SizedBox(
            height: 40,
            width: 145,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Color(0xFF1890FF)),
              onPressed: () => Navigator.of(context).pop(),
              child: Text('ЗАКРЫТЬ'),
            ),
          )
        ],
      ),
    );
  }
}
