import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/controllers/root_controller.dart';
import 'package:pautas/src/app/pages/guidelines/guidelines_page.dart';
import 'package:pautas/src/app/theme/color_consts.dart';
import 'package:pautas/src/app/theme/text_style_consts.dart';
import 'package:pautas/src/app/widgets/navigator_buttons.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends ModularState<RootPage, RootController> {
  
  final TextStylesConsts textStyles = TextStylesConsts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                color: ThemeConsts.textFieldColor,
                fontWeight: FontWeight.bold
              )
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Modular.to.pushNamed("/profile");
            },
            child: Tooltip(
              message: "Perfil",
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                ),
                height: 30,
                width: 30,
                child: Center(
                child: Icon(Icons.person, 
                  color: Theme.of(context).primaryColor)
              ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: (int index){
                controller.currentPage = index;;
              },
              children: [
                GuidelinesPage(done: false),
                GuidelinesPage(),
              ],
            ),
          ),
          Observer(
            builder: (_) {
              return NavigatorButtons(
                currentPage: controller.currentPage,
                pageController: controller.pageController,
                totalPages: 2,
                canNavigate: false,
                focusedStepColor: ThemeConsts.textFieldColor,
                unfocusedStepColor: Theme.of(context).accentColor,
              );
            }
          )
        ],
      ),
    );
  }
}