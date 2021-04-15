import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oktoast/oktoast.dart';
import 'src/app/theme/colors.dart';
import 'src/app/theme/text_styles.dart';

class AppWidget extends StatelessWidget {

  final TextStyles textStyles = TextStyles();
  
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Pautas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          accentColor: AppColors.accentColor,
          backgroundColor: AppColors.backgroundColor,
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