import 'dart:developer';

import 'package:edovation/bottom_bar_screens_user/appointment_screens/maps_files/map_screen.dart';
import 'package:edovation/bottom_nav_bar_user/common_app_bar_user.dart';
import 'package:edovation/bottom_nav_bar_user/common_app_drawer_user.dart';
import 'package:edovation/utils/colors.dart';
import 'package:edovation/utils/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

enum _filter { all, submitted, notSubmitted }

class AppointmentDetailsUser extends StatefulWidget {
  const AppointmentDetailsUser({Key? key}) : super(key: key);

  @override
  _AppointmentDetailsUserState createState() => _AppointmentDetailsUserState();
}

class _AppointmentDetailsUserState extends State<AppointmentDetailsUser> {
  bool checkBoxValue1 = false;
  String? _selected = 'All';

  GlobalKey<ScaffoldState> _key = GlobalKey();

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
                          text: 'Venue : Jwala Devi SVM Inter College',
                          maxLines: 3,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center),
                      const SizedBox(
                        height: 20,
                      ),
                      customText(
                        text: 'Topic : Jwala Devi SVM Inter College',
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
