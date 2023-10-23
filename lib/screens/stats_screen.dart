import 'package:caisseapp/utils/constants.dart';
import 'package:caisseapp/utils/global_methods.dart';
import 'package:caisseapp/widget/shadow_box.dart';
import 'package:caisseapp/widget/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  Future<Map<String, dynamic>> fetchData() async {
    final DateRange range = DateRange(
        DateTime.now().subtract(const Duration(days: 1)), DateTime.now());
    final createdDoc = await FirebaseFirestore.instance
        .collection("shippement")
        .where("createdAt", isGreaterThanOrEqualTo: range.start)
        .where("createdAt", isLessThanOrEqualTo: range.end)
        .where("userId", isEqualTo: authInstance.currentUser!.uid)
        .get();
    final created = createdDoc.docs.toList();
    final paidDoc =
        await FirebaseFirestore.instance.collection("shippement").get();
    final paid = paidDoc.docs.toList();
    double totalAmount = 0;
    paid.forEach((element) {
      print("hello");
      totalAmount = totalAmount + double.parse(element["cod"]);
    });
    final received = created.length;
    return {"totalAmount": totalAmount, "received": received};
  }

  @override
  Widget build(BuildContext context) {
    final Size size = GlobalMethodes.getScreenSize(context);
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
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
                        child: InkWell(
                          onTap: () async {
                            final data = await fetchData();
                            print(data["totalAmount"]);
                          },
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
                                constraints:
                                    BoxConstraints(maxWidth: size.width * 0.6),
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
                                        text:
                                            "${snapshot.data!['totalAmount']} DZD")
                                  ],
                                ),
                              )
                            ],
                          ),
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
                              constraints:
                                  BoxConstraints(maxWidth: size.width * 0.6),
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
                                      text: "${snapshot.data!['received']}PCs")
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xfff4e4ff),
            ),
          );
        });
  }
}
