import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FilePickerButton extends StatefulWidget {
  final Widget child;
  final bool allowMultiple;
  final List<String>? allowedExtensions;
  final Map<String, dynamic>? resultMap;

  FilePickerButton(
      {Key? key,
      required this.child,
      this.resultMap,
      this.allowMultiple = false,
      this.allowedExtensions})
      : super(key: key);

  @override
  _FilePickerButtonState createState() => _FilePickerButtonState();
}

class _FilePickerButtonState extends State<FilePickerButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
              allowMultiple: widget.allowMultiple,
              type: FileType.any,
              allowedExtensions: widget.allowedExtensions);
          if (result != null) {

          } else {
            log('User canceled the file picker', name: 'FilePickerButton');
          }
        },
        child: widget);
  }
}
