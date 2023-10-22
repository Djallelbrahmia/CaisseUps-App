import 'package:caisseapp/utils/global_methods.dart';
import 'package:caisseapp/widget/text_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  ButtonWidget(
      {super.key,
      required this.widthPortion,
      required this.color,
      required this.image,
      required this.text,
      required this.textColor,
      required this.onTap});
  double widthPortion;
  Color color, textColor;
  String image, text;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = GlobalMethodes.getScreenSize(context);
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 64,
        width: size.width * widthPortion,
        margin: const EdgeInsets.fromLTRB(0, 0, 4, 4),
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3f000000),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
              width: 24,
              height: 24,
              child: Image.asset(
                image,
                width: 24,
                height: 24,
              ),
            ),
            TextWidget(
              isBold: false,
              isHeader: true,
              textSize: 14,
              text: text,
              color: textColor,
            )
          ],
        ),
      ),
    );
  }
}
