import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/domain/entities/guideline_entity.dart';

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
  
  @override
  void initState() {
    super.initState();
    guideline = widget.guideline;
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
                              guideline.done = !guideline.done;
                              widget.controller.updateStatus(guideline);
                              widget.controller.getData();
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
                    margin: EdgeInsets.only(top: AppBar().preferredSize.height),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Text(guideline.title,
                                    maxLines: 2,
                                    softWrap: true,
                                    style: GoogleFonts.roboto(
                                      fontSize: 30, 
                                      color: AppColors.textFieldColor,
                                      fontWeight: FontWeight.w500)
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 40, 20, 10),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Autor",
                                              style: _textStylesConsts.guidelineDetailTitle
                                            ),
                                            SizedBox(height: 10),
                                            Text(guideline.author,
                                              style: _textStylesConsts.guidelineDetailInfo
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 40),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Descrição",
                                              style: _textStylesConsts.guidelineDetailTitle
                                            ),
                                            SizedBox(height: 10),
                                            RichText(
                                              text: TextSpan(
                                                text: guideline.details,
                                                style: _textStylesConsts.guidelineDetailInfo
                                              ),
                                              softWrap: true,
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 40),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Detalhes",
                                              style: _textStylesConsts.guidelineDetailTitle
                                            ),
                                            SizedBox(height: 10),
                                            RichText(
                                              text: TextSpan(
                                                text: guideline.details,
                                                style: _textStylesConsts.guidelineDetailInfo
                                              ),
                                              softWrap: true,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ),
                              ],
                            ),
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