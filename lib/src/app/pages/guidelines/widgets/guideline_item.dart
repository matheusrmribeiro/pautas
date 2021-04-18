import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas/src/app/pages/guidelines/guidelines_controller.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/domain/entities/guideline_entity.dart';

class GuidelineItem extends StatefulWidget {
  GuidelineItem(this.guidelineEntity, this.controller);

  final GuidelineEntity guidelineEntity;
  final GuidelinesController controller;

  @override
  _GuidelineItemState createState() => _GuidelineItemState();
}

class _GuidelineItemState extends State<GuidelineItem> {
  final TextStyles textStyles = TextStyles();

  String _tasksDone() =>
    widget.guidelineEntity.tasks.where((element) => element.done).toList().length.toString();

  String _tasksTotal() =>
    widget.guidelineEntity.tasks.length.toString();

  bool _allDone() => (widget.guidelineEntity.tasks.isEmpty) ||
    (widget.guidelineEntity.tasks.where((element) => !element.done).isEmpty);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      height: 120,
      child: Hero(
        tag: "GuidelineItem${widget.guidelineEntity.id}",
        child: GestureDetector(
          onTap: (){
            Modular.to.pushNamed("/guideline/detail", 
              arguments: [widget.controller, widget.guidelineEntity])
            .then((value) => widget.controller.getData());
          },
          child: Card(
            color: (_allDone())
              ? AppColors.guidelineItemColor
              : AppColors.textFieldSuccessColor,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                ),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 30,
                      child: Text(widget.guidelineEntity.title,
                        overflow: TextOverflow.ellipsis,
                        style: textStyles.guidelineItemTitle,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(right: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.guidelineEntity.description,
                              style: textStyles.guidelineItemDescription,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text((_tasksTotal() == "0") 
                        ? ""
                        : "Tarefas finalizadas: ${_tasksDone()} de ${_tasksTotal()}",
                        overflow: TextOverflow.ellipsis,
                        style: textStyles.guidelineItemHint,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}