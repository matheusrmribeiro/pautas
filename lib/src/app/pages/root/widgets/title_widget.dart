import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/domain/entities/user_entity.dart';

class TitleWidget extends StatelessWidget {

  final UserEntity user = Modular.get<UserEntity>();
  final TextStyles _textStylesConsts = TextStyles();

  final List<String> weekDayName = [
    "Segunda-feira",
    "Terça-feira",
    "Quarta-feira",
    "Quinta-feira",
    "Sexta-feira",
    "Sábado",
    "Domingo"
  ];

  final DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      height: 150,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed("/profile");
                  },
                  child: Tooltip(
                    message: "Perfil",
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.backgroundColor
                      ),
                      height: 40,
                      width: 40,
                      child: Center(
                      child: Icon(Icons.person, 
                        color: Colors.white
                      )
                    ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Olá, ",
                      style: _textStylesConsts.titleHint
                    ),
                    Text(user.name!,
                      style: _textStylesConsts.title
                    ),
                  ],
                )
              ],
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: "${weekDayName[date.weekday -1]}, ", 
                    style: _textStylesConsts.weekDayName
                  ),
                  TextSpan(
                    text: date.day.toString(), 
                    style: _textStylesConsts.weekDay
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}