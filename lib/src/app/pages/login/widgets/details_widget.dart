import 'package:flutter/material.dart';
import 'detail_step.dart';

class DetalhesAppWidget extends StatefulWidget {
  @override
  _DetalhesAppWidgetState createState() => _DetalhesAppWidgetState();
}

class _DetalhesAppWidgetState extends State<DetalhesAppWidget> {
  int? pageIndex;

  @override
  void initState() {
    super.initState();
    pageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50)
                )
              ),
              child: PageView(
                
                onPageChanged: (value) {
                  setState(() {
                    pageIndex = value;
                  });
                },
                children: <Widget>[
                  DetailStep(
                    image: "assets/images/login/image1.svg",
                    text: "Organize seu dia e suas reuniões"
                  ),
                  DetailStep(
                    title: "",
                    image: "assets/images/login/image2.svg",
                    text: "Controle seu tempo"
                  ),
                  DetailStep(
                    image: "assets/images/login/image3.svg",
                    text: "Traga mais agilidade para o seu dia-a-dia"
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                      color: pageIndex == 0 ? Colors.white : Colors.grey,
                      shape: BoxShape.circle),
                  height: pageIndex == 0 ? 8 : 6,
                  width: pageIndex == 0 ? 8 : 6,
                ),
                SizedBox(
                  width: 10,
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                      color: pageIndex == 1 ? Colors.white  : Colors.grey,
                      shape: BoxShape.circle),
                  height: pageIndex == 1 ? 8 : 6,
                  width: pageIndex == 1 ? 8 : 6,
                ),
                SizedBox(
                  width: 10,
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                      color: pageIndex == 2 ? Colors.white : Colors.grey,
                      shape: BoxShape.circle),
                  height: pageIndex == 2 ? 8 : 6,
                  width: pageIndex == 2 ? 8 : 6,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
