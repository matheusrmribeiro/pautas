import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'login_controller.dart';
import 'widgets/details_widget.dart';
import 'widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  
  double _opacity = 0;
  
  @override
  void initState() {
    super.initState();
    setState(() { _opacity = 1; });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 100,
              child: AnimatedOpacity(
                duration: Duration(seconds: 2),
                opacity: _opacity,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Minhas ',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Pautas',
                            style: TextStyle(
                              fontSize: 24,
                              color: AppColors.textFieldColor,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: DetalhesAppWidget()),                      
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: LoginForm(controller: controller),
            ),
          ],
        ),
      )
    );
  }
}
