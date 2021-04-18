import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas/src/app/pages/guideline_cadastre/guideline_cadastre_controller.dart';
import 'package:pautas/src/app/pages/guidelines/guidelines_controller.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/domain/entities/guideline_entity.dart';
import 'package:pautas/src/domain/entities/task_entity.dart';

class TasksWidget extends StatefulWidget {
  TasksWidget({this.guideline, this.controller});

  final GuidelineEntity guideline;
  final GuidelinesController controller;

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  final TextStyles _textStylesConsts = TextStyles();

  @override
  void initState() {
    super.initState();
    tasks.addAll(widget.guideline.tasks);
  }

  final List<TaskEntity> tasks = <TaskEntity>[];

  void onTap(int index) {
    setState(() {
      tasks[index] = TaskEntity(
        done: !tasks[index].done,
        text: tasks[index].text
      );
    });
    widget.guideline.tasks[index] = tasks[index];
    widget.controller.updateTask(widget.guideline);
  }

  String _tasksOpen() =>
    tasks.where((element) => !element.done).toList().length.toString();

  String _tasksDone() =>
    tasks.where((element) => element.done).toList().length.toString();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            Container(
              height: 40,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Abertas: ${_tasksOpen()}",
                    style: _textStylesConsts.tabInactive,
                  ),
                  Text("Finalizadas: ${_tasksDone()}",
                    style: _textStylesConsts.tabInactive,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.accentColor)
                    ),
                    onPressed: () {
                      GuidelineCadastreController cadastre = GuidelineCadastreController();
                      cadastre.newGuideline = widget.guideline;
                      Modular.to.pushNamed("/guideline/cadastre/edit", arguments: [3, widget.guideline])
                      .then((value) {
                        widget.guideline.tasks = (value as GuidelineEntity).tasks;
                        setState((){
                          tasks.clear();
                          tasks.addAll(widget.guideline.tasks);
                        });
                      });
                    },
                    child: Icon(Icons.add)
                  )
                ],
              ),
            ),
            Expanded(
              child: (tasks.isEmpty)
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/guidelines/no_tasks.svg",
                      width: MediaQuery.of(context).size.height * 0.5,
                      height: MediaQuery.of(context).size.width * 0.6,
                    ),
                    SizedBox(height: 50,),
                    Text("Nenhuma tarefa encontrada",
                      style: _textStylesConsts.hint,
                    )
                  ],
                )
                : ListView.separated(
                  itemCount: tasks.length,
                  itemBuilder: (_, int index) {
                    TaskEntity task = tasks[index];

                    return ListTile(
                      leading: Checkbox(
                        value: tasks[index].done,
                        onChanged: (value) {
                          onTap(index);
                        },
                      ),
                      onTap: () {
                        onTap(index);
                      },
                      title: Text(
                        task.text,
                        style: (task.done)
                          ? _textStylesConsts.taskDone
                          : _textStylesConsts.taskNormal,
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return Divider();
                  },
                )
            ),
          ],
        );
      }
    );
  }
}