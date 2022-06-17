import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_field_styles.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/app/widgets/pulse_animation.dart';

import '../login_controller.dart';
import 'reset_password_dialog.dart';

class LoginForm extends StatefulWidget {
  LoginForm({this.controller});
  
  final LoginController? controller;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends ModularState<LoginForm, LoginController>{

  final TextStyles stylesConsts = TextStyles();

  double _formHeight = 0;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    executeInitialAnimation();
    emailController.addListener((){
      controller.email = emailController.text;
    });
    passwordController.addListener((){
      controller.password = passwordController.text;
    });
  }

  Future<void> executeInitialAnimation() async {
    if (_formHeight == 0)
      await Future.delayed(Duration(milliseconds: 500));
    setState(() { _formHeight = 130; });    
  }

  void openLogin(){
    if (_formHeight == 130)
      setState(() { _formHeight = MediaQuery.of(context).size.height*0.9; });
    else
      setState(() { _formHeight = 130; });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.decelerate,
      duration: Duration(milliseconds: 500),
      height: _formHeight,
      child: ClipPath(
        clipper: ClipBakcground(),
        child: Container(
          padding: EdgeInsets.all(12),
          color: Colors.white,
          child: Stack(
            children: <Widget>[                         
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 62,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: openLogin,
                          child: Text(
                            "Entrar com sua conta",
                            style: TextStyle(
                              color: AppColors.backgroundColor,
                              fontSize: 18
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: _formHeight > 130,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.9,
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: TextFieldStylesConsts.textFieldLogin(
                                hint: "Email", 
                                prefixIcon: FeatherIcons.user
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.9,
                            child: TextField(
                              controller: passwordController,
                              decoration: TextFieldStylesConsts.textFieldLogin(
                                hint: "Senha", 
                                prefixIcon: FeatherIcons.lock
                              ),
                              obscureText: true,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: controller.onLoginEmailPassword,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(AppColors.backgroundColor)
                              ),
                              child: Text("Entrar",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Não tem uma conta?',
                                style: stylesConsts.loginHint,
                                textAlign: TextAlign.center,
                              ),
                              InkWell(
                                onTap: () async {
                                  await Modular.to.pushNamed("/user/cadastre");
                                },
                                child: Text(
                                  ' Registre-se!',
                                  style: TextStyles.textStyleBackground,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: _formHeight > 130,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Theme.of(context).primaryColor,
                            content: ResetPasswordDialog()
                          );
                        });
                    },
                    child: Text(
                      'Esqueci minha senha!',
                      style: stylesConsts.loginForgotPassword,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 50,
                child: Container(
                  width: 40,
                  height: 40,
                  child: PulseAnimator(
                    pulseColor: AppColors.primaryColor[100],
                    child: RaisedButton(
                      color: AppColors.backgroundColor,
                      elevation: 1,
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Icon(Icons.email, color: Colors.white,),
                      onPressed: openLogin
                    ),
                  ),
                )
              ),   
            ],
          ),
        ),
      ),
    );
  }
}

class ClipBakcground extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    
    var path = Path();
    path.lineTo(0, 0);

    Offset leftBegin = Offset(30, 30);
    Offset leftEnd = Offset(size.width / 4, 30);
    path.quadraticBezierTo(leftBegin.dx, leftBegin.dy, leftEnd.dx, leftEnd.dy);

    path.lineTo(size.width-60, 30);

    Offset rightBegin = Offset(size.width-10, 30);
    Offset rightEnd = Offset(size.width, 60);    
    path.quadraticBezierTo(rightBegin.dx, rightBegin.dy, rightEnd.dx, rightEnd.dy);
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }

}