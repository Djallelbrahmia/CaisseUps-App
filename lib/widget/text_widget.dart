import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextWidget extends StatelessWidget {
  TextWidget(
      {super.key,
      required this.isBold,
      required this.isHeader,
      required this.textSize,
      required this.text,
      this.color,
      this.maxLines});
  bool isBold, isHeader;
  double textSize;
  String text;
  Color? color = Colors.black;
  int? maxLines = 3;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: isHeader
          ? GoogleFonts.playfairDisplay(
              color: color,
              fontSize: textSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal)
          : GoogleFonts.openSans(
              color: color,
              fontSize: textSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
