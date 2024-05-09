import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  final double? bottomMargin;
  final Widget bodyContent;
  final double? width;
  final Color? color;

  CommonContainer({
    this.bottomMargin,
    required this.bodyContent,
    this.color,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: bottomMargin ?? 0,
      ),
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color ?? Color(0xffe6e9ef),
        borderRadius: BorderRadius.all(Radius.circular(18)),
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
