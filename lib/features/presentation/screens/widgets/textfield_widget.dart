import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidgets extends StatelessWidget {
  @override
  final String inputPlaceHolder;
  final TextEditingController controller;
  final String inputText;
  final TextInputType inputType;
  final VoidCallback onPressed;
  final bool isVisible;
  final FormFieldValidator validator;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function onSaved;
  final Function onFieldSubmitted;
  final TextStyle labelStyle;
  final TextStyle inputStyle;
  final double leftMargin;
  final double allpadding;

  // ignore: deprecated_member_use
  final WhitelistingTextInputFormatter whitelistingTextInputFormatter;

  TextFieldWidgets({
    this.inputPlaceHolder,
    this.controller,
    this.inputText,
    this.inputType,
    this.onPressed,
    this.allpadding,
    this.isVisible = false,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.onSaved,
    this.onFieldSubmitted,
    this.labelStyle,
    this.inputStyle,
    this.whitelistingTextInputFormatter,
    this.leftMargin
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: Padding(
        padding: EdgeInsets.only(
            right: 0),
        child: TextFormField(
          key: key,
          controller: controller,
          focusNode: focusNode,
          textInputAction: textInputAction,
          style: inputStyle,
          validator: validator,
          onSaved: onSaved,
          cursorColor: Color(0xff42697c),
          obscureText: isVisible,
          inputFormatters: [
            // ignore: deprecated_member_use
            whitelistingTextInputFormatter,
          ],
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(
                  width: 0.0, color: Color(0xffe6e9ef)),
            ),
            contentPadding: EdgeInsets.only(left: 23,
                top: 0,
                bottom: 5),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(
                  width: 0.0, color: Color(0xffe6e9ef)),),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(
                  width: 0.0, color: Color(0xffe6e9ef)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(
                  width: 0.0, color: Color(0xffe6e9ef)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(
                  width: 0.0, color: Color(0xffe6e9ef)
              ),
            ),
            labelText: inputPlaceHolder,
            labelStyle: labelStyle,
          ),
          keyboardType: inputType,
          // controller: controller,
          onTap: onPressed,
        ),
      ),
    );
  }
}