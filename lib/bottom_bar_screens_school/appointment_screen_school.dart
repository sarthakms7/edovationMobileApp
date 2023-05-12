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

class AppointmentDetailsSchool extends StatefulWidget {
  DocumentSnapshot snap;
  String schoolId;
  AppointmentDetailsSchool(
      {Key? key, required this.snap, required this.schoolId})
      : super(key: key);

  @override
  _AppointmentDetailsSchoolState createState() =>
      _AppointmentDetailsSchoolState();
}

class _AppointmentDetailsSchoolState extends State<AppointmentDetailsSchool> {
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
                          text: 'Topic : ${widget.snap['topic']}',
                          maxLines: 3,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center),
                      const SizedBox(
                        height: 20,
                      ),
                      customText(
                        text: 'Brief Info : ${widget.snap['brief_info']}',
                        maxLines: 3,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      customText(
                        text: 'Time : ${widget.snap['timeslot']}',
                        maxLines: 3,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      customText(
                        text: 'Day : ${widget.snap['day']}',
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
                                    .collection('appointments')
                                    .doc(widget.snap['doc_id'])
                                    .set({
                                  'status': 'accepted',
                                }, SetOptions(merge: true));

                                await FirebaseFirestore.instance
                                    .collection('schools')
                                    .doc(widget.schoolId)
                                    .collection('appointment_requests')
                                    .doc(widget.snap.id)
                                    .set({
                                  'status': 'accepted',
                                }, SetOptions(merge: true));
                                Get.to(() => BottomNavBarSchool(
                                    schoolId: widget.schoolId));
                                EasyLoading.showSuccess(
                                    'Appointment Confirmed!');
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
                                    .collection('appointments')
                                    .doc(widget.snap['doc_id'])
                                    .set({
                                  'status': 'rejected',
                                }, SetOptions(merge: true));
                                await FirebaseFirestore.instance
                                    .collection('schools')
                                    .doc(widget.schoolId)
                                    .collection('appointment_requests')
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
