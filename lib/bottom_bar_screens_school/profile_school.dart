import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/custom_text.dart';

class SchoolProfile extends StatefulWidget {
  String schoolId;
  SchoolProfile({Key? key, required this.schoolId}) : super(key: key);

  @override
  _SchoolProfileState createState() => _SchoolProfileState();
}

class _SchoolProfileState extends State<SchoolProfile> {
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
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('schools')
                  .where('school_id', isEqualTo: widget.schoolId)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    customText(
                        text: 'Profile',
                        textColor: black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
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
                            child: Icon(
                              Icons.account_circle,
                              size: 60,
                              color: white,
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
                          hintText: snapshot.data!.docs[0]['name'].toString()),
                    ),
                    const SizedBox(height: 20),
                    customText(
                        text: 'School ID',
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
                          hintText:
                              snapshot.data!.docs[0]['school_id'].toString()),
                    ),
                    const SizedBox(height: 20),
                    customText(
                        text: 'Highest Education',
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
                          hintText:
                              snapshot.data!.docs[0]['highest_edu'].toString()),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }),
        ),
      ),
    ));
  }
}
