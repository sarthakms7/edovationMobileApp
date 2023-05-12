import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edovation/authentication/authentication.dart';
import 'package:edovation/authentication/user_details_enter_screen.dart';
import 'package:edovation/bottom_nav_bar_user/bottom_nav_bar.dart';
import 'package:edovation/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/login_controller.dart';
import '../utils/custom_text.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  static const route = 'Signup_screen';

  SignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isVisiblePassword = false;

  LoginController controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();

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
                customText(text: 'Contact edovation via mail.', maxLines: 2),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
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
                      height: deviceHeight * 0.07,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.07,
                    ),
                    customText(
                      text: 'Hello Eduvator,',
                      textColor: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    customText(
                        text: 'Create your account',
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
                            return ("Please enter valid email");
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Please enter a valid Email';
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
                        controller: passwordController,
                        autofillHints: const [AutofillHints.password],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter valid password");
                          }
                          if (value.length < 6) {
                            return 'Please length should be greater than or equal to 6.';
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
                    SizedBox(
                      height: deviceHeight * 0.04,
                    ),
                    TextFormField(
                        controller: passwordController2,
                        autofillHints: const [AutofillHints.password],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter valid password");
                          }
                          if (value.length < 6) {
                            return 'Please length should be greater than or equal to 6.';
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
                          hintText: 'Confirm Password',
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
                      key: const ValueKey('SignupButton'),
                      onTap: () {
                        if (!controller.isLoading.value) {
                          if (passwordController.text ==
                              passwordController2.text) {
                            _signup();
                          } else {
                            Get.snackbar(
                                "PASSWORD DOES NOT MATCH", "Re-Enter PassWord",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
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
                                        text: 'Signup',
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
                                text: 'Already a user? Click here to login.',
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

  void _signup() async {
    try {
      controller.isLoading.value = true;

      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text.trim(),
          password: passwordController.text.trim(),
        );
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text.trim(),
          password: passwordController.text.trim(),
        );

        Get.to(() => UserDetailsEnterScreen());
      }
      controller.isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Weak Password", "The password provided is too weak.",
            backgroundColor: Colors.red, colorText: Colors.white);
        print(e.toString());
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Email Already Exists",
            "The account already exists for that email.",
            backgroundColor: Colors.red, colorText: Colors.white);
        print('The account already exists for that email.');
      }
    } catch (e) {
      Get.snackbar(
          "Some Error Occured", "Some unknown error occured. Please try again.",
          backgroundColor: Colors.red, colorText: Colors.white);
      print(e);
    }
  }
}
