import 'dart:math';

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

  final PickerDialogStyle pickerDialogStyle;

  final Widget? closeButton;

  double? bottomSheetHeight;

  ///
  /// [dateFormat] DateFormat pattern see intl DateFormat for details
  ///
  FormBuilderDatePicker(
      {Key? key,
      required this.dateFormat,
      required this.labelText,
      this.errorText,
      this.pickerDialogStyle = PickerDialogStyle.BOTTOM_SHEET,
      this.bottomSheetHeight,
      required this.name,
      DateTime? initialValue,
      this.autovalidateMode = AutovalidateMode.disabled,
      this.closeButton})
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
                onPressed: () async {
                  switch (pickerDialogStyle) {
                    case PickerDialogStyle.BOTTOM_SHEET:
                      Scaffold.of(_rowKey.currentContext!).showBottomSheet(
                          (context) => _buildBottomSheet(context));
                      break;
                    case PickerDialogStyle.DIALOG:
                      DateTime? _value = await showDatePicker(
                          context: context,
                          initialDate: getValueDate(),
                          currentDate: DateTime.now(),
                          firstDate: DateTime(getValueDate().year),
                          lastDate: DateTime(getValueDate().year + 1));
                      _updateFormValue(_value);

                      break;
                  }
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

  DateTime getValueDate() {
    print("getValueDate");
    var formBuilderState = FormBuilder.of(_rowKey.currentContext!);
    var _value = formBuilderState?.value[name];
    print("${formBuilderState?.value}");
    print("$_value");

    if (_value is String && _value.isNotEmpty) {
      return DateFormat(dateFormat).parse(_value);
    }
    return DateTime.now();
  }

  Widget _buildBottomSheet(context) {
    return Container(
      height: bottomSheetHeight ?? max(MediaQuery.of(context).size.height / 3, 400),
      child: Column(
        children: [
          CalendarDatePicker(
            initialDate: getValueDate(),
            currentDate: DateTime.now(),
            onDateChanged: (value) {
              _updateFormValue(value);
              Navigator.of(context).pop();
            },
            firstDate: DateTime(getValueDate().year),
            lastDate: DateTime(getValueDate().year + 1),
          ),
          if (closeButton == null)
            SizedBox(
              height: 40,
              width: 145,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xFF1890FF)),
                onPressed: () => Navigator.of(context).pop(),
                child: Text('ЗАКРЫТЬ'),
              ),
            )
        ],
      ),
    );
  }

  void _updateFormValue(DateTime? value) {
    if (value == null) return;
    var formBuilderState = FormBuilder.of(_rowKey.currentContext!);
    formBuilderState?.patchValue({"$name": DateFormat(dateFormat).format(value)});
    formBuilderState?.save();
  }
}

enum PickerDialogStyle { BOTTOM_SHEET, DIALOG }
