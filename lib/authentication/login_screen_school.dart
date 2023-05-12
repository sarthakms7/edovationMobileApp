import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edovation/authentication/authentication.dart';
import 'package:edovation/authentication/login_screen.dart';
import 'package:edovation/authentication/sign_up_screen.dart';
import 'package:edovation/bottom_nav_bar_school/bottom_nav_bar_school.dart';
import 'package:edovation/bottom_nav_bar_user/bottom_nav_bar.dart';
import 'package:edovation/controllers/login_controller_school.dart';
import 'package:edovation/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/login_controller.dart';
import '../utils/custom_text.dart';

class LoginScreenSchool extends StatefulWidget {
  static const route = 'login_screen';

  LoginScreenSchool({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenSchoolState createState() => _LoginScreenSchoolState();
}

class _LoginScreenSchoolState extends State<LoginScreenSchool> {
  bool isVisiblePassword = false;

  LoginControllerSchool controller = Get.put(LoginControllerSchool());
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotPasswordController = TextEditingController();

  Future<void> forgotPasswordDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.close_outlined))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: 300,
                    child: Text(
                      'Please contact Edovation administration.',
                      textAlign: TextAlign.center,
                    )),
                ElevatedButton(
                  onPressed: () async {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: "02075D".toColor(),
                    onPrimary: Colors.white,
                    minimumSize: const Size.fromHeight(36),
                  ),
                  child: customText(text: 'OK', textColor: white),
                )
              ]),
            ));
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Obx(
        () => Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.06),
            child: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.035,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/icons/playstore.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    customText(
                      text: 'Hello School,',
                      textColor: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    customText(
                        text: 'Login into your account',
                        textColor: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    SizedBox(
                      height: deviceHeight * 0.05,
                    ),
                    TextFormField(
                        key: const ValueKey('username'),
                        controller: usernameController,
                        autofillHints: [AutofillHints.givenName],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter valid id");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          usernameController.text = value!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0)),
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: 'School ID',
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 15),
                          filled: true,
                          fillColor: Color.fromARGB(255, 220, 227, 248),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 10, 10, 20),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                            borderSide:
                                BorderSide(color: Color(0xffF4F7FF), width: 2),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        )),
                    SizedBox(
                      height: deviceHeight * 0.04,
                    ),
                    TextFormField(
                        controller: passwordController,
                        autofillHints: const [AutofillHints.password],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter valid password");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                        autocorrect: true,
                        obscureText: !isVisiblePassword ? true : false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0)),
                          suffixIcon: !isVisiblePassword
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      isVisiblePassword = true;
                                    });
                                  },
                                  child:
                                      const Icon(Icons.visibility_off_outlined))
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      isVisiblePassword = false;
                                    });
                                  },
                                  child: const Icon(Icons.visibility_outlined)),
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          hintText: 'Password',
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 15),
                          filled: true,
                          fillColor: Color.fromARGB(255, 220, 227, 248),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 10, 10, 20),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                            borderSide:
                                BorderSide(color: Color(0xffF4F7FF), width: 2),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => forgotPasswordDialog(context),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: customText(
                              text: 'Forgot Password?',
                              textColor: black,
                              fontSize: 12,
                              fontWeight: FontWeight.w900)),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    InkWell(
                      key: const ValueKey('loginButton'),
                      onTap: () {
                        if (!controller.isLoading.value) {
                          _login();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: "02075D".toColor(),
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(10),
                                left: Radius.circular(10))),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: deviceWidth * 0.25,
                                vertical: deviceHeight * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.login,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                controller.isLoading.value
                                    ? CircularProgressIndicator.adaptive()
                                    : customText(
                                        text: 'Login',
                                        textColor: white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<PackageInfo>(
                        future: PackageInfo.fromPlatform(),
                        builder: (context, snapshot) => Center(
                          child: Text(
                            'Version- ${snapshot.data?.version}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor.withOpacity(0.7)),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () => Get.to(() => LoginScreen()),
                            child: customText(
                                text: 'Login as a User',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.blue))
                      ],
                    )
                  ],
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }

  Widget getBackButton() {
    return Row(
      children: [
        const Icon(
          Icons.arrow_back_ios,
          size: 12,
        ),
        customText(
            text: 'Back',
            textColor: black,
            fontSize: 12,
            fontWeight: FontWeight.w900),
      ],
    );
  }

  void _login() async {
    try {
      controller.isLoading.value = true;

      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        log('here 0');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        log('here 1');
        QuerySnapshot<Map<String, dynamic>> login = await FirebaseFirestore
            .instance
            .collection('schools')
            .where('school_id',
                isEqualTo: usernameController.text.trim().toUpperCase())
            .get();
        log('here 2');
        if (login.docs.isEmpty) {
          log('here 3');
          Get.showSnackbar(const GetSnackBar(
            title: 'Not Registered!',
            message: 'School is not registered.',
          ));
          controller.isLoading.value = false;
        } else {
          log('here 4');
          QuerySnapshot<Map<String, dynamic>> loginPass =
              await FirebaseFirestore.instance
                  .collection('schools')
                  .where('school_id',
                      isEqualTo: usernameController.text.trim().toUpperCase())
                  .where('password', isEqualTo: passwordController.text.trim())
                  .get();
          log('here 5');
          if (loginPass.docs.isEmpty) {
            log('here 6');
            Get.showSnackbar(GetSnackBar(
              title: 'Wrong Password!',
              message:
                  'Password is not correct for school id ${login.docs[0]['school_id']}.',
            ));
            controller.isLoading.value = false;
          } else {
            log('here 7');
            prefs.setString('school_id_edovation', login.docs[0]['school_id']);
            log('here 8');
            Get.to(() => BottomNavBarSchool(
                  schoolId: usernameController.text.trim().toUpperCase(),
                ));
            controller.isLoading.value = false;
          }
        }
      }
      controller.isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      controller.isLoading.value = false;
      if (e.code == 'user-not-found') {
        Get.snackbar("User Not Found", "No user found for that email.",
            backgroundColor: Colors.red, colorText: Colors.white);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Wrong Password", "Wrong password provided for that user.",
            backgroundColor: Colors.red, colorText: Colors.white);
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      Get.snackbar("Some Error Occured", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      print(e);
    }
  }
}
