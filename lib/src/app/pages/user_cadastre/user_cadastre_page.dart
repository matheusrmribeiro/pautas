import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pautas/src/app/pages/user_cadastre/user_cadastre_controller.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/widgets/custom_scroll_behavior.dart';
import 'package:pautas/src/app/widgets/navigator_buttons.dart';
import 'widgets/step1.dart';
import 'widgets/step2.dart';
import 'widgets/step3.dart';
import 'widgets/step4.dart';

class UserCadastrePage extends StatefulWidget {
  @override
  _UserCadastreState createState() => _UserCadastreState();
}

class _UserCadastreState extends State<UserCadastrePage> {

  final UserCadastreController controller = UserCadastreController();
  final List<Widget> steps = [];

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    
    steps.addAll([
      Step1(controller: controller), 
      Step2(controller: controller),
      Step3(controller: controller),
      Step4(controller: controller, callback: backToEmail,),
    ]);

    _pageController = PageController();

  }

  void backToEmail() => _pageController.jumpToPage(1);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          tooltip: "Voltar",
          icon: Icon(FeatherIcons.xCircle),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      extendBody: true,
      body: CustomScrollConfiguration(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 150,
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: steps,
                onPageChanged: (int index) {
                  controller.currentPage = index;
                },
              ),
            ),
            Observer(
              builder: (_) {
                return NavigatorButtons(
                  pageController: _pageController, 
                  currentPage: controller.currentPage, 
                  totalPages: steps.length,
                  nextCallback: controller.stepsCallback[controller.currentPage]
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
