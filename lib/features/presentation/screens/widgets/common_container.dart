import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  @override
  final BorderRadius borderRadius;
  final TextStyle textStyle;
  final double bottomMargin;
  final double allPadding;
  final Widget bodyContent;
  final double width;
  final Color color;

  CommonContainer(
      {this.borderRadius,
        this.textStyle,
        this.bottomMargin,
        this.allPadding,
        this.width,
        this.bodyContent,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: bottomMargin ?? 0,
      ),
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color ?? Color(0xffe6e9ef),
        borderRadius: BorderRadius.all(
            Radius.circular(18)),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(-2.0, -2.0),
          ),
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
      child: bodyContent,
    );
  }
}
