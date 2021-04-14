import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/theme/text_field_style_consts.dart';
import 'package:pautas/src/app/theme/text_style_consts.dart';
import 'package:pautas/src/app/widgets/custom_scroll_behavior.dart';
import 'package:pautas/src/app/widgets/toast.dart';
import 'package:pautas/src/domain/entities/user_entity.dart';
import '../guideline_cadastre_controller.dart';
import 'header.dart';

class Step3 extends StatelessWidget {

  Step3({@required this.controller}) {
    controller.addStepCallback(() async {
      
      bool goNextPage = false;

      if (_textController.text.isNotEmpty) {
        controller.newGuideline.details = _textController.text;
        controller.newGuideline.done = false;
        controller.newGuideline.owner = Modular.get<UserEntity>().id;
        controller.newGuideline.author = Modular.get<UserEntity>().name;

        await controller.addGuideline();
        goNextPage = true;
      } else
        Toast.showMessage("Dê alguns detalhes sobre a pauta!", duration: 5);

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
          Header(title: "Para finalizarmos", subtitle: "Detalhes sobre a pauta"),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: _textController,
                decoration: TextFieldStylesConsts.textFieldCadastre(hint: "", label: "DETALHES"),
                maxLength: 300,
                maxLines: 4,
                minLines: 1,
                style: textStylesConsts.textFieldWhite,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
              )
            ),
          ),
        ],
      ),
    );
  }
}