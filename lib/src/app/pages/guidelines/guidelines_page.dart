import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas/src/app/controllers/root_controller.dart';
import 'package:pautas/src/app/pages/guidelines/widgets/guideline_item.dart';
import 'package:pautas/src/app/theme/text_styles.dart';
import 'guidelines_controller.dart';

class GuidelinesPage extends StatefulWidget {
  
  GuidelinesPage({this.done = true});

  final bool done;

  @override
  _GuidelinesPageState createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  
  final TextStyles textStyles = TextStyles();
  GuidelinesController controller;
  RootController rootController = Modular.get<RootController>();

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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getData();
        },
        child: Container(
          child: Observer(
            builder: (_) {
              return (controller.guidelines.length == 0)
                ?  (!controller.loading) 
                  ? TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1), 
                    duration: Duration(milliseconds: 2000),
                    curve: Curves.fastOutSlowIn,
                    builder: (_, value, child) {
                      return Opacity(
                        opacity: value,
                        child: child,
                      );
                    },
                    child: Center(
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
                    ),
                  )
                  :
                  Container()
                : AnimationLimiter(
                  child: ListView.builder(
                    itemCount: controller.guidelines.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            horizontalOffset: (widget.done) ? 50 : -50,
                            child: FadeInAnimation(
                              child: GuidelineItem(controller.guidelines[index], controller),
                            ),
                          ),
                        );
                      },
                    ),
                );
            }
          ),
        ),
      ),
      floatingActionButton: 
      (widget.done)
        ? null
        : FloatingActionButton(
          onPressed: () {
            Modular.to.pushNamed("/guideline/cadastre").then((value) async {
              await Future.delayed(Duration(milliseconds: 1000));
              controller.getData();
            });
          },
          child: Icon(Icons.add, color: Colors.white,),
        )
      
    );
  }
}