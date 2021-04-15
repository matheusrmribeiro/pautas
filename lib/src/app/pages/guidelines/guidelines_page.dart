import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas/src/app/controllers/root_controller.dart';
import 'package:pautas/src/app/pages/guidelines/widgets/guideline_item.dart';
import 'package:pautas/src/app/theme/colors.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'guidelines_controller.dart';

class GuidelinesPage extends StatefulWidget {
  
  GuidelinesPage({this.done = true});

  final bool done;

  @override
  _GuidelinesPageState createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> with AutomaticKeepAliveClientMixin<GuidelinesPage> {
  
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(); 
  final TextStyles textStyles = TextStyles();
  GuidelinesController controller;
  RootController rootController = Modular.get<RootController>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    controller = GuidelinesController(done: widget.done);
    controller.getData();
    reaction(
      (_) => rootController.currentPage, 
      (msg) => controller.getData(), 
      name: (widget.done) ? "guidelineDone" : "guideline"
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text((widget.done) ? "Finalizadas" : "Abertas",
              style: textStyles.h1Primary,
            ),
            Observer(
              builder: (_) {
                return Container(
                  width: 35,
                  margin: EdgeInsets.only(left: 10, top: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.hintColor)
                  ),
                  child: Center(
                    child: Text((controller.guidelines.length > 999)
                      ? "999+"
                      : controller.guidelines.length.toString(),
                      style: textStyles.headerInfo,
                    ),
                  ),
                );
              }
            ),
            Expanded(
              child: Container(),
            ),
            (widget.done)
              ? Container()
              : TextButton(
                onPressed: (){
                  Modular.to.pushNamed("/guideline/cadastre").then((value) async {
                    await Future.delayed(Duration(milliseconds: 1000));
                    controller.getData();
                  });
                },
                child: Text("Adciconar"),
              )
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getData();
        },
        child: Container(
          child: Observer(
            builder: (_) {
              return (controller.guidelines.length == 0)
                ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset("assets/images/login/no_data.svg",
                        width: MediaQuery.of(context).size.height * 0.5,
                        height: MediaQuery.of(context).size.width * 0.6,
                      ),
                      Text("Não existem pautas ${(controller.done) ? "finalizadas" : "abertas"}...",
                        style: textStyles.h2Primary,
                      )
                    ],
                  ),
                )
                : ListView.builder(
                    itemCount: controller.guidelines.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GuidelineItem(controller.guidelines[index], controller);
                    },
                  );
            }
          ),
        ),
      ),
    );
  }
}