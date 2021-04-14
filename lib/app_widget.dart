import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oktoast/oktoast.dart';
import 'src/app/theme/color_consts.dart';
import 'src/app/theme/text_style_consts.dart';

class AppWidget extends StatelessWidget {

  final TextStylesConsts textStyles = TextStylesConsts();
  
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Pautas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: ThemeConsts.primaryColor,
          accentColor: ThemeConsts.accentColor,
          backgroundColor: ThemeConsts.backgroundColor,
          fontFamily: 'Google',
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(
              headline6: textStyles.h1
            )
          ),
          iconTheme: IconThemeData(
            color: Colors.white
          )
        ),
        initialRoute: "/",
      ).modular(),
    );
  }
}