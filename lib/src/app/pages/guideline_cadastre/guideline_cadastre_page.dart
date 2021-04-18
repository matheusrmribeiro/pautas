import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/widgets/custom_scroll_behavior.dart';
import 'package:pautas/src/app/widgets/navigator_buttons.dart';
import 'package:pautas/src/domain/entities/guideline_entity.dart';
import 'guideline_cadastre_controller.dart';
import 'widgets/step1.dart';
import 'widgets/step2.dart';
import 'widgets/step3.dart';
import 'widgets/step_tasks.dart';

class GuidelineCadastrePage extends StatefulWidget {
  GuidelineCadastrePage({this.guideline, this.index});

  final GuidelineEntity guideline;
  final int index;

  @override
  _GuidelineCadastreState createState() => _GuidelineCadastreState();
}

class _GuidelineCadastreState extends State<GuidelineCadastrePage> {

  final GuidelineCadastreController controller = GuidelineCadastreController();
  final List<Widget> steps = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      controller.pageController.jumpToPage(widget.index);
    });

    if (widget.guideline != null)
      controller.setGuideline(widget.guideline);

    steps.addAll([
      Step1(controller: controller), 
      Step2(controller: controller),
      Step3(controller: controller),
      StepTasks(controller: controller), 
    ]);
  }

  @override
  void dispose() {
    controller.pageController.dispose();
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
                controller: controller.pageController,
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
                  pageController: controller.pageController, 
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
