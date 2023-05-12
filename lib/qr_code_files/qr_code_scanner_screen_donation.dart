import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edovation/controllers/bottom_bar_school_controller.dart';
import 'package:edovation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../bottom_nav_bar_school/bottom_nav_bar_school.dart';

class QrCodeScannerDonation extends StatefulWidget {
  DocumentSnapshot? snap;
  String? qrData;
  String? schoolId;
  QrCodeScannerDonation({this.qrData, this.snap, this.schoolId});

  @override
  _QrCodeScannerDonationState createState() => _QrCodeScannerDonationState();
}

class _QrCodeScannerDonationState extends State<QrCodeScannerDonation> {
  String qrCode = '';
  BottomBarSchoolController controller = Get.find();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xFF313131),
        appBar: AppBar(
          title: Text("QR Code Scanner"),
          backgroundColor: '02075D'.toColor(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Scan Result',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '$qrCode',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () => scanQRCode(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: "02075D".toColor()),
                  child: Text('Scan QR Code'))
            ],
          ),
        ),
      );

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      log('here 0');

      if (!mounted) return;
      log('here');
      setState(() async {
        this.qrCode = qrCode.isEmpty
            ? ''
            : qrCode == '-1'
                ? ''
                : qrCode;

        if (qrCode.trim() == widget.qrData) {
          log('verified');
          try {
            EasyLoading.show(status: 'Confirming...');

            await FirebaseFirestore.instance
                .collection('users')
                .doc(widget.snap!['user_id'])
                .collection('donation_requests')
                .doc(widget.snap!['doc_id'])
                .set({
              'status': 'completed',
            }, SetOptions(merge: true));

            await FirebaseFirestore.instance
                .collection('schools')
                .doc(widget.schoolId)
                .collection('donation_requests')
                .doc(widget.snap!.id)
                .set({
              'status': 'completed',
            }, SetOptions(merge: true));
            Get.to(() => BottomNavBarSchool(schoolId: widget.schoolId ?? ''));
            EasyLoading.showSuccess('User Confirmed!');
            EasyLoading.dismiss();
          } catch (e) {
            log(e.toString());
            EasyLoading.showError(e.toString());
            EasyLoading.dismiss();
          }
          Navigator.of(context).pop();

          controller.qrVerified.value = true;
        } else {
          log('not verified');
          Navigator.of(context).pop();
          Get.showSnackbar(const GetSnackBar(
            title: 'Not Recognized',
            message: 'The qr code is not verifed!',
          ));
          Get.closeAllSnackbars();
        }
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
