import 'package:caisseapp/utils/constants.dart';
import 'package:caisseapp/utils/global_methods.dart';
import 'package:caisseapp/widget/button_widget.dart';
import 'package:caisseapp/widget/loading_manager.dart';
import 'package:caisseapp/widget/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:convert' as convert;

import 'package:google_fonts/google_fonts.dart';

class ReceiveScreen extends StatefulWidget {
  const ReceiveScreen({super.key});

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _clientFocusNode = FocusNode();
  final TextEditingController _clientController = TextEditingController();
  final FocusNode _originFocusNode = FocusNode();
  final TextEditingController _originController = TextEditingController();
  final FocusNode _destinationFocusNode = FocusNode();
  final TextEditingController _destinationController = TextEditingController();
  final FocusNode _codFocusNode = FocusNode();
  final TextEditingController _codController = TextEditingController();
  final FocusNode _weightFocusNode = FocusNode();
  final TextEditingController _weightController = TextEditingController();
  bool _dataIsScanned = false;
  @override
  void dispose() {
    _clientFocusNode.dispose();
    _originFocusNode.dispose();
    _destinationFocusNode.dispose();
    _codFocusNode.dispose();
    _weightFocusNode.dispose();
    _clientController.dispose();
    _originController.dispose();
    _destinationController.dispose();
    _codController.dispose();
    _weightController.dispose();
    _dataIsScanned = false;

    super.dispose();
  }

  String _scanQR = '';

  Future<void> scanQr() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanQR = barcodeScanRes;
    });
  }

  Future<void> _valider() async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (!_dataIsScanned) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      var qr = convert.jsonDecode(_scanQR);

      await FirebaseFirestore.instance
          .collection("shippement")
          .doc(qr["tracking"])
          .set({
        "origin": qr["origin"],
        "status": "Received",
        "destination": qr["destination"],
        "client": qr["client"],
        "cod": qr["cod"],
        "weight": qr["weight"],
        "userId": authInstance.currentUser!.uid,
        "createdAt": DateTime.now(),
        "phone": qr["phone"],
        "tracking": qr["tracking"],
      });
      setState(() {
        _dataIsScanned = false;
        _isLoading = false;
        _clientController.text = "";
        _originController.text = "";
        _destinationController.text = "";
        _codController.text = "";
        _weightController.text = "";
      });
    } catch (e) {
      if (mounted) {
        GlobalMethodes.ErrorDialog(
            subtitle: "échec de connexion réessayer plus tard",
            context: context);
      }
    } finally {
      setState(() {
        _dataIsScanned = false;
        _isLoading = false;
        _clientController.text = "";
        _originController.text = "";
        _destinationController.text = "";
        _codController.text = "";
        _weightController.text = "";
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
                    _dataIsScanned = false;
                  });
                  await scanQr();
                  var qr = convert.jsonDecode(_scanQR);

                  setState(() {
                    _dataIsScanned = true;
                    _clientController.text = qr['client'];
                    _destinationController.text = qr['destination'];
                    _originController.text = qr['origin'];

                    _codController.text = qr['cod'];
                    _weightController.text = qr['weight'];
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: _dataIsScanned ? 186 : 208,
                  height: _dataIsScanned ? 186 : 208,
                  child: Image.asset(
                    "assets/Qr.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
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
                          TextFieldWidget(
                              onEditingComplete: () {},
                              isEnabled: true,
                              focusNode: _weightFocusNode,
                              textEditingController: _weightController,
                              leftIcon: "assets/icons/poids.png",
                              rightIcon: Text(
                                "KG",
                                style: GoogleFonts.playfairDisplay(fontSize: 8),
                              ),
                              label: "Poids"),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ButtonWidget(
                                  widthPortion: 0.33,
                                  color: const Color(0xffA90000),
                                  image: "assets/icons/Cancel.png",
                                  text: "",
                                  textColor: const Color(0xffF7F9F8),
                                  onTap: () {
                                    setState(() {
                                      _dataIsScanned = false;
                                      _clientController.text = "";
                                      _originController.text = "";
                                      _destinationController.text = "";
                                      _codController.text = "";
                                      _weightController.text = "";
                                    });
                                  }),
                              ButtonWidget(
                                  widthPortion: 0.45,
                                  color: const Color(0xff8FBC8F),
                                  image: "assets/icons/Done.png",
                                  text: "Valider",
                                  textColor: Colors.black,
                                  onTap: () {
                                    _valider();
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
