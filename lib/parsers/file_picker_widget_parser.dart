import 'package:dynamic_ui/utils/uri_based_click_listener.dart';
import 'package:dynamic_ui/widgets/file_picker_widget.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FilePickerButtonParser extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    String? clickEvent =
        map.containsKey("click_event") ? map['click_event'] : "";



    return FilePickerWidget(
      onFileChoosed: (FilePickerResult result) {
        if (listener is UriBasedClickListener) {
          var parameters = listener.parameters;
          parameters.clear();
          var files = result.files.map((file) => {file.name : file.bytes}).toList();
          parameters.putIfAbsent("files", () => files);
        }
      },
      onPressed: listener != null ? () => listener.onClicked(clickEvent) : null,
      promptChooseFile: map['promptChooseFile'],
      sendButtonText: map['sendButtonText'],
      fileExampleUrl: map['fileExampleUrl'],
      allowedExtensions:
          (map['allowedExtensions'] as List<dynamic>).cast<String>(),
      allowMultiple: map['allowMultiple'],
    );
  }

  @override
  String get widgetName => "FilePickerWidget";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as FilePickerWidget;

    return <String, dynamic>{
      "type": widgetName,
      "promptChooseFile": realWidget.promptChooseFile,
      "sendButtonText": realWidget.sendButtonText,
      "fileExampleUrl": realWidget.fileExampleUrl,
      "allowedExtensions": realWidget.allowedExtensions,
      "allowMultiple": realWidget.allowMultiple
    };
  }

  @override
  Type get widgetType => FilePickerWidget;
}
