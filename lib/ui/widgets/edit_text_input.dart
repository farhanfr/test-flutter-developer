import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:test_flutter_developer_enterkomputer/utils/colors.dart';
import 'package:test_flutter_developer_enterkomputer/utils/textstyles.dart';


enum InputType {
  text,
  password,
  search,
  field,
  phone,
  number,
  option,
  price,
  benefit
}

class EditTextInput extends StatefulWidget {
  final String? hintText;
  final String? initialValue;
  final InputType inputType;
  final TextEditingController? controller;
  final Function(String val)? onChanged;
  final Function(String val)? onFieldSubmitted;
  final String? Function(String? val)? validator;
  final AutovalidateMode? autoValidateMode;
  final TextInputType? keyboardType;
  final String? prefixText;
  final TextAlign? textAlign;
  final bool enabled;
  final Color fillColor;
  final void Function()? onTap;
  final bool? isLoading;
  final bool? autofocus;
  final bool? readOnly;
  final bool? isDense;
  final bool? isHint;
  final Widget? prefixIcons;
  final Widget? suffixIcons;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatter;
  final FocusNode? focusNode;

  const EditTextInput({
    Key? key,
    @required this.hintText,
    this.inputType = InputType.text,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.prefixText,
    this.textAlign,
    this.enabled = true,
    this.fillColor = textPrimaryInverted,
    this.onTap,
    this.isLoading = false,
    this.autofocus = false,
    this.readOnly = false,
    this.isDense = false,
    this.isHint,
    this.padding,
    this.textStyle,
    this.maxLength,
    this.inputFormatter,
    this.onFieldSubmitted,
    this.initialValue,
    this.focusNode,
    this.validator,
    this.prefixIcons,
    this.suffixIcons,
    this.autoValidateMode = AutovalidateMode.disabled,
  }) : super(key: key);

  @override
  _EditTextInputState createState() => _EditTextInputState();
}

class _EditTextInputState extends State<EditTextInput> {
  bool? _obscureText;
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.inputType == InputType.password ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatter,
      autofocus: widget.autofocus!,
      onTap: widget.onTap,
      readOnly: widget.inputType == InputType.option || widget.readOnly == true,
      focusNode:  _focus,
      textAlign:  TextAlign.start,
      maxLength: widget.maxLength,
      maxLines: widget.inputType == InputType.field
          ? 5
          : widget.inputType == InputType.benefit
              ? 2
              : 1,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      autovalidateMode: widget.autoValidateMode,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      initialValue: widget.initialValue,
      controller: widget.controller,
      style: widget.textStyle != null
          ? widget.enabled
              ? widget.textStyle!.copyWith(color: Colors.black)
              : widget.textStyle!.copyWith(color: Colors.grey)
          : widget.enabled
              ? body2.copyWith(color: Colors.black)
              : body2.copyWith(color: Colors.grey),
      obscureText: _obscureText!,
      decoration: InputDecoration(
          counter: SizedBox.shrink(),
          isDense: widget.isDense,
          errorMaxLines: 2,
          prefixIcon: widget.inputType == InputType.price
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8))),
                  child: Padding(
                      padding: EdgeInsets.only(top: 13, left: 17, bottom: 15),
                      child: Text(
                        'Rp',
                        style: body2.copyWith(color: grey),
                      )),
                )
              : widget.inputType == InputType.phone
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(16, 15, 5, 14),
                      child: Text(
                        '+62  |',
                        style: body2.copyWith(color: Colors.grey),
                      ))
                  : widget.prefixIcons,
          // prefixIcon: ,
          contentPadding: 
              EdgeInsets.fromLTRB(
                  10,
                  14,
                  widget.inputType == InputType.password ||
                          widget.inputType == InputType.option ||
                          widget.inputType == InputType.search
                      ? 4
                      : 20,
                  14),
          hintText: widget.inputType == InputType.phone && _focus.hasFocus
              ? null
              : widget.hintText,
          hintStyle: widget.isHint == false
              ? null
              : TextStyle(
                  fontFamily: "Lato",
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: inactiveSwitch,
                ),
          filled: true,
          fillColor: widget.enabled ? widget.fillColor : Color(0xFFF3F6F9),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: editText, width: 0.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: silverFlashSale,
                width: widget.inputType != InputType.search ? 1 : 0),
          ),
          enabled: widget.enabled,
          focusedBorder: OutlineInputBorder(
            borderRadius: !context.isPhone
                ? BorderRadius.circular(8)
                : BorderRadius.circular(8),
            borderSide: BorderSide(color: lightGrey, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: !context.isPhone
                ? BorderRadius.circular(8)
                : BorderRadius.circular(8),
            borderSide: BorderSide(color: danger, width: 0.8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: !context.isPhone
                ? BorderRadius.circular(8)
                : BorderRadius.circular(8),
            borderSide: BorderSide(color: danger, width: 0.8),
          ),
          suffixIcon: widget.isLoading!
              ? SizedBox(
                  width: 0,
                  height: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: CircularProgressIndicator(color: primary),
                  ))
              : widget.inputType == InputType.password ||
                      widget.inputType == InputType.option
                  ? Container(
                      margin: EdgeInsets.only(right: 15),
                      child:  GestureDetector(
                        onTap: widget.inputType == InputType.password
                            ? () => setState(() => _obscureText = !_obscureText!)
                            : null,
                        child: widget.inputType == InputType.password
                            ?  Icon(
                                _obscureText!
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: editTextIcon,
                              )
                            : widget.inputType == InputType.option
                                ?  Icon(
                                    Icons.arrow_drop_down,
                                    color: editTextIcon,
                                  )
                                : SizedBox.shrink(),
                      ),
                    )
                  : widget.inputType == InputType.search
                      ? Icon(
                         Icons.search,
                          color: Colors.black,
                          size: 22,
                        )
                      : widget.suffixIcons),
    );
  }
}
