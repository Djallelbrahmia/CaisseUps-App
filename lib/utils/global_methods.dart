import 'package:caisseapp/widget/text_widget.dart';
import 'package:flutter/material.dart';

class GlobalMethodes {
  static Size getScreenSize(BuildContext context) =>
      MediaQuery.of(context).size;
  static ThemeData getThemeData() => ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFF4E4FF),
            primary: const Color(0Xff4B0082),
            secondary: const Color(0XffDAA520),
            background: const Color(0XffF7F9F8),
            tertiary: const Color(0xff8FBC8F)),
        useMaterial3: true,
      );
  static Future<void> ErrorDialog(
      {required String subtitle, required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: Row(
            children: [
              Image.asset(
                "assets/warning-sign.png",
                height: 24,
                width: 24,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 16,
              ),
              const Text("Erreur")
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
              child: TextWidget(
                isBold: true,
                text: "Ok",
                color: Colors.black,
                isHeader: true,
                textSize: 20,
              ),
            ),
          ],
          content: Text(subtitle),
        );
      },
    );
  }
}
