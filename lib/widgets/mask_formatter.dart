import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskFormatter extends MaskTextInputFormatter {
  final String mask;
  final Map<String, RegExp> filter;

  MaskFormatter({initialText, required this.mask, required this.filter})
      : super(initialText: initialText, mask: mask, filter: filter);
}
