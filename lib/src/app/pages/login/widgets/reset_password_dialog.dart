import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/theme/color_consts.dart';
import 'package:pautas/src/app/theme/text_field_style_consts.dart';
import 'package:pautas/src/app/theme/text_style_consts.dart';
import 'package:pautas/src/app/utils/enums.dart';
import 'package:pautas/src/app/widgets/custom_scroll_behavior.dart';
import 'package:pautas/src/app/widgets/toast.dart';

class ResetPasswordDialog extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();
  final TextStylesConsts _textStylesConsts = TextStylesConsts();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: CustomScrollConfiguration(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Esqueci minha senha",
              style: TextStylesConsts().h2,
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _controller,
              decoration: TextFieldStylesConsts.textFieldCadastreWithBorder(hint: "Meu email é...", label: "EMAIL"),
              style: _textStylesConsts.textFieldWhite,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: RaisedButton(
                color: ThemeConsts.backgroundColor,
                child: Text("Enviar",
                  style: TextStylesConsts().hint,
                ),
                onPressed: (){
                  FirebaseAuth.instance.sendPasswordResetEmail(email: _controller.text);
                  Toast.showMessage("Foi enviado um link para recuperação de senha para o email informado!", duration: 5, toastKind: ToastKind.success);
                  Modular.to.pop();
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}