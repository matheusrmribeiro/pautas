import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/theme/text_field_styles.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/app/widgets/customTextFormField.dart';
import 'package:pautas/src/app/widgets/toast.dart';
import '../user_cadastre_controller.dart';
import 'header.dart';

class Step2 extends StatelessWidget {

  Step2({required this.controller}) {
    _textController.text = controller.newUser.email!;
    controller.addStepCallback((){
      bool goNextPage = false;

      if ((!_textController.text.contains("@")) || ((!_textController.text.contains(".com")) && (!_textController.text.contains(".com.br"))))
        Toast.showMessage("Parece que tem alguma coisa errada com o email informado, não está faltando nada?", duration: 5);
      else if (_textController.text.isEmpty)
        Toast.showMessage("A senha precisa ter 6 ou mais caracteres!", duration: 5);
      else {
        controller.newUser.email = _textController.text;

        goNextPage = true;
      }

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
          Observer(
            builder: (_) {
              return Header(title: "Hey ${controller.newUser.name}!", subtitle: "Qual email você deseja usar?");
            }
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(10),
              child: CustomTextFormField(
                controller: _textController,
                decoration: TextFieldStylesConsts.textFieldCadastre(hint: "Meu email é...", label: "EMAIL"),
                maxLength: 60,
                style: textStylesConsts.textFieldWhite,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                onFieldSubmited: (String? text) {
                  Modular.to.pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}