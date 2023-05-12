import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/custom_text.dart';
import 'edit_profile_user.dart';

class SProfile extends StatefulWidget {
  const SProfile({Key? key}) : super(key: key);

  @override
  _SProfileState createState() => _SProfileState();
}

class _SProfileState extends State<SProfile> {
  bool checkBoxValue1 = false;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.05, vertical: deviceWidth * 0.05),
        child: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                }

                return Column(
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
                            child:
                                FirebaseAuth.instance.currentUser!.photoURL ==
                                        null
                                    ? const Icon(
                                        Icons.account_circle,
                                        size: 60,
                                        color: white,
                                      )
                                    : Image.network(
                                        FirebaseAuth.instance.currentUser!
                                                .photoURL ??
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
                      enabled: false,
                      readOnly: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // controller: _Firstname,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter name';
                        } else {
                          return null;
                        }
                      },
                      decoration: myInputDecoration(
                          hintText: snapshot.data!['name'].toString()),
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
                      enabled: false,
                      readOnly: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // controller: _Firstname,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter name';
                        } else {
                          return null;
                        }
                      },
                      decoration: myInputDecoration(
                          hintText: snapshot.data!['email'].toString()),
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
                      enabled: false,
                      readOnly: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // controller: _Firstname,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter name';
                        } else {
                          return null;
                        }
                      },
                      decoration: myInputDecoration(
                          hintText: snapshot.data!['education'].toString()),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () => Get.to(() => EditProfileUser(
                                  name: snapshot.data!['name'].toString(),
                                  email: snapshot.data!['email'].toString(),
                                  education:
                                      snapshot.data!['education'].toString(),
                                )),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: '02075D'.toColor()),
                            child: Text('Edit Details'))
                      ],
                    )
                  ],
                );
              }),
        ),
      ),
    ));
  }
}
