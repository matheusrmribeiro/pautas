import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/controllers/root_controller.dart';
import 'package:pautas/src/app/pages/guidelines/guidelines_page.dart';
import 'package:pautas/src/app/widgets/tab_widget.dart';
import 'package:pautas/src/app/pages/root/widgets/title_widget.dart';
import 'package:pautas/src/app/theme/colors.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends ModularState<RootPage, RootController> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAccentColor,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TitleWidget(),
            SizedBox(height: 30,),
            TabWidget(
              controller: controller.pageController,
              tabs: [
                TabEntity(text: "Em progresso"),
                TabEntity(text: "Finalizadas")
              ],
            ),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: (int index){
                  controller.currentPage = index;
                },
                children: [
                  GuidelinesPage(done: false),
                  GuidelinesPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}