import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_field_styles.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/app/widgets/customTextFormField.dart';
import 'package:pautas/src/app/widgets/toast.dart';
import '../guideline_cadastre_controller.dart';
import 'header.dart';

class Step2 extends StatelessWidget {

  Step2({required this.controller}) {
    _textController.text = controller.newGuideline!.description!;
    controller.addStepCallback((){
      bool goNextPage = false;

      if (_textController.text.isNotEmpty) {
        controller.newGuideline!.description = _textController.text;
        goNextPage = true;
      } else
        Toast.showMessage("É necessária uma breve descrição!", duration: 5);

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
          Header(title: "Sobre a pauta", subtitle: "Faça uma breve descrição"),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(10),
              child: CustomTextFormField(
                controller: _textController,
                decoration: TextFieldStylesConsts.textFieldCadastreWithBackground(
                  context: context,
                  hint: "", 
                  label: "DESCRIÇÃO",
                  backgroundColor: AppColors.hintColor,
                ),
                maxLength: 250,
                maxLines: 4,
                minLines: 4,
                style: textStylesConsts.textFieldWhite,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                onFieldSubmited: (String? text) {
                  controller.nextPage();
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