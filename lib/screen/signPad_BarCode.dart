import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

// ignore: camel_case_types
class Signature_barCode extends StatefulWidget {
  const Signature_barCode({super.key});

  @override
  State<Signature_barCode> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<Signature_barCode> {
  Uint8List? image;

  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Pad"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white54,
              border: Border.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 1,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: SfSignaturePad(
              key: signatureGlobalKey,
              minimumStrokeWidth: 1,
              maximumStrokeWidth: 3,
              strokeColor: Colors.black,
            ),
          ),
          const SizedBox(height: 15),
          const SizedBox(height: 15),
          GestureDetector(
              onTap: () => _handleClearButtonPressed(),
              child: const Text(
                'Clear Signature',
                style: TextStyle(fontSize: 16, color: Colors.black),
              )),
          const SizedBox(height: 30),
          Center(
              child: Container(
            height: 200,
            child: SfBarcodeGenerator(
                textSpacing: 0,
                // symbology: QRCode(),
                showValue: false,
                value: 'www.facebook.com'),
          )),
        ]),
      ),
    );
  }
}
