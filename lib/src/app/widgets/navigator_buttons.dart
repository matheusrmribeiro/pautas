import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pautas/src/app/theme/color_consts.dart';

class NavigatorButtons extends StatefulWidget {
  NavigatorButtons({
    @required this.pageController, 
    this.canNavigate = true,
    @required this.currentPage, 
    @required this.totalPages, 
    this.nextCallback,
    this.unfocusedStepColor = Colors.white,
    this.focusedStepColor = ThemeConsts.textFieldColor,
  });

  final PageController pageController;
  final int currentPage;
  final int totalPages;
  final Function nextCallback;
  final bool canNavigate;
  final Color unfocusedStepColor;
  final Color focusedStepColor;

  @override
  _NavigatorButtonsState createState() => _NavigatorButtonsState();
}

class Steps{
  Steps({this.index, this.color});

  int index;
  Color color;
}

class _NavigatorButtonsState extends State<NavigatorButtons> {

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.totalPages; i++)
      steps.add(Steps(index: i, color: ThemeConsts.textFieldColor));
  }
  
  List<Steps> steps = List<Steps>();
  bool isLastPage = false;
  bool ignoreNext = false;

  @override
  Widget build(BuildContext context) {
    if (widget.canNavigate) {
      isLastPage = (widget.currentPage == (widget.totalPages-1));

      if ((!isLastPage) && (ignoreNext))
      setState(() { ignoreNext = false; });

    }
    
    steps.forEach((step){
      step.color = (widget.currentPage == step.index) ? widget.unfocusedStepColor : widget.focusedStepColor;
    });

    return IgnorePointer(
      ignoring: ignoreNext,
      child: Container(
        height: 50,
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Visibility(
              visible: widget.canNavigate,
              child: (widget.currentPage > 0)
              ? Container(
                width: 40,
                child: IconButton(
                    icon: Icon(FeatherIcons.chevronLeft, 
                      size: 30, 
                      color: ThemeConsts.textFieldColor),
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      if (!ignoreNext)
                        widget.pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                    },
                  ),
              )
              : Container(width: 40,),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: steps.map((step){
                  return Container(
                    height: 10,
                    width: 10,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: step.color
                    )
                  );
                }).toList(),
              ),
            ),
            Visibility(
              visible: widget.canNavigate,
              child: Container(
                width: 40,
                child: IconButton(
                  icon: Icon(isLastPage
                    ? FeatherIcons.check 
                    : FeatherIcons.chevronRight,
                  size: 30, 
                  color: Colors.white),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    final bool goToNextPage = await widget.nextCallback();              

                    if (goToNextPage)
                      if (isLastPage)
                        setState(() { ignoreNext = true; });
                      else
                        widget.pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}