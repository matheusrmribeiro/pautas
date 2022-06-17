import 'package:flutter/material.dart';

import 'colors.dart';

class TextFieldStylesConsts {

  static InputDecoration textFieldLogin({String? hint, IconData? prefixIcon, IconData? suffixIcon}) => InputDecoration(
    filled: true,
    fillColor: Color(0xFFEEEEEE),
    border: InputBorder.none,
    prefixIcon: (prefixIcon == null) ? null : Icon(prefixIcon, color: AppColors.backgroundColor,),
    suffix: (suffixIcon == null) ? null : Icon(suffixIcon),
    hintText: hint,
    hintStyle: TextStyle(
      color: Colors.grey,
    ),
  );

  static InputDecoration textFieldCadastre({String? hint, String? label, IconData? prefixIcon, IconData? suffixIcon, String? prefixText}) => InputDecoration(
    border: InputBorder.none,
    isDense: true,
    prefixText: prefixText,
    prefixIcon: (prefixIcon == null) ? null : Icon(prefixIcon, color: AppColors.backgroundColor,),
    suffix: (suffixIcon == null) ? null : Icon(suffixIcon),
    hintText: hint,
    hintStyle: TextStyle(
      color: AppColors.textFieldColor,
    ),
    helperStyle: TextStyle(
      color: AppColors.textFieldColor,
    ),
    errorText: label,
    errorStyle: TextStyle(
      color: AppColors.textFieldColor,
      fontSize: 15,
    ),
  );

  static InputDecoration textFieldCadastreWithBorder({String? hint, String? label, IconData? prefixIcon, IconData? suffixIcon, String? prefixText}) => InputDecoration(
    helperText: label,
    isDense: true,
    prefixText: prefixText,
    prefixIcon: (prefixIcon == null) ? null : Icon(prefixIcon, color: AppColors.backgroundColor,),
    suffix: (suffixIcon == null) ? null : Icon(suffixIcon),
    hintText: hint,
    focusColor: AppColors.textFieldColor,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFieldColor, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFieldErrorColor, width: 2.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFieldErrorColor, width: 4.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFieldColor, width: 4.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFieldColor, width: 2.0),
    ),
    labelStyle: TextStyle(
      color: AppColors.textFieldColor,
    ),
    hintStyle: TextStyle(
      color: AppColors.textFieldColor,
    ),
    helperStyle: TextStyle(
      color: AppColors.textFieldColor,
      fontSize: 15,
    ),
    errorStyle: TextStyle(
      color: AppColors.textFieldColor,
      fontSize: 15,
    ),
  );

 static InputDecoration textFieldContext({
    required BuildContext context, 
    String? hint, 
    String? label, 
    IconData? prefixIcon, 
    IconData? suffixIcon, 
    String? prefixText,
    Color? backgroundColor,
    Function? suffixTap
  }) => InputDecoration(
    prefixText: prefixText,
    prefixIcon: (prefixIcon == null) 
      ? null 
      : Icon(prefixIcon, color: Theme.of(context).iconTheme.color),
    suffix: (suffixIcon == null) 
      ? null 
      : GestureDetector(
        onTap: suffixTap as void Function()?,
          child: Icon(suffixIcon, 
            color: Theme.of(context).iconTheme.color,
          )
        ),
    hintText: hint,
    hintStyle: TextStyle(
      color: Theme.of(context).iconTheme.color!.withAlpha(150),
    ),
    fillColor: (backgroundColor == null) ? Theme.of(context).cardColor : backgroundColor,
    filled: true,
    contentPadding: EdgeInsets.all(10),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
      borderRadius: const BorderRadius.all(
          const Radius.circular(12.0),
        ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
      borderRadius: const BorderRadius.all(
          const Radius.circular(12.0),
        ),
    ),
  );

static InputDecoration textFieldCadastreWithBackground({
    required BuildContext context, 
    String? hint, 
    String? label, 
    IconData? prefixIcon, 
    IconData? suffixIcon, 
    String? prefixText,
    Color? backgroundColor,
    Function? suffixTap
  }) => InputDecoration(
    prefixText: prefixText,
    prefixIcon: (prefixIcon == null) 
      ? null 
      : Icon(prefixIcon, color: Theme.of(context).iconTheme.color),
    suffix: (suffixIcon == null) 
      ? null 
      : GestureDetector(
        onTap: suffixTap as void Function()?,
          child: Icon(suffixIcon, 
            color: Theme.of(context).iconTheme.color,
          )
        ),
    hintText: hint,
    hintStyle: TextStyle(
      color: Theme.of(context).iconTheme.color!.withAlpha(150),
    ),
    errorText: label,
    errorStyle: TextStyle(
      color: AppColors.textFieldColor,
      fontSize: 15,
    ),
    fillColor: (backgroundColor == null) ? Theme.of(context).cardColor : backgroundColor,
    filled: true,
    contentPadding: EdgeInsets.all(12),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
      borderRadius: const BorderRadius.all(
          const Radius.circular(12.0),
        ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
      borderRadius: const BorderRadius.all(
          const Radius.circular(12.0),
        ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
      borderRadius: const BorderRadius.all(
          const Radius.circular(12.0),
        ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
      borderRadius: const BorderRadius.all(
          const Radius.circular(12.0),
        ),
    ),
  );

  static InputDecoration textFieldContextWithBorder({
    required BuildContext context, 
    String? hint, 
    String? label, 
    IconData? prefixIcon, 
    IconData? suffixIcon, 
    String? prefixText
  }) => InputDecoration(
    helperText: label,
    isDense: true,
    prefixText: prefixText,
    prefixIcon: (prefixIcon == null) ? null : Icon(prefixIcon),
    suffix: (suffixIcon == null) ? null : Icon(suffixIcon),
    hintText: hint,
    focusColor: Theme.of(context).primaryColor,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFieldErrorColor, width: 2.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFieldErrorColor, width: 4.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 4.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
    ),
    labelStyle: TextStyle(
      color: Theme.of(context).primaryColor,
    ),
    hintStyle: TextStyle(
      color: Theme.of(context).primaryColor.withOpacity(0.5),
    ),
    helperStyle: TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 15,
    ),
    errorStyle: TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 15,
    ),
  );

}