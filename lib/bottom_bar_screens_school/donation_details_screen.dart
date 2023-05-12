import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edovation/bottom_bar_screens_user/appointment_screens/maps_files/map_screen.dart';
import 'package:edovation/bottom_nav_bar_school/bottom_nav_bar_school.dart';
import 'package:edovation/bottom_nav_bar_user/common_app_bar_user.dart';
import 'package:edovation/bottom_nav_bar_user/common_app_drawer_user.dart';
import 'package:edovation/controllers/bottom_bar_school_controller.dart';
import 'package:edovation/controllers/map_screen_controller.dart';
import 'package:edovation/qr_code_files/qr_code_scanner_screen.dart';
import 'package:edovation/utils/colors.dart';
import 'package:edovation/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookDonationDetailsSchool extends StatefulWidget {
  DocumentSnapshot snap;
  String schoolId;
  BookDonationDetailsSchool(
      {Key? key, required this.snap, required this.schoolId})
      : super(key: key);

  @override
  _BookDonationDetailsSchoolState createState() =>
      _BookDonationDetailsSchoolState();
}

class _BookDonationDetailsSchoolState extends State<BookDonationDetailsSchool> {
  bool checkBoxValue1 = false;
  String qrData = 'Sarthak';
  BottomBarSchoolController controller = Get.find();

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState

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
                          text: 'For Standard: ${widget.snap['standard']}',
                          maxLines: 3,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center),
                      const SizedBox(
                        height: 20,
                      ),
                      customText(
                        text:
                            'Number of Books : ${widget.snap['number_of_books'].toStringAsFixed(0)}',
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                EasyLoading.show(status: 'Confirming...');

                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.snap['user_id'])
                                    .collection('donation_requests')
                                    .doc(widget.snap['doc_id'])
                                    .set({
                                  'status': 'accepted',
                                }, SetOptions(merge: true));

                                await FirebaseFirestore.instance
                                    .collection('schools')
                                    .doc(widget.schoolId)
                                    .collection('donation_requests')
                                    .doc(widget.snap.id)
                                    .set({
                                  'status': 'accepted',
                                }, SetOptions(merge: true));
                                Get.to(() => BottomNavBarSchool(
                                    schoolId: widget.schoolId));
                                EasyLoading.showSuccess('Donation Confirmed!');
                                EasyLoading.dismiss();
                              } catch (e) {
                                log(e.toString());
                                EasyLoading.showError(e.toString());
                                EasyLoading.dismiss();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: "02075D".toColor()),
                            child: const Text('Accept'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                EasyLoading.show(status: 'Rejecting...');
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.snap['user_id'])
                                    .collection('donation_requests')
                                    .doc(widget.snap['doc_id'])
                                    .set({
                                  'status': 'rejected',
                                }, SetOptions(merge: true));
                                await FirebaseFirestore.instance
                                    .collection('schools')
                                    .doc(widget.schoolId)
                                    .collection('donation_requests')
                                    .doc(widget.snap.id)
                                    .set({
                                  'status': 'rejected',
                                }, SetOptions(merge: true));
                                Get.to(() => BottomNavBarSchool(
                                    schoolId: widget.schoolId));
                                EasyLoading.showSuccess('Rejected!');
                                EasyLoading.dismiss();
                              } catch (e) {
                                EasyLoading.showError(e.toString());
                                EasyLoading.dismiss();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: "02075D".toColor()),
                            child: const Text('Reject'),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
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
