import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas/src/app/controllers/auth_controller.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/utils/enums.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  ReactionDisposer disposerAuth;
  double _opacity = 0;

  @override
  void initState() {
    super.initState();

    executeAnimation().then((_){
      disposerAuth = autorun((_) async {
        final auth = Modular.get<AuthController>();

        await Future.delayed(Duration(seconds: 1));
        await executeAnimation();
        if (auth.status == AuthStatus.login)
          await Modular.to.pushReplacementNamed('/root');
        else if (auth.status == AuthStatus.logoff)
          await Modular.to.pushReplacementNamed('/login');
      });
    });
    
  }

  @override
  void dispose() {
    super.dispose();
    disposerAuth.call();
  }

  Future<void> executeAnimation() async{

    await Future.delayed(Duration(milliseconds: 1000));

    if (_opacity == 0)
      setState(() { _opacity = 1; });
    else
      setState(() { _opacity = 0; });

    await Future.delayed(Duration(milliseconds: 1000));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 1),
          child: Text("Minhas Pautas",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 30
            ),
          ),
        ),
      ),
    );
  }
}
