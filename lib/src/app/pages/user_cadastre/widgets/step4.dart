import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_field_styles.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/app/widgets/customTextFormField.dart';
import 'package:pautas/src/app/widgets/toast.dart';
import '../user_cadastre_controller.dart';
import 'header.dart';

class Step4 extends StatelessWidget {

  Step4({@required this.controller, @required this.callback}) {
    controller.addStepCallback(() async {
      
      bool goNextPage = false;

      if (_textController.text == controller.newUser.password){
        controller.finalized = true;
        await controller.registerUser(_textController.text);
        goNextPage = true;
      } else
        Toast.showMessage("As senha e a confirmação precisam ser iguais!", duration: 5);

      return goNextPage;
    });
  }

  final Function callback;
  final UserCadastreController controller;
  final TextEditingController _textController = TextEditingController();
  final TextStyles textStylesConsts = TextStyles();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Header(title: "Para finalizarmos", subtitle: "Confirme sua senha!"),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(10),
              child: CustomTextFormField(
                controller: _textController,
                decoration: TextFieldStylesConsts.textFieldCadastre(hint: "Minha senha é...", label: "CONFIRMAÇÃO DE SENHA"),
                maxLength: 20,
                obscureText: true,
                style: textStylesConsts.textFieldWhite,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                onFieldSubmited: (String text) {
                  Modular.to.pop();
                },
              )
            ),
          ),
          Observer(
            builder: (_) {
              return Visibility(
                visible: controller.finalized,
                child: Container(
                  color: AppColors.backgroundColor,
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          CircularProgressIndicator(
                            strokeWidth: 8,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.textFieldColor),
                          ),
                          Divider(color: Colors.transparent),
                          Text("Estamos criando a sua conta! Aguarde por favor...",
                            style: textStylesConsts.h2,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
          Observer(
            builder: (_) {
              return Visibility(
                visible: controller.goToEmail,
                child: Container(
                  color: AppColors.backgroundColor,
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.warning, color: AppColors.textFieldErrorColor, size: 100,),
                          Divider(color: Colors.transparent),
                          Text("Esse email já está em uso...",
                            style: textStylesConsts.h2,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                          Divider(color: Colors.transparent),
                          RaisedButton(
                            color: AppColors.textFieldSuccessColor,
                            child: Text("Trocar email",
                              style: textStylesConsts.hint,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              controller.goToEmail = false;
                              callback();
                            }
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          )
        ],
      ),
    );
  }
}