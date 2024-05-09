import 'package:flutter/material.dart';

class TextFieldWidgets extends StatelessWidget {
  final String inputPlaceHolder;
  final TextEditingController controller;

  final TextInputType inputType;

  final bool isVisible;
  final FormFieldValidator validator;
  final FocusNode focusNode;

  final TextStyle labelStyle;
  final TextStyle inputStyle;

  TextFieldWidgets({
    required this.inputPlaceHolder,
    required this.controller,
    required this.inputType,
    this.isVisible = false,
    required this.validator,
    required this.focusNode,
    required this.labelStyle,
    required this.inputStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: Padding(
        padding: EdgeInsets.only(right: 0),
        child: TextFormField(
          key: key,
          controller: controller,
          focusNode: focusNode,
          textInputAction: TextInputAction.done,
          style: inputStyle,
          validator: validator,
          cursorColor: Color(0xff42697c),
          obscureText: isVisible,

          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(width: 0.0, color: Color(0xffe6e9ef)),
            ),
            contentPadding: EdgeInsets.only(left: 23, top: 0, bottom: 5),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(width: 0.0, color: Color(0xffe6e9ef)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(width: 0.0, color: Color(0xffe6e9ef)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(width: 0.0, color: Color(0xffe6e9ef)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(width: 0.0, color: Color(0xffe6e9ef)),
            ),
            labelText: inputPlaceHolder,
            labelStyle: labelStyle,
          ),
          keyboardType: inputType,
          // controller: controller,
        ),
      ),
    );
  }
}
