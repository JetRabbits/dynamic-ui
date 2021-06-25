import 'package:dynamic_ui/widgets/mask_formatter.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

InputBorder? parseBorder(String borderKeyPrefix, Map<String, dynamic> map) {
  var type = map['borderType'];
  if (type == null) return null;
  switch (type) {
    case 'OutlineInputBorder':
      return OutlineInputBorder(
          borderSide: BorderSide(
              style: map['borderStyle'] != null
                  ? BorderStyle.values[map['borderStyle']]
                  : BorderStyle.solid,
              color: parseHexColor(map[borderKeyPrefix + 'Color']) ??
                  Colors.black,
              width: map[borderKeyPrefix + 'Width']?.toDouble() ?? 1.0),
          borderRadius:
          BorderRadius.circular(map["borderRadius"]?.toDouble() ?? 1.0));
    case 'UnderlineInputBorder':
      return UnderlineInputBorder(
          borderSide: BorderSide(
              style: map['borderStyle'] != null
                  ? BorderStyle.values[map['borderStyle']]
                  : BorderStyle.solid,
              color: parseHexColor(map[borderKeyPrefix + 'Color']) ??
                  Colors.black,
              width: map[borderKeyPrefix + 'Width']?.toDouble() ?? 1.0),
          borderRadius:
          BorderRadius.circular(map["borderRadius"]?.toDouble() ?? 1.0));
    default:
      throw 'Unsupported type of border $type';
  }
}

Map<String, RegExp> _mapOfFilter(dynamic inputMap) {
  Map<String, RegExp> result = <String, RegExp>{};
  (inputMap as Map<String, dynamic>).forEach((key, value) {
    result[key] = RegExp(value);
  });
  return result;
}

dynamic formattersToJson(List<TextInputFormatter>? formatters) =>
    formatters?.map((formatter) {
      if (formatter is LengthLimitingTextInputFormatter){
        return {"type": "max", "value": formatter.maxLength};
      }

      if (formatter is MaskFormatter){
        return {"type": "mask", "value": formatter.getMask(), "filter": formatter.filter.cast<String, dynamic>()};
      }

      throw "Unsupported type '${formatter.runtimeType}";
    }).toList();


List<TextInputFormatter> parseInputFormatters(String initialValue, List<dynamic> formatters) {
  List<TextInputFormatter> result = [];
  for (var f in formatters){
    var type = f['type'];
    switch (type){
      case 'mask':
        result.add(MaskFormatter(mask: f['value'], filter: _mapOfFilter(f['filters']), initialText: initialValue));
        break;
      case 'max':
        result.add(LengthLimitingTextInputFormatter(f['value']));
        break;
      default:
        throw "Unsupported type of formatter '$type'";
    }
  }
  return result;
}
