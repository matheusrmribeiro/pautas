import 'package:flutter/material.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_styles.dart';

class TabWidget extends StatefulWidget {
  TabWidget({this.controller});

  final PageController controller;

  @override
  _TabWidgetState createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  final TextStyles textStyles = TextStyles();

  final List<TabEntity> tabs = [
    TabEntity(text: "Em progresso"),
    TabEntity(text: "Finalizadas")
  ];

  double position = 0;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      double diff = (widget.controller.page - currentIndex).abs();
      if ((diff >= 0.8) && (diff <= 1))
        updateTab(tabs[widget.controller.page.toInt()]);
    });
  }

  void updateTab(TabEntity tab) {
    final RenderBox renderBoxRed = tab.key.currentContext.findRenderObject();
    final widgetPosition = renderBoxRed.localToGlobal(Offset.zero);
    setState(() {
      position = widgetPosition.dx - 20;
      currentIndex = tabs.indexOf(tab);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Stack(
        children: [
          Row(
            children: tabs.map((e) => 
              Container(
                margin: (tabs.indexOf(e) == 0) ? null : EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    widget.controller.animateToPage(
                      tabs.indexOf(e), 
                      duration: Duration(milliseconds: 375), 
                      curve: Curves.easeInOut
                    );
                  },
                  child: Text(e.text,
                    key: e.key,
                    style: (currentIndex == tabs.indexOf(e)) 
                      ? textStyles.tabActive 
                      : textStyles.tabInactive,
                  ),
                ),
              )
            ).toList(),
          ),
          AnimatedPositioned(
            bottom: 0,
            left: position,
            duration: Duration(milliseconds: 375),
            child: Container(
              height: 3,
              width: 50,
              color: AppColors.backgroundColor,
            ), 
          )
        ],
      ),
    );
  }
}

class TabEntity {
  
  TabEntity({this.text});

  final String text;
  final GlobalKey key = GlobalKey();

}