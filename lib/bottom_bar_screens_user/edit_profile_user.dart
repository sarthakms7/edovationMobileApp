import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edovation/bottom_nav_bar_user/bottom_nav_bar.dart';
import 'package:edovation/bottom_nav_bar_user/common_app_bar_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/custom_text.dart';

class EditProfileUser extends StatefulWidget {
  String name;
  String email;
  String education;
  EditProfileUser(
      {Key? key,
      required this.name,
      required this.email,
      required this.education})
      : super(key: key);

  @override
  _EditProfileUserState createState() => _EditProfileUserState();
}

class _EditProfileUserState extends State<EditProfileUser> {
  bool checkBoxValue1 = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var educationController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    educationController = TextEditingController(text: widget.education);
    super.initState();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _key,
        appBar: buildAppBarUser(_key, context, -2),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.05, vertical: deviceWidth * 0.05),
            child: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(
                        text: 'Profile',
                        textColor: black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: FirebaseAuth.instance.currentUser!.photoURL ==
                                null
                            ? const Icon(
                                Icons.account_circle,
                                size: 60,
                                color: white,
                              )
                            : Image.network(
                                FirebaseAuth.instance.currentUser!.photoURL ??
                                    '',
                                width: 60,
                                height: 60,
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                customText(
                    text: 'Name',
                    textColor: black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                const SizedBox(
                  height: 6,
                ),
                TextFormField(
                  enabled: true,
                  controller: nameController,

                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // controller: _Firstname,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter name';
                    } else {
                      return null;
                    }
                  },
                  decoration: myInputDecoration(hintText: widget.name),
                ),
                const SizedBox(height: 20),
                customText(
                    text: 'Email',
                    textColor: black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                const SizedBox(
                  height: 6,
                ),
                TextFormField(
                  enabled: true,
                  controller: emailController,

                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // controller: _Firstname,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter name';
                    } else {
                      return null;
                    }
                  },
                  decoration: myInputDecoration(hintText: widget.email),
                ),
                const SizedBox(height: 20),
                customText(
                    text: 'Education',
                    textColor: black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                const SizedBox(
                  height: 6,
                ),
                TextFormField(
                  enabled: true,
                  controller: educationController,

                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // controller: _Firstname,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter name';
                    } else {
                      return null;
                    }
                  },
                  decoration: myInputDecoration(hintText: widget.education),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (nameController.text.trim() != '' &&
                              emailController.text.trim() != '' &&
                              educationController.text.trim() != '') {
                            try {
                              EasyLoading.show(status: 'Updating...');
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({
                                'name': nameController.text.trim(),
                                'email': emailController.text.trim(),
                                'education': educationController.text.trim()
                              }, SetOptions(merge: true));
                              EasyLoading.showSuccess('Updated!');
                              EasyLoading.dismiss();
                              Get.to(() => BottomNavBar());
                            } catch (e) {
                              EasyLoading.dismiss();
                              Get.snackbar("Some Error Occured",
                                  "Some unknown error occured. Please try again.",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                              print(e);
                            }
                          } else {
                            Get.snackbar("Please Enter Details",
                                "Please Enter the details correctly.",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: '02075D'.toColor()),
                        child: Text('Save Details'))
                  ],
                )
              ],
            )),
          ),
        ));
  }
}
