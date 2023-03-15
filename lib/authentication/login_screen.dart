import 'package:edovation/bottom_nav_bar_user/bottom_nav_bar.dart';
import 'package:edovation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/login_controller.dart';
import '../utils/custom_text.dart';

class LoginScreen extends StatefulWidget {
  static const route = 'login_screen';

  LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisiblePassword = false;

  LoginController controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
                customText(
                    text: 'Contact your English teacher or Praccel official.',
                    maxLines: 2),
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
                      height: deviceHeight * 0.05,
                      child: Icon(Icons.login_sharp),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.07,
                    ),
                    customText(
                      text: 'Hello Eduvator,',
                      textColor: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
                            return ("Please enter valid username");
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
                          // _login();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => BottomNavBar()));
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
                    InkWell(
                      onTap: () => null,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: 'By signing up,you agree to our',
                          style: TextStyle(
                              color: Colors.grey, fontFamily: 'Roboto-Medium'),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Terms & Conditions ',
                                style: TextStyle(
                                    fontFamily: 'Roboto-Medium',
                                    color: Colors.blue)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () => null,
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text: '',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Roboto-Medium'),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'and ',
                                  style: TextStyle(
                                      fontFamily: 'Roboto-Medium',
                                      color: Colors.grey)),
                              TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                      fontFamily: 'Roboto-Medium',
                                      color: Colors.blue)),
                            ],
                          ),
                        ),
                      ),
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
      }
      controller.isLoading.value = false;
    } catch (e) {
      controller.isLoading.value = false;
      print(e);
    }
  }
}
