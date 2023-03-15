import 'dart:developer';

import 'package:edovation/bottom_bar_screens_user/appointment_screens/appoint_details_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/custom_text.dart';

enum _filter { all, submitted, notSubmitted }

class HomeScreenUser extends StatefulWidget {
  const HomeScreenUser({Key? key}) : super(key: key);

  @override
  _HomeScreenUserState createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  bool checkBoxValue1 = false;
  String? _selected = 'All';

  // SViewHomeworkController sViewHomeworkController =
  //     Get.put(SViewHomeworkController());

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     initializeData();
  //   });
  // }

  // initializeData() async {
  //   await sViewHomeworkController.fetchSViewHomeWork();
  //   log(sViewHomeworkController.homeworkList.length.toString());
  // }

  // @override
  // void dispose() {
  //   sViewHomeworkController.dispose();
  //   super.dispose();
  // }

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
      height: 5 * 140,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            // var words = sViewHomeworkController
            //     .homeworkList[index].readingContents[0].content
            //     .split(" ");
            // var titleForHeading = words.length < 4
            //     ? '${words[0]} ${words[1]} ${words[2]}...'
            //     : '${words[0]} ${words[1]} ${words[2]} ${words[3]}...';
            // var codeLength =
            //     sViewHomeworkController.homeworkList[index].code.length;
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  // Get.to(() => SHomeWorkRacordScreen(
                  //     readingContent: sViewHomeworkController
                  //         .homeworkList[index].readingContents[0],
                  //     assignment: sViewHomeworkController.homeworkList[index],
                  //     assignmentId:
                  //         sViewHomeworkController.homeworkList[index].id,
                  //     assignmentCode:
                  //         sViewHomeworkController.homeworkList[index].code,
                  //     status: sViewHomeworkController
                  //         .homeworkList[index].studentStatus
                  //         .toString()));
                  Get.to(() => AppointmentDetailsUser());
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                      color: "02075D".toColor().withOpacity(0.7)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    child: SizedBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width - 40) *
                                          0.56,
                                  child: customText(
                                      text: 'Workshop for Web Development',
                                      textColor: lightWhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900),
                                ),
                                Container(
                                  height: 25,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(70),
                                      color: Colors.green.withOpacity(0.15)),
                                  child: Center(
                                    child: customText(
                                        text: '14:00',
                                        textColor: Colors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            customText(
                                text: 'Location: Jwala Devi SVM Inter College',
                                textColor: white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                maxLines: 1),
                            const SizedBox(
                              height: 9,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 30,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(width: 1.5, color: white),
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 5, left: 5, right: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_rounded,
                                        size: 13,
                                        color: white,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Center(
                                        child: customText(
                                            text: '02-Feb-2023',
                                            textColor: lightWhite,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                // Row(
                                //   children: [
                                //     customText(
                                //         text: 'ID: ',
                                //         textColor: grey,
                                //         fontSize: 15,
                                //         fontWeight: FontWeight.w500),
                                //     customText(
                                //         text: '',
                                //         textColor: grey,
                                //         fontSize: 15,
                                //         fontWeight: FontWeight.bold),
                                //   ],
                                // ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            );
          }),
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
              text: 'Appointments',
              textColor: black,
              fontSize: 24,
              fontWeight: FontWeight.w600),
        ),
        // PopupMenuButton(
        //   icon: Icon(
        //     Icons.filter_alt,
        //     size: 27,
        //     color: lightBlack,
        //   ),
        //   itemBuilder: ((context) => const [
        //         PopupMenuItem(
        //           child: Text('All'),
        //           value: _filter.all,
        //         ),
        //         PopupMenuItem(
        //           child: Text('Submitted'),
        //           value: _filter.submitted,
        //         ),
        //         PopupMenuItem(
        //           child: Text('Not Submitted'),
        //           value: _filter.notSubmitted,
        //         ),
        //       ]),
        //   onSelected: ((value) {
        //     switch (value) {
        //       case _filter.all:
        //         setState(() {
        //           _selected = 'all';
        //           sViewHomeworkController.filterOption('all');
        //         });
        //         break;
        //       case _filter.submitted:
        //         setState(() {
        //           _selected = 'submitted';
        //           sViewHomeworkController.filterOption('submitted');
        //         });
        //         break;
        //       case _filter.notSubmitted:
        //         setState(() {
        //           _selected = 'notsubmitted';
        //           sViewHomeworkController.filterOption('notsubmitted');
        //         });
        //         break;
        //     }
        //   }),
        // ),
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
