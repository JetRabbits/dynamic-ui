import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FilePickerWidget extends StatefulWidget {
  final bool allowMultiple;
  final List<String>? allowedExtensions;
  final String? postUrl;

  final String promptChooseFile;

  final String? fileExampleUrl;

  final String? token;

  final String sendButtonText;

  FilePickerWidget(
      {Key? key,
      this.postUrl,
      this.promptChooseFile = "Выберите файл",
      this.sendButtonText = "Отправить",
      this.token,
      this.fileExampleUrl,
      this.allowMultiple = false,
      this.allowedExtensions})
      : super(key: key);

  @override
  _FilePickerWidgetState createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {

  FilePickerResult? result;
  int uploadProgress = 0;


  @override
  void dispose() {
    result = null;
    uploadProgress = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
      MainAxisAlignment.spaceAround,
      children: [
        buildFilePicker(),
        if (widget.fileExampleUrl != null)
          TextButton(
            onPressed: () => launch(widget.fileExampleUrl!),
            child: Text("Пример файла",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(decoration:
                    TextDecoration.underline)),
          ),
        SizedBox(
          width: 209,
          child: ElevatedButton(
              onPressed: widget.postUrl != null && result != null ? () => _doUpload() : null,
              child: Text(widget.sendButtonText)),
        )
      ],
    );
  }

  Widget buildFilePicker() {
    var title = widget.promptChooseFile;
    if (result != null && result!.files.length == 1)
      title = "${result!.files.first.name}";
    else if (result != null && result!.files.length > 1)
      title = "Выбранo файлов: ${result!.files.length}";

    return GestureDetector(
      onTap: () async => await _onChooseFile(),
      child: Container(
          child: Column(children: [
            Icon(Icons.insert_drive_file,
                color: Color(0xFF1890FF)),
            Text(title,
                style:
                const TextStyle(fontSize: 14))
          ]),
        ),
    );
  }

  Future<void> _onChooseFile() async {
    result = await FilePicker.platform.pickFiles(
        allowMultiple: widget.allowMultiple,
        type: widget.allowedExtensions != null && widget.allowedExtensions!.length > 0 ? FileType.custom: FileType.any,
        allowedExtensions: widget.allowedExtensions);
    setState(() {
    });
  }

  Future<void> _doUpload() async {

  }


}
