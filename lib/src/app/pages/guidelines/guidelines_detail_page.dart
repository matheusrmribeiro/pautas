import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pautas/src/app/theme/color_consts.dart';
import 'package:pautas/src/app/theme/text_style_consts.dart';
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
  final TextStylesConsts _textStylesConsts = TextStylesConsts();
  
  @override
  void initState() {
    super.initState();
    guideline = widget.guideline;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: ThemeConsts.backgroundColor,
        leading: IconButton(
          tooltip: "Voltar",
          icon: Icon(FeatherIcons.xCircle, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
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
        ],
      ),
      backgroundColor: ThemeConsts.backgroundColor,
      body: Hero(
        tag: "GuidelineItem${widget.guideline.id}",
        child: Material(
          color: ThemeConsts.backgroundColor,
          child: Container(
            width: double.infinity,
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
                              color: ThemeConsts.textFieldColor,
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
        ),
      ),
    );
  }

}