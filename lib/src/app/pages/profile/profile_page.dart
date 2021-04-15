import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/controllers/auth_controller.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/domain/entities/user_entity.dart';

class ProfilePage extends StatelessWidget {

  final UserEntity user = Modular.get<UserEntity>();
  final TextStyles _textStylesConsts = TextStyles();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          tooltip: "Voltar",
          icon: Icon(FeatherIcons.xCircle, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            tooltip: "Logout",
            icon: Icon(FeatherIcons.logOut, color: Colors.white,),
            onPressed: () {
              Modular.get<AuthController>().logout();
            },
          ),
        ],
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 40, 20, 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Usuário",
              style: _textStylesConsts.guidelineDetailTitle
            ),
            SizedBox(height: 10),
            Text(user.name,
              style: _textStylesConsts.guidelineDetailInfo
            ),
            SizedBox(height: 40),
            Text("Email",
              style: _textStylesConsts.guidelineDetailTitle
            ),
            SizedBox(height: 10),
            Text(user.email,
              style: _textStylesConsts.guidelineDetailInfo
            ),
          ],
        ),
      ),
    );
  }
}