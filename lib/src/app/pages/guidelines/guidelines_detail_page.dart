import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas/src/app/pages/guidelines/widgets/main_widget.dart';
import 'package:pautas/src/app/pages/guidelines/widgets/tasks_widget.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/app/widgets/tab_widget.dart';
import 'package:pautas/src/domain/entities/guideline_entity.dart';
import 'package:pautas/src/domain/entities/task_entity.dart';

import 'guidelines_controller.dart';

class GuidelineDetailPage extends StatefulWidget {
  
  const GuidelineDetailPage({Key key, @required this.controller, this.guideline}) : super(key: key);

  final GuidelineEntity guideline;
  final GuidelinesController controller;

  @override
  _GuidelineDetailPageState createState() => _GuidelineDetailPageState();
}

class _GuidelineDetailPageState extends State<GuidelineDetailPage> {

  GuidelineEntity guideline;
  final TextStyles _textStylesConsts = TextStyles();
  final PageController pageController = PageController();

  @observable
  ObservableList<TaskEntity> tasks = <TaskEntity>[].asObservable();

  @override
  void initState() {
    super.initState();
    guideline = widget.guideline;
    tasks = guideline.tasks.asObservable();
  }

  Future<bool> _showDeleteDialog() async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Atenção"),
          content: Text("Deseja realmente excluir?"),
          actions: <Widget>[
            TextButton(
              child: Text("Sim",
                style: TextStyle(
                  color: Theme.of(context).primaryColor
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
              ),
              child: Text("Não",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Hero(
        tag: "GuidelineItem${widget.guideline.id}",
        child: Material(
          color: AppColors.backgroundColor,
          child: SafeArea(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    height: AppBar().preferredSize.height,
                    child: Row(
                      children: [
                        IconButton(
                          tooltip: "Voltar",
                          icon: Icon(FeatherIcons.xCircle, color: Colors.white,),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Expanded(
                          child: IconButton(
                            tooltip: (guideline.done) 
                              ? "Reabrir" 
                              : "Finalizar",
                            icon: Icon((guideline.done)
                              ? FeatherIcons.repeat 
                              : FeatherIcons.checkCircle, 
                              color: Colors.white,
                            ),
                            onPressed: () {
                              widget.controller.changeStatus(guideline);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        IconButton(
                          tooltip: "Excluir",
                          icon: Icon(Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            bool canDelete = await _showDeleteDialog();
                            if (canDelete) {
                              widget.controller.deleteGuideline(widget.guideline);
                              widget.controller.getData();
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: AppBar().preferredSize.height + 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: TabWidget(
                            controller: pageController,
                            tabs: [
                              TabEntity(text: "Principal"),
                              TabEntity(text: "Tarefas")
                            ],
                            activeTextStyle: _textStylesConsts.tabInactive.copyWith(fontWeight: FontWeight.bold),
                            inactiveTextStyle: _textStylesConsts.tabActive.copyWith(fontWeight: FontWeight.normal),
                            hintColor: AppColors.accentColor,
                          ),
                        ),
                        Expanded(
                          child: PageView(
                            controller: pageController,
                            children: [
                              MainWidget(guideline),
                              TasksWidget(guideline: guideline, controller: widget.controller),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}