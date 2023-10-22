import 'package:caisseapp/utils/global_methods.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShadowBox extends StatelessWidget {
  ShadowBox(
      {super.key,
      required this.child,
      required this.startColor,
      required this.endColor});
  Widget child;
  Color startColor, endColor;
  @override
  Widget build(BuildContext context) {
    final Size size = GlobalMethodes.getScreenSize(context);
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 8, 32),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        width: size.width * 0.75,
        height: 192,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: const Alignment(1, -1),
            end: const Alignment(-1, 1),
            colors: <Color>[startColor, endColor],
            stops: const <double>[0, 1],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3f000000),
              offset: Offset(0, 4),
              blurRadius: 2,
            ),
          ],
        ),
        child: child);
  }
}
