import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/theme/text_field_styles.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/app/widgets/customTextFormField.dart';
import 'package:pautas/src/app/widgets/toast.dart';
import '../user_cadastre_controller.dart';
import 'header.dart';

class Step3 extends StatelessWidget {

  Step3({required this.controller}) {
    controller.addStepCallback(() async {

      bool goNextPage = false;

      if (_textController.text.length>=6){
        controller.newUser.password = _textController.text;
        goNextPage = true;
      } else
        Toast.showMessage("A senha precisa ter 6 ou mais caracteres!", duration: 5);

      return goNextPage;
    });
  }

  final UserCadastreController controller;
  final TextEditingController _textController = TextEditingController();
  final TextStyles textStylesConsts = TextStyles();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Header(title: "Segurança é importante", subtitle: "Informe uma senha fácil de lembrar"),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(10),
              child: CustomTextFormField(
                controller: _textController,
                decoration: TextFieldStylesConsts.textFieldCadastre(hint: "Minha senha é...", label: "SENHA"),
                maxLength: 20,
                obscureText: true,
                style: textStylesConsts.textFieldWhite,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                onFieldSubmited: (String? text) {
                  Modular.to.pop();
                },
              )
            ),
          )
        ],
      ),
    );
  }
}