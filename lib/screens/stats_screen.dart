import 'package:caisseapp/utils/global_methods.dart';
import 'package:caisseapp/widget/shadow_box.dart';
import 'package:caisseapp/widget/text_widget.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = GlobalMethodes.getScreenSize(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            // upsilustration1mYs (13:15)
            width: double.infinity,
            height: size.height * 0.3,
            child: Image.asset(
              "assets/ups_ilustration.png",
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ShadowBox(
            startColor: const Color(0Xff8FBC8F),
            endColor: const Color(0XffB3E0B3),
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // banknotesYLf (11:95)
                    margin: const EdgeInsets.fromLTRB(0, 1, 16, 0),
                    width: 48,
                    height: 48,
                    child: Image.asset(
                      'assets/icons/Cash.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: size.width * 0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                            isBold: true,
                            isHeader: true,
                            textSize: 24,
                            maxLines: 3,
                            text: "Some encaissé \n Aujourd’hui :"),
                        TextWidget(
                            isBold: false,
                            isHeader: false,
                            textSize: 24,
                            maxLines: 3,
                            text: "36.000 DZD")
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          ShadowBox(
            startColor: const Color(0xffdaa520),
            endColor: const Color(0xffffde8c),
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // banknotesYLf (11:95)
                    margin: const EdgeInsets.fromLTRB(0, 1, 16, 0),
                    width: 48,
                    height: 48,
                    child: Image.asset(
                      'assets/icons/EmptyBox.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: size.width * 0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                            isBold: true,
                            isHeader: true,
                            textSize: 24,
                            maxLines: 3,
                            text: "Colis Récupéré \n Aujourd’hui :"),
                        TextWidget(
                            isBold: false,
                            isHeader: false,
                            textSize: 24,
                            maxLines: 3,
                            text: "36PCs")
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
