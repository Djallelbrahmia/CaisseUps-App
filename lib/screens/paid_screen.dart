import 'package:caisseapp/utils/global_methods.dart';
import 'package:caisseapp/widget/button_widget.dart';
import 'package:caisseapp/widget/loading_manager.dart';
import 'package:caisseapp/widget/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class PaidScreen extends StatefulWidget {
  const PaidScreen({super.key});

  @override
  State<PaidScreen> createState() => _PaidScreenState();
}

class _PaidScreenState extends State<PaidScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _clientFocusNode = FocusNode();
  final TextEditingController _clientController = TextEditingController();
  final FocusNode _originFocusNode = FocusNode();
  final TextEditingController _originController = TextEditingController();
  final FocusNode _destinationFocusNode = FocusNode();
  final TextEditingController _destinationController = TextEditingController();
  final FocusNode _codFocusNode = FocusNode();
  final TextEditingController _codController = TextEditingController();

  final FocusNode _truckFocusNode = FocusNode();
  final TextEditingController _truckController = TextEditingController();

  bool _dataIsScanned = false;
  bool _trackingScanned = false;
  @override
  void dispose() {
    _clientFocusNode.dispose();
    _originFocusNode.dispose();
    _destinationFocusNode.dispose();
    _codFocusNode.dispose();
    _clientController.dispose();
    _originController.dispose();
    _destinationController.dispose();
    _codController.dispose();
    _dataIsScanned = false;

    super.dispose();
  }

  Future<void> scanBarreCode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _truckController.text = barcodeScanRes;
    });
  }

  Future<void> paymentArrived(String state) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseFirestore.instance
          .collection("shippement")
          .doc(_truckController.text)
          .update({"status": state, "updatedAt": DateTime.now()});
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        GlobalMethodes.ErrorDialog(
            subtitle: "échec de synchronisation ", context: context);
      }
    } finally {
      setState(() {
        _isLoading = false;
        _trackingScanned = false;
        _truckController.text = "";
        _clientController.text = '';
        _originController.text = "";
        _destinationController.text = "";
        _codController.text = "";
        _dataIsScanned = false;
      });
    }
  }

  Future<void> valider() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final data = await FirebaseFirestore.instance
          .collection("shippement")
          .where("tracking", isEqualTo: _truckController.text)
          .get();
      setState(() {
        _clientController.text = data.docs.first["client"];
        _originController.text = data.docs.first["origin"];
        _destinationController.text = data.docs.first["destination"];
        _codController.text = data.docs.first["cod"];
        _dataIsScanned = true;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        GlobalMethodes.ErrorDialog(
            subtitle: "Vérifier le code barre", context: context);
      }
      setState(() {
        _truckController.text = "";
      });
    } finally {
      setState(() {
        _isLoading = false;
        _trackingScanned = false;

        _dataIsScanned = true;
      });
    }
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final Size size = GlobalMethodes.getScreenSize(context);

    return LoadingManger(
      isLoading: _isLoading,
      child: SingleChildScrollView(
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
              InkWell(
                onTap: () async {
                  setState(() {
                    _trackingScanned = false;
                    _clientController.text = '';
                    _originController.text = "";
                    _destinationController.text = "";
                    _codController.text = "";
                    _dataIsScanned = false;
                  });
                  await scanBarreCode();
                  setState(() {
                    _trackingScanned = true;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: _trackingScanned ? 186 : 208,
                  height: _trackingScanned ? 186 : 208,
                  child: Image.asset(
                    "assets/barrecode.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Visibility(
                visible: _trackingScanned,
                child: TextFieldWidget(
                    onEditingComplete: () {},
                    isEnabled: true,
                    focusNode: _truckFocusNode,
                    textEditingController: _truckController,
                    leftIcon: "assets/icons/truck.png",
                    label: ""),
              ),
              const SizedBox(
                height: 12,
              ),
              Visibility(
                visible: _trackingScanned,
                child: ButtonWidget(
                    widthPortion: 0.3,
                    color: const Color(0xff8FBC8F),
                    image: "assets/icons/Done.png",
                    text: "Valider",
                    textColor: Colors.black,
                    onTap: () async {
                      try {
                        await valider();
                        setState(() {
                          _trackingScanned = false;
                        });
                      } catch (e) {}
                    }),
              ),
              _dataIsScanned
                  ? Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFieldWidget(
                              onEditingComplete: () {},
                              isEnabled: false,
                              focusNode: _clientFocusNode,
                              textEditingController: _clientController,
                              leftIcon: "assets/icons/client.png",
                              label: "Client"),
                          TextFieldWidget(
                              onEditingComplete: () {},
                              isEnabled: false,
                              focusNode: _originFocusNode,
                              textEditingController: _originController,
                              leftIcon: "assets/icons/origin.png",
                              label: "Origin"),
                          TextFieldWidget(
                              onEditingComplete: () {},
                              isEnabled: false,
                              focusNode: _destinationFocusNode,
                              textEditingController: _destinationController,
                              leftIcon: "assets/icons/destination.png",
                              label: "Destination"),
                          TextFieldWidget(
                              onEditingComplete: () {},
                              isEnabled: false,
                              focusNode: _codFocusNode,
                              textEditingController: _codController,
                              leftIcon: "assets/icons/Cash.png",
                              label: "COD"),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ButtonWidget(
                                  widthPortion: 0.3,
                                  color: const Color(0xffA90000),
                                  image: "assets/icons/Cancel.png",
                                  text: "Cancel",
                                  textColor: const Color(0xffF7F9F8),
                                  onTap: () {
                                    setState(() {
                                      _trackingScanned = false;
                                      _truckController.text = "";
                                      _clientController.text = '';
                                      _originController.text = "";
                                      _destinationController.text = "";
                                      _codController.text = "";
                                      _trackingScanned = false;
                                      _dataIsScanned = false;
                                    });
                                  }),
                              ButtonWidget(
                                  widthPortion: 0.3,
                                  color: const Color(0xffDAA520),
                                  image: "assets/icons/returned.png",
                                  text: "Retour",
                                  textColor: Colors.black,
                                  onTap: () {
                                    paymentArrived("returned");
                                  }),
                              ButtonWidget(
                                  widthPortion: 0.3,
                                  color: const Color(0xff8FBC8F),
                                  image: "assets/icons/Done.png",
                                  text: "Encaissé",
                                  textColor: Colors.black,
                                  onTap: () {
                                    print("hello ");
                                    paymentArrived("paid");
                                  }),
                            ],
                          )
                        ],
                      ))
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
