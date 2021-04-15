import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/theme/text_field_styles.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/app/widgets/customTextFormField.dart';
import 'package:pautas/src/app/widgets/toast.dart';
import '../user_cadastre_controller.dart';
import 'header.dart';

class Step1 extends StatelessWidget {

  Step1({@required this.controller}) {
    _textController.text = controller.newUser.name;
    controller.addStepCallback((){
      bool goNextPage = false;

      if (_textController.text.isNotEmpty){
        controller.newUser.name = _textController.text;
        goNextPage = true;
      } else
        Toast.showMessage("Vamos lá, não se acanhe... Seu nome deve ser maravilhoso!!", duration: 5);

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
          Header(title: "É um prazer te conhecer!", subtitle: "Como você prefere ser chamado?"),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(10),
              child: CustomTextFormField(
                controller: _textController,
                decoration: TextFieldStylesConsts.textFieldCadastre(hint: "Meu nome é...", label: "NOME"),
                maxLength: 30,
                style: textStylesConsts.textFieldWhite,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                onFieldSubmited: (String text) {
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