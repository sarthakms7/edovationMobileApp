import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edovation/authentication/login_screen.dart';
import 'package:edovation/bottom_nav_bar_school/bottom_nav_bar_school.dart';
import 'package:edovation/splash_screen.dart';
import 'package:edovation/splash_screen_stateless.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bottom_nav_bar_user/bottom_nav_bar.dart';

class InitializerFirebaseUser extends StatefulWidget {
  const InitializerFirebaseUser({Key? key}) : super(key: key);

  @override
  State<InitializerFirebaseUser> createState() =>
      _InitializerFirebaseUserState();
}

class _InitializerFirebaseUserState extends State<InitializerFirebaseUser> {
  String? schoolId;
  bool check = false;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    // TODO: implement initState

    getDet();

    super.initState();
  }

  void getDet() async {
    final SharedPreferences prefs = await _prefs;

    schoolId = prefs.getString('school_id_edovation');

    if (schoolId != null && schoolId != '') {
      bool docRef = await FirebaseFirestore.instance
          .collection('schools')
          .doc(schoolId)
          .get()
          .then((value) => value.exists);
      if (!docRef) {
        await FirebaseAuth.instance.signOut();
        Get.to(() => LoginScreen());
      } else {
        Get.to(() => BottomNavBarSchool(schoolId: schoolId ?? ''));
      }
    }
    check = true;
  }

  // /// Method for checking if the installed version is latest or not
  // void checkVersionUpdate() async {
  //   final newVersion = NewVersionPlus(androidId: 'com.EMIRapp.EMIRapp');

  //   final status = await newVersion.getVersionStatus();
  //   log(status!.storeVersion.toString());
  //   log(status.localVersion.toString());
  //   if (status.canUpdate) {
  //     newVersion.showUpdateDialog(
  //         context: context,
  //         versionStatus: status,
  //         dialogText:
  //             'Current version: ${status.localVersion}\nNew version is available in the play store ${status.storeVersion}.\nUpdate Now!',
  //         dialogTitle: 'Update is available!',
  //         dismissButtonText: 'Exit App',
  //         dismissAction: () => SystemNavigator.pop(),
  //         allowDismissal: false,
  //         launchMode: LaunchMode.externalNonBrowserApplication);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BottomNavBar();
        } else {
          if (!check) {
            return SplashScreenStateless();
          } else {
            return LoginScreen();
          }
        }
      },
    );
  }
}
