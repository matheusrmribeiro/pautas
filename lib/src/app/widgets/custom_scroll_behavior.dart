import 'package:flutter/material.dart';

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class CustomScrollConfiguration extends StatelessWidget{
  CustomScrollConfiguration({this.child});

  final Widget? child;
  
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlowBehavior(),
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }

}