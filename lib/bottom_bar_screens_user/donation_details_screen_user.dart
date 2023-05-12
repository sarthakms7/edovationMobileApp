import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edovation/bottom_bar_screens_user/appointment_screens/maps_files/map_screen.dart';
import 'package:edovation/bottom_nav_bar_user/common_app_bar_user.dart';
import 'package:edovation/bottom_nav_bar_user/common_app_drawer_user.dart';
import 'package:edovation/controllers/map_screen_controller.dart';
import 'package:edovation/utils/colors.dart';
import 'package:edovation/utils/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookDonationDetailsUser extends StatefulWidget {
  DocumentSnapshot snap;
  BookDonationDetailsUser({Key? key, required this.snap}) : super(key: key);

  @override
  _BookDonationDetailsUserState createState() =>
      _BookDonationDetailsUserState();
}

class _BookDonationDetailsUserState extends State<BookDonationDetailsUser> {
  late MapScreenController controllerMap;
  bool checkBoxValue1 = false;
  String qrData = FirebaseAuth.instance.currentUser!.uid;

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    controllerMap = Get.put(MapScreenController());
    controllerMap.initializeMap(widget.snap['lat'], widget.snap['long']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: buildAppBarUser(_key, context, 0),
        drawer: buildDrawerUser(context, _key),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: "02075D".toColor().withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                          text: 'For Standard : ${widget.snap['standard']}',
                          maxLines: 3,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center),
                      const SizedBox(
                        height: 20,
                      ),
                      customText(
                        text:
                            'Number of Books : ${widget.snap['number_of_books']}',
                        maxLines: 3,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      customText(
                        text: 'Date : ${widget.snap['date']}',
                        maxLines: 3,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                              text: 'Location :',
                              maxLines: 3,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.start),
                          ElevatedButton(
                            onPressed: () => Get.to(() => MapScreen()),
                            child: Text('View on Map'),
                            style: ElevatedButton.styleFrom(
                                primary: "02075D".toColor()),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      customText(
                        text: 'QR Code',
                        maxLines: 3,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              QrImage(
                                data: widget.snap['qr_code'].toString(),
                                size: (math.min(
                                        MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height)) /
                                    1.2,
                                backgroundColor: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
