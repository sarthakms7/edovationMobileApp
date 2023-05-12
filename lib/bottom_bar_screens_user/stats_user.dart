import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edovation/bottom_bar_screens_user/appointment_screens/appoint_details_screen.dart';
import 'package:edovation/controllers/bottom_bar_user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/custom_text.dart';

class StatsScreenUser extends StatefulWidget {
  const StatsScreenUser({Key? key}) : super(key: key);

  @override
  _StatsScreenUserState createState() => _StatsScreenUserState();
}

class _StatsScreenUserState extends State<StatsScreenUser> {
  BottomBarUserController controller = Get.find();
  bool checkBoxValue1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: 700,
        padding: EdgeInsets.symmetric(
            horizontal: deviceWidth(context) * 0.05,
            vertical: deviceWidth(context) * 0.05),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [buildNameWithProfileImage(), homePageListItem(0)],
          ),
        ),
      ),
    ));
  }

  Widget homePageListItem(int index) {
    //return
    //Obx(() {
    // if (sViewHomeworkController.isLoading.value) {
    //   return CircularLoader();
    // }
    // if (true) {
    //   return SizedBox(
    //     child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               const Icon(
    //                 Icons.notifications_off_rounded,
    //                 size: 120,
    //               ),
    //             ],
    //           ),
    //           customText(text: 'No homeworks given yet!', fontSize: 20),
    //           ElevatedButton(
    //             onPressed: () {
    //               Get.back();
    //             },
    //             style: ElevatedButton.styleFrom(
    //               primary: primaryColor,
    //               onPrimary: Colors.black,
    //             ),
    //             child: customText(text: 'Back', textColor: white),
    //           )
    //         ]),
    //   );
    // }
    return SizedBox(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Some Error Occured!')));
                return Container();
              }
              var totalKindnessPoints =
                  snapshot.data['number_of_sessions'] * 10 +
                      snapshot.data['number_of_books_donated'] * 10 +
                      snapshot.data['number_of_feedback_given'] * 5;
              return Column(
                children: [
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(
                        color: '02075D'.toColor(),
                        width: 4,
                        borderRadius: BorderRadius.circular(6)),
                    children: [
                      TableRow(decoration: BoxDecoration(), children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Number of Sessions',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: '02075D'.toColor()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data['number_of_sessions'].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: '02075D'.toColor()),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Number of Books Donated',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: '02075D'.toColor()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data['number_of_books_donated'].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: '02075D'.toColor()),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Number of Feedback Given',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: '02075D'.toColor()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data['number_of_feedback_given']
                                .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: '02075D'.toColor()),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Total Kindness Points',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: '02075D'.toColor()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '$totalKindnessPoints',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: '02075D'.toColor()),
                          ),
                        ),
                      ])
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 190,
                    width: 180,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/donation.jpg',
                          width: 150,
                          height: 150,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.celebration,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '$totalKindnessPoints',
                              style: TextStyle(
                                  color: '02075D'.toColor(),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.celebration,
                              color: Colors.redAccent,
                              textDirection: TextDirection.ltr,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
    //});
  }

  Widget buildNameWithProfileImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: customText(
              text: 'Stats',
              textColor: black,
              fontSize: 24,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  deviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  deviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
