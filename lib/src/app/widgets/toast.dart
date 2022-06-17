import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/app/utils/enums.dart';

class Toast{
  static void showMessage(String message, {int duration = 2, ToastKind toastKind = ToastKind.error}){
    Widget widget = Container(
      height: 60,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (toastKind == ToastKind.error) ? AppColors.textFieldErrorColor : AppColors.textFieldSuccessColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          message,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyles().hint,
        ),
      ),
    );

    showToastWidget(
      widget,
      duration: Duration(seconds: duration),
      position: ToastPosition.bottom,
      dismissOtherToast: true,
      animationCurve: Curves.easeInCubic
    );
  }  
}