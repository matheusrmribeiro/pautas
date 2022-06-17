import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pautas/src/app/theme/text_styles.dart';

class DetailStep extends StatelessWidget {
  DetailStep({Key? key, this.title = "", this.text, this.image}) : super(key: key);

  final String title;
  final String? text;
  final String? image;

  final TextStyles stylesConsts = TextStyles();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(title,
          style: stylesConsts.loginHint,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset(image!,
              width: MediaQuery.of(context).size.height * 0.5,
              height: MediaQuery.of(context).size.width * 0.9,
            )
          )
        ),
        Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 5),
          child: Text(text!,
            style: stylesConsts.loginHint,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ),        
      ],
    );
  }
}