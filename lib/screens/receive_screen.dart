import 'package:caisseapp/utils/global_methods.dart';
import 'package:caisseapp/widget/button_widget.dart';
import 'package:caisseapp/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:convert' as convert;

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

  String _scanBarcode = 'Scanne';
  bool isNumeric(String? str) {
    if (str == null || str.isEmpty) {
      return false;
    }

    return double.tryParse(str) != null;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = GlobalMethodes.getScreenSize(context);

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
            InkWell(
              onTap: () async {
                await scanBarcodeNormal();
                var qr = convert.jsonDecode(_scanBarcode);
                setState(() {
                  _dataIsScanned = !_dataIsScanned;
                  _clientController.text = qr['client'];
                  _destinationController.text = qr['destination'];
                  _originController.text = qr['origin'];

                  _codController.text = qr['cod'];
                  _weightController.text = qr['wight'];
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
                            validator: () {},
                            onEditingComplete: () {},
                            isEnabled: false,
                            focusNode: _clientFocusNode,
                            textEditingController: _clientController,
                            leftIcon: "assets/icons/client.png",
                            label: "Client"),
                        TextFieldWidget(
                            validator: () {},
                            onEditingComplete: () {},
                            isEnabled: false,
                            focusNode: _originFocusNode,
                            textEditingController: _originController,
                            leftIcon: "assets/icons/origin.png",
                            label: "Origin"),
                        TextFieldWidget(
                            validator: () {},
                            onEditingComplete: () {},
                            isEnabled: false,
                            focusNode: _destinationFocusNode,
                            textEditingController: _destinationController,
                            leftIcon: "assets/icons/destination.png",
                            label: "Destination"),
                        TextFieldWidget(
                            validator: () {},
                            onEditingComplete: () {},
                            isEnabled: false,
                            focusNode: _codFocusNode,
                            textEditingController: _codController,
                            leftIcon: "assets/icons/Cash.png",
                            label: "COD"),
                        TextFieldWidget(
                            validator: () {},
                            onEditingComplete: () {},
                            isEnabled: true,
                            focusNode: _weightFocusNode,
                            textEditingController: _weightController,
                            leftIcon: "assets/icons/poids.png",
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
                                onTap: () {}),
                            ButtonWidget(
                                widthPortion: 0.45,
                                color: const Color(0xff8FBC8F),
                                image: "assets/icons/Done.png",
                                text: "Valider",
                                textColor: Colors.black,
                                onTap: () {}),
                          ],
                        )
                      ],
                    ))
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
