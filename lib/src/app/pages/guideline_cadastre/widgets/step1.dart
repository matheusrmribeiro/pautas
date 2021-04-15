import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/theme/text_field_styles.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/app/widgets/customTextFormField.dart';
import 'package:pautas/src/app/widgets/toast.dart';
import '../guideline_cadastre_controller.dart';
import 'header.dart';

class Step1 extends StatelessWidget {

  Step1({@required this.controller}) {
    _textController.text = controller.newGuideline.title;
    controller.addStepCallback((){
      bool goNextPage = false;

      if (_textController.text.isNotEmpty){
        controller.newGuideline.title = _textController.text;
        goNextPage = true;
      } else
        Toast.showMessage("Preencha o título antes de continuarmos!", duration: 5);

      return goNextPage;

    });
  }

  final GuidelineCadastreController controller;
  final TextEditingController _textController = TextEditingController();
  final TextStyles textStylesConsts = TextStyles();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Header(title: "Inclusão de nova pauta", subtitle: "Qual o título dessa pauta?"),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(10),
              child: CustomTextFormField(
                controller: _textController,
                decoration: TextFieldStylesConsts.textFieldCadastre(hint: "O título é...", label: "TÍTULO"),
                maxLength: 40,
                style: textStylesConsts.textFieldWhite,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
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