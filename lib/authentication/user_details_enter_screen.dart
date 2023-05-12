import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edovation/authentication/authentication.dart';
import 'package:edovation/authentication/sign_up_screen.dart';
import 'package:edovation/bottom_nav_bar_user/bottom_nav_bar.dart';
import 'package:edovation/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/login_controller.dart';
import '../utils/custom_text.dart';

class UserDetailsEnterScreen extends StatefulWidget {
  static const route = 'user_details_enter_screen';

  UserDetailsEnterScreen({
    Key? key,
  }) : super(key: key);

  @override
  _UserDetailsEnterScreenState createState() => _UserDetailsEnterScreenState();
}

class _UserDetailsEnterScreenState extends State<UserDetailsEnterScreen> {
  bool isVisiblePassword = false;

  LoginController controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final educationController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    educationController.dispose();
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
          appBar: AppBar(
            title: Text('Enter Your Details'),
            backgroundColor: "02075D".toColor(),
          ),
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
                      height: deviceHeight * 0.07,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.07,
                    ),
                    TextFormField(
                        key: const ValueKey('username'),
                        controller: usernameController,
                        autofillHints: [AutofillHints.givenName],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter valid email");
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
                          hintText: 'Email Address',
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
                        controller: nameController,
                        autofillHints: const [AutofillHints.password],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter valid name");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          nameController.text = value!;
                        },
                        autocorrect: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0)),
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          hintText: 'Name',
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
                        controller: educationController,
                        autofillHints: const [AutofillHints.password],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter valid education ststus");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          educationController.text = value!;
                        },
                        autocorrect: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0)),
                          prefixIcon: const Icon(Icons.book_online),
                          hintText: 'Education',
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
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    InkWell(
                      key: const ValueKey('signupButtonDetails'),
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
                        child: controller.isLoading.value
                            ? CircularProgressIndicator.adaptive()
                            : Padding(
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
                                    customText(
                                        text: 'Continue',
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
        final uid = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': nameController.text.trim(),
          'email': usernameController.text.trim(),
          'education': educationController.text.trim(),
          'uid': uid
        }, SetOptions(merge: true));
        Get.to(() => BottomNavBar());
      }
      controller.isLoading.value = false;
    } on FirebaseAuthException catch (e) {
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
      Get.snackbar(
          "Some Error Occured", "Some unknown error occured. Please try again.",
          backgroundColor: Colors.red, colorText: Colors.white);
      print(e);
    }
  }
}
