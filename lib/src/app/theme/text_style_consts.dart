import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_consts.dart';

class TextStylesConsts {

  static const textStyleBackground = TextStyle(
    color: ThemeConsts.backgroundColor,
  );

  final loginHint = GoogleFonts.montserrat(
    fontSize: 14, 
    color: ThemeConsts.textFieldColor,
    fontWeight: FontWeight.w500);

  final loginForgotPassword = GoogleFonts.montserrat(
    fontSize: 14, 
    color: ThemeConsts.primaryColor,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline);    

  final hint = GoogleFonts.montserrat(
    fontSize: 14, 
    color: Colors.white,
    fontWeight: FontWeight.w500);

  final h1 = GoogleFonts.montserrat(
    fontSize: 25, 
    color: ThemeConsts.textPrimaryColor,
    fontWeight: FontWeight.w500);

  final h1Primary = GoogleFonts.montserrat(
    fontSize: 25, 
    color: ThemeConsts.primaryColor,
    fontWeight: FontWeight.w500);

  final h2 = GoogleFonts.montserrat(
    fontSize: 20, 
    color: ThemeConsts.textPrimaryColor,
    fontWeight: FontWeight.w500);

  final h2White = GoogleFonts.montserrat(
    fontSize: 20, 
    color: Colors.white,
    fontWeight: FontWeight.w500);

  final h2Primary = GoogleFonts.montserrat(
    fontSize: 20, 
    color: ThemeConsts.primaryColor,
    fontWeight: FontWeight.w500);

  final textFieldWhite = GoogleFonts.montserrat(
    fontSize: 20, 
    color: ThemeConsts.textPrimaryColor,
    fontWeight: FontWeight.normal);

  final popupCancelButtonColor = GoogleFonts.montserrat(
    color: ThemeConsts.textPrimaryColor,
    fontWeight: FontWeight.w500);       

  final popupOkButtonColor = GoogleFonts.montserrat(
    color: ThemeConsts.textPrimaryColor,
    fontWeight: FontWeight.w500); 

  final guidelineItemTitle = GoogleFonts.montserrat(
    fontSize: 18,
    color: Colors.black54,
    fontWeight: FontWeight.bold);     

  final guidelineItemDescription = GoogleFonts.montserrat(
    fontSize: 14, 
    color: Colors.black54,
    fontWeight: FontWeight.normal);    

  final headerInfo = GoogleFonts.roboto(
    fontSize: 12, 
    color: ThemeConsts.hintColor,
    fontWeight: FontWeight.bold,);

  final guidelineDetailTitle = GoogleFonts.montserrat(
    fontSize: 20, 
    color: ThemeConsts.textFieldColor,
    fontWeight: FontWeight.bold); 
  
  final guidelineDetailInfo = GoogleFonts.montserrat(
    fontSize: 18, 
    color: ThemeConsts.textFieldColor,
    fontWeight: FontWeight.normal);      

}