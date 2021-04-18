import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class TextStyles {

  TextStyles({this.context});

  final BuildContext context;

  static const textStyleBackground = TextStyle(
    color: AppColors.backgroundColor,
  );

  final loginHint = GoogleFonts.montserrat(
    fontSize: 14, 
    color: AppColors.textFieldColor,
    fontWeight: FontWeight.w500);

  final loginForgotPassword = GoogleFonts.montserrat(
    fontSize: 14, 
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline);    

  final hint = GoogleFonts.montserrat(
    fontSize: 14, 
    color: Colors.white,
    fontWeight: FontWeight.w500);

  final h1 = GoogleFonts.montserrat(
    fontSize: 25, 
    color: AppColors.textPrimaryColor,
    fontWeight: FontWeight.w500);

  final h1Primary = GoogleFonts.montserrat(
    fontSize: 25, 
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w500);

  final h2 = GoogleFonts.montserrat(
    fontSize: 20, 
    color: AppColors.textPrimaryColor,
    fontWeight: FontWeight.w500);

  final h2White = GoogleFonts.montserrat(
    fontSize: 20, 
    color: Colors.white,
    fontWeight: FontWeight.w500);

  final h2Primary = GoogleFonts.montserrat(
    fontSize: 20, 
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w500);

  final textFieldWhite = GoogleFonts.montserrat(
    fontSize: 20, 
    color: AppColors.textPrimaryColor,
    fontWeight: FontWeight.normal);

  final textFieldNormal = GoogleFonts.montserrat(
    fontSize: 20, 
    color: AppColors.backgroundAccentColor,
    fontWeight: FontWeight.normal);

  final popupCancelButtonColor = GoogleFonts.montserrat(
    color: AppColors.textPrimaryColor,
    fontWeight: FontWeight.w500);       

  final popupOkButtonColor = GoogleFonts.montserrat(
    color: AppColors.textPrimaryColor,
    fontWeight: FontWeight.w500); 

  final guidelineItemTitle = GoogleFonts.montserrat(
    fontSize: 18,
    color: Colors.black54,
    fontWeight: FontWeight.bold);     

  final guidelineItemDescription = GoogleFonts.montserrat(
    fontSize: 14, 
    color: Colors.black54,
    fontWeight: FontWeight.normal);    

  final guidelineItemHint = GoogleFonts.montserrat(
    fontSize: 14, 
    color: AppColors.hintColor,
    fontWeight: FontWeight.normal);    

  final headerInfo = GoogleFonts.roboto(
    fontSize: 12, 
    color: AppColors.hintColor,
    fontWeight: FontWeight.bold,);

  final guidelineDetailTitle = GoogleFonts.montserrat(
    fontSize: 20, 
    color: AppColors.textFieldColor,
    fontWeight: FontWeight.w300); 
  
  final guidelineDetailInfo = GoogleFonts.montserrat(
    fontSize: 18, 
    color: AppColors.textFieldColor,
    fontWeight: FontWeight.w500);      

  get customTextFieldLabel => GoogleFonts.roboto(
    fontSize: 40, 
    color: Theme.of(context).accentColor,
    fontWeight: FontWeight.bold);

  get customTextFieldText => GoogleFonts.roboto(
    fontSize: 20, 
    color: Theme.of(context).accentColor,
    fontWeight: FontWeight.bold,
  );

  final titleHint = GoogleFonts.montserrat(
    fontSize: 15, 
    color: AppColors.textFieldColor,
    fontWeight: FontWeight.normal);   

  final title = GoogleFonts.montserrat(
    fontSize: 15, 
    color: AppColors.hintColor,
    fontWeight: FontWeight.normal);   

  final weekDayName = GoogleFonts.montserrat(
    fontSize: 25, 
    color: Colors.black54,
    fontWeight: FontWeight.bold);

  final weekDay = GoogleFonts.montserrat(
    fontSize: 25, 
    color: AppColors.hintColor,
    fontWeight: FontWeight.normal);

  final tabActive = GoogleFonts.montserrat(
    fontSize: 15, 
    color: AppColors.hintColor,
    fontWeight: FontWeight.w500);

  final tabInactive = GoogleFonts.montserrat(
    fontSize: 15, 
    color: AppColors.textFieldColor,
    fontWeight: FontWeight.normal);

  final taskNormal = GoogleFonts.montserrat(
    fontSize: 20, 
    color: AppColors.textFieldColor,
    fontWeight: FontWeight.w500
  );

  final taskDone = GoogleFonts.montserrat(
    fontSize: 20, 
    color: AppColors.accentColor,
    fontWeight: FontWeight.w500
  );

}