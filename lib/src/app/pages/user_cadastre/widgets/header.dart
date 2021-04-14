import 'package:flutter/material.dart';
import 'package:pautas/src/app/theme/text_style_consts.dart';

class Header extends StatelessWidget {

  Header({Key key, this.title = "", this.subtitle = ""}) : super(key: key);

  final TextStylesConsts textStylesConsts = TextStylesConsts();
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
            softWrap: true,
            style: textStylesConsts.h1,
          ),
          Divider(color: Colors.transparent, height: 10,),
          Text(subtitle,
            softWrap: true,
            style: textStylesConsts.h2,
          ),
        ],
      )
    );
  }
}