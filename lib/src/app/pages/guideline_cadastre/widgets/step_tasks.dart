import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_field_styles.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/app/widgets/customTextFormField.dart';
import 'package:pautas/src/domain/entities/task_entity.dart';
import '../guideline_cadastre_controller.dart';
import 'header.dart';

class StepTasks extends StatelessWidget {

  StepTasks({required this.controller}) {
    controller.addStepCallback(() async {
      await controller.addGuideline();
      return true;
    });
  }

  final GuidelineCadastreController controller;
  final TextEditingController _textController = TextEditingController();
  final TextStyles textStylesConsts = TextStyles();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Header(title: "Tarefas", subtitle: "O que precisa ser feito?"),
            Container(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: CustomTextFormField(
                        controller: _textController,
                        decoration: TextFieldStylesConsts.textFieldContext(
                          context: context, 
                          hint: "Descrição...", 
                          label: "",
                          backgroundColor: AppColors.hintColor,
                        ),
                        maxLength: 250,
                        useStyle: false,
                        maxLines: 1,
                        minLines: 1,
                        ancestor: 1,
                        style: textStylesConsts.textFieldNormal,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        onFieldSubmited: (String? text) {
                          Modular.to.pop();
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Ink(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.hintColor,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: InkWell(
                          onTap: () {
                            if (_textController.text.isEmpty)
                              return;

                            if (controller.newGuideline!.tasks!.isEmpty)
                              controller.newGuideline!.tasks = [];

                            controller.addTask(
                              TaskEntity(
                                text: _textController.text
                              )
                            );

                            _textController.clear();
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Observer(
                builder: (_) {
                  return ListView.separated(
                    itemCount: controller.tasks.length,
                    itemBuilder: (_, int index) {
                      TaskEntity task = controller.tasks[index];

                      return ListTile(
                        leading: Checkbox(
                          value: controller.tasks[index].done,
                          onChanged: (value) {
                            controller.tasks[index] = TaskEntity(
                              done: !task.done!,
                              text: task.text
                            );
                          },
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            controller.tasks.removeAt(index);
                          },
                          icon: Icon(Icons.delete),
                        ),
                        onTap: () {
                          controller.tasks[index] = TaskEntity(
                            done: !task.done!,
                            text: task.text
                          );
                        },
                        title: Text(
                          task.text!,
                          style: task.done!
                            ? textStylesConsts.taskDone
                            : textStylesConsts.taskNormal,
                        ),
                      );
                    },
                    separatorBuilder: (_, index) {
                      return Divider();
                    },
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }

}