import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pautas/src/app/theme/text_field_style_consts.dart';
import 'package:pautas/src/app/theme/text_style_consts.dart';
import 'package:pautas/src/app/widgets/custom_scroll_behavior.dart';
import 'package:pautas/src/app/widgets/toast.dart';
import '../guideline_cadastre_controller.dart';
import 'header.dart';

class Step2 extends StatelessWidget {

  Step2({@required this.controller}) {
    _textController.text = controller.newGuideline.description;
    controller.addStepCallback((){
      bool goNextPage = false;

      if (_textController.text.isNotEmpty) {
        controller.newGuideline.description = _textController.text;
        goNextPage = true;
      } else
        Toast.showMessage("É necessária uma breve descrição!", duration: 5);

      return goNextPage;
    });
  }

  final GuidelineCadastreController controller;
  final TextEditingController _textController = TextEditingController();
  final TextStylesConsts textStylesConsts = TextStylesConsts();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Header(title: "Sobre a pauta", subtitle: "Faça uma breve descrição sobre ela"),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: _textController,
                decoration: TextFieldStylesConsts.textFieldCadastre(hint: "", label: "DESCRIÇÃO"),
                maxLength: 250,
                maxLines: 4,
                minLines: 1,
                style: textStylesConsts.textFieldWhite,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ),
        ],
      ),
    );
  }

}