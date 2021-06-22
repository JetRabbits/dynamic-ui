import 'package:dynamic_ui/dynamic_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DynamicTextFormField extends StatefulWidget {
  final String name;
  final String? title;
  final String? initialValue;
  final AutovalidateMode? autoValidateMode;
  final List<FormFieldValidator<String>>? validators;

  final TextInputAction? textInputAction;

  final double? width;

  final int? minLines;

  final int? maxLines;

  final bool? obscureText;

  final TextCapitalization? textCapitalization;

  final InputDecoration? decoration;

  DynamicTextFormField(
      {Key? key,
      required this.name,
      this.title,
      this.initialValue,
      this.validators,
      this.textInputAction,
      this.width,
      this.autoValidateMode,
      this.minLines,
      this.maxLines,
      this.obscureText,
      this.textCapitalization,
      this.decoration})
      : super(key: key);

  @override
  _DynamicTextFormFieldState createState() => _DynamicTextFormFieldState();
}

class _DynamicTextFormFieldState extends State<DynamicTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.title!),
            ),
          FormBuilderTextField(
              //From Super
              name: widget.name,
              // validator: widget.validator,
              initialValue: widget.initialValue,
              // readOnly: widget.readOnly,
              // onChanged: widget.onChanged,
              // valueTransformer: widget.valueTransformer,
              // enabled: widget.enabled,
              // onSaved: widget.onSaved,
              autovalidateMode:
                  widget.autoValidateMode ?? AutovalidateMode.disabled,
              //onReset:,
              //focusNode:,
              maxLines: widget.maxLines ?? 1,
              obscureText: widget.obscureText ?? false,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              //scrollPadding: const EdgeInsets.all(20.0),
              //enableInteractiveSelection: = true,
              //maxLengthEnforcement:,
              //textAlign: = TextAlign.start,
              //autofocus: = false,
              //this.autocorrect = true,
              //this.cursorWidth = 2.0,
              //this.keyboardType,
              //this.style,
              //this.controller,
              // this.textInputAction,
              // this.strutStyle,
              // this.textDirection,
              // this.maxLength,
              // this.onEditingComplete,
              // this.onSubmitted,
              // this.inputFormatters,
              // this.cursorRadius,
              // this.cursorColor,
              // this.keyboardAppearance,
              // this.buildCounter,
              // this.expands = false,
              minLines: widget.minLines,
              // this.showCursor,
              // this.onTap,
              // this.enableSuggestions = false,
              // this.textAlignVertical,
              // this.dragStartBehavior = DragStartBehavior.start,
              // this.scrollController,
              // this.scrollPhysics,
              // this.selectionWidthStyle = ui.BoxWidthStyle.tight,
              // this.smartDashesType,
              // this.smartQuotesType,
              // this.toolbarOptions,
              // this.selectionHeightStyle = ui.BoxHeightStyle.tight,
              // this.autofillHints,
              // this.obscuringCharacter = '•',
              // this.mouseCursor
              validator: FormBuilderValidators.compose(
                  widget.validators ?? <FormFieldValidator<String>>[]),
              decoration: widget.decoration ?? const InputDecoration()),
        ],
      ),
    );
  }
}
