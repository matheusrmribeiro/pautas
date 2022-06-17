import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'package:pautas/src/domain/entities/guideline_entity.dart';

class MainWidget extends StatefulWidget {
  MainWidget(this.guideline);

  final GuidelineEntity? guideline;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final TextStyles _textStylesConsts = TextStyles();
  GuidelineEntity? guideline;

  @override
  void initState() {
    super.initState();
    guideline = widget.guideline;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(widget.guideline!.title!,
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
                          Text(widget.guideline!.author!,
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
                              text: widget.guideline!.description,
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
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {
              Modular.to.pushNamed("/guideline/cadastre/edit", arguments: [0, widget.guideline])
              .then((value) {
                setState((){
                  guideline = (value as GuidelineEntity?);
                });
              });
            },
            child: Text("Editar",
              style: _textStylesConsts.h2White,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.accentColor)
            ),
          ),
        )
      ],
    );
  }
}