import 'package:flutter/material.dart';

import 'color_consts.dart';

class TextFieldStylesConsts {

  static InputDecoration textFieldLogin({String hint, IconData prefixIcon, IconData suffixIcon}) => InputDecoration(
    filled: true,
    fillColor: Color(0xFFEEEEEE),
    border: InputBorder.none,
    prefixIcon: (prefixIcon == null) ? null : Icon(prefixIcon, color: ThemeConsts.backgroundColor,),
    suffix: (suffixIcon == null) ? null : Icon(suffixIcon),
    hintText: hint,
    hintStyle: TextStyle(
      color: Colors.grey,
    ),
  );

  static InputDecoration textFieldCadastre({String hint, String label, IconData prefixIcon, IconData suffixIcon, String prefixText}) => InputDecoration(
    border: InputBorder.none,
    isDense: true,
    prefixText: prefixText,
    prefixIcon: (prefixIcon == null) ? null : Icon(prefixIcon, color: ThemeConsts.backgroundColor,),
    suffix: (suffixIcon == null) ? null : Icon(suffixIcon),
    hintText: hint,
    hintStyle: TextStyle(
      color: ThemeConsts.textFieldColor,
    ),
    helperStyle: TextStyle(
      color: ThemeConsts.textFieldColor,
    ),
    errorText: label,
    errorStyle: TextStyle(
      color: ThemeConsts.textFieldColor,
      fontSize: 15,
    ),
  );

  static InputDecoration textFieldCadastreWithBorder({String hint, String label, IconData prefixIcon, IconData suffixIcon, String prefixText}) => InputDecoration(
    helperText: label,
    isDense: true,
    prefixText: prefixText,
    prefixIcon: (prefixIcon == null) ? null : Icon(prefixIcon, color: ThemeConsts.backgroundColor,),
    suffix: (suffixIcon == null) ? null : Icon(suffixIcon),
    hintText: hint,
    focusColor: ThemeConsts.textFieldColor,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: ThemeConsts.textFieldColor, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ThemeConsts.textFieldErrorColor, width: 2.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ThemeConsts.textFieldErrorColor, width: 4.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ThemeConsts.textFieldColor, width: 4.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ThemeConsts.textFieldColor, width: 2.0),
    ),
    labelStyle: TextStyle(
      color: ThemeConsts.textFieldColor,
    ),
    hintStyle: TextStyle(
      color: ThemeConsts.textFieldColor,
    ),
    helperStyle: TextStyle(
      color: ThemeConsts.textFieldColor,
      fontSize: 15,
    ),
    errorStyle: TextStyle(
      color: ThemeConsts.textFieldColor,
      fontSize: 15,
    ),
  );

}