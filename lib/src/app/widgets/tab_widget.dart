import 'package:flutter/material.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_styles.dart';

class TabWidget extends StatefulWidget {
  TabWidget({
    this.controller, 
    this.tabs, 
    this.activeTextStyle,
    this.inactiveTextStyle, 
    this.hintColor
  });

  final PageController controller;
  final List<TabEntity> tabs;
  final TextStyle activeTextStyle;
  final TextStyle inactiveTextStyle;
  final Color hintColor;

  @override
  _TabWidgetState createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  final TextStyles textStyles = TextStyles();
  double position = 0;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      double diff = (widget.controller.page - currentIndex).abs();
      if ((diff >= 0.8) && (diff <= 1))
        updateTab(widget.tabs[widget.controller.page.toInt()]);
    });
  }

  void updateTab(TabEntity tab) {
    final RenderBox renderBoxRed = tab.key.currentContext.findRenderObject();
    final widgetPosition = renderBoxRed.localToGlobal(Offset.zero);
    setState(() {
      position = widgetPosition.dx - 20;
      currentIndex = widget.tabs.indexOf(tab);
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
            children: widget.tabs.map((e) => 
              Container(
                margin: (widget.tabs.indexOf(e) == 0) 
                  ? null 
                  : EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    widget.controller.animateToPage(
                      widget.tabs.indexOf(e), 
                      duration: Duration(milliseconds: 375), 
                      curve: Curves.easeInOut
                    );
                  },
                  child: Text(e.text,
                    key: e.key,
                    style: (currentIndex == widget.tabs.indexOf(e)) 
                      ? (widget.activeTextStyle == null) 
                        ? textStyles.tabActive 
                        : widget.activeTextStyle
                      : (widget.inactiveTextStyle == null) 
                        ? textStyles.tabInactive 
                        : widget.inactiveTextStyle,
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
              color: (widget.hintColor == null) 
                ? AppColors.backgroundColor 
                : widget.hintColor,
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