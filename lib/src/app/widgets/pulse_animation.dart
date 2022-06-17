import 'package:flutter/material.dart';

class PulseAnimator extends StatefulWidget {
  const PulseAnimator({Key? key, this.child, this.pulseColor = Colors.grey}) : super(key: key);

  final Widget? child;
  final Color? pulseColor;

  @override
  _PulseAnimatorState createState() => _PulseAnimatorState();
}

class _PulseAnimatorState extends State<PulseAnimator> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: widget.pulseColor,
            shape: BoxShape.circle
          ),
        ),   
        Container(
          child: widget.child,
          margin: EdgeInsets.all(1),
        )
      ],
    );
  }
}