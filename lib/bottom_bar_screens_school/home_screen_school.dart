import 'dart:developer';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:edovation/bottom_bar_screens_school/appointment_screen_school.dart';
import 'package:edovation/bottom_bar_screens_school/appointment_screen_school_accepted.dart';
import 'package:edovation/bottom_bar_screens_user/appointment_screens/appoint_details_screen.dart';
import 'package:edovation/controllers/bottom_bar_user_controller.dart';
import 'package:edovation/firebase/firebase.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bottom_bar_school_controller.dart';
import '../utils/colors.dart';
import '../utils/custom_text.dart';

class HomeScreenSchool extends StatefulWidget {
  String schoolId;
  HomeScreenSchool({Key? key, required this.schoolId}) : super(key: key);

  @override
  _HomeScreenSchoolState createState() => _HomeScreenSchoolState();
}

class _HomeScreenSchoolState extends State<HomeScreenSchool>
    with SingleTickerProviderStateMixin {
  BottomBarSchoolController controller = Get.find();
  bool checkBoxValue1 = false;
  late TabController controllerTab = TabController(length: 3, vsync: this);

  @override
  void initState() {
    // TODO: implement initState
    controller.appointments
        .bindStream(FirestoreDB().getAllAppointmentRequests(widget.schoolId));
    controller.appointmentsAccepted.bindStream(
        FirestoreDB().getAllAppointmentRequestsAccepted(widget.schoolId));
    controller.appointmentsCompleted.bindStream(
        FirestoreDB().getAllAppointmentRequestsCompleted(widget.schoolId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: 700,
        padding: EdgeInsets.symmetric(
            horizontal: deviceWidth(context) * 0.05,
            vertical: deviceWidth(context) * 0.05),
        child: Container(
          child: Column(
            children: [
              ButtonsTabBar(
                controller: controllerTab,
                backgroundColor: '02075D'.toColor(),
                unselectedBackgroundColor: Colors.grey[200],
                unselectedLabelStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                radius: 12,
                contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                labelStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(
                    //icon: Icon(Icons.directions_car),
                    text: "Pending",
                  ),
                  Tab(
                    // icon: Icon(Icons.directions_transit),
                    text: "Accepted",
                  ),
                  Tab(
                    // icon: Icon(Icons.directions_transit),
                    text: "Completed",
                  ),
                ],
              ),
              Expanded(
                  child: TabBarView(controller: controllerTab, children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildNameWithProfileImage(),
                      homePageListItem(0)
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildNameWithProfileImageAccepted(),
                      homePageListItemAccepted(0)
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildNameWithProfileImageCompleted(),
                      homePageListItemCompleted(0)
                    ],
                  ),
                ),
              ])),
            ],
          ),
        ),
      ),
    ));
  }

  Widget homePageListItem(int index) {
    return SizedBox(
      height: 5 * 140,
      child: Obx(
        () => controller.appointments.isEmpty
            ? SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.notifications_off_rounded,
                            size: 120,
                          ),
                        ],
                      ),
                      customText(
                          text: 'No Data!',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          onPrimary: Colors.black,
                        ),
                        child: customText(text: 'Back', textColor: white),
                      )
                    ]),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.appointments.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => AppointmentDetailsSchool(
                              snap: controller.appointments[index],
                              schoolId: widget.schoolId,
                            ));
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    40) *
                                                0.56,
                                        child: customText(
                                            text: controller.appointments[index]
                                                ['topic'],
                                            textColor: lightWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Container(
                                        height: 25,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(70),
                                            color:
                                                Colors.green.withOpacity(0.15)),
                                        child: Center(
                                          child: customText(
                                              text:
                                                  controller.appointments[index]
                                                      ['timeslot'],
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
                                      text: controller.appointments[index]
                                          ['standard'],
                                      textColor: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      maxLines: 1),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.5, color: white),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            left: 5,
                                            right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  text: controller
                                                          .appointments[index]
                                                      ['day'],
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
      ),
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
              text: 'Appointment Requests',
              textColor: black,
              fontSize: 24,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget homePageListItemAccepted(int index) {
    return SizedBox(
      height: 5 * 140,
      child: Obx(
        () => controller.appointmentsAccepted.isEmpty
            ? SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.notifications_off_rounded,
                            size: 120,
                          ),
                        ],
                      ),
                      customText(
                          text: 'No Data!',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          onPrimary: Colors.black,
                        ),
                        child: customText(text: 'Back', textColor: white),
                      )
                    ]),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.appointmentsAccepted.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => AppointmentDetailsSchoolAccepted(
                              snap: controller.appointmentsAccepted[index],
                              schoolId: widget.schoolId,
                            ));
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    40) *
                                                0.56,
                                        child: customText(
                                            text: controller
                                                    .appointmentsAccepted[index]
                                                ['topic'],
                                            textColor: lightWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Container(
                                        height: 25,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(70),
                                            color:
                                                Colors.green.withOpacity(0.15)),
                                        child: Center(
                                          child: customText(
                                              text: controller
                                                      .appointmentsAccepted[
                                                  index]['timeslot'],
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
                                      text:
                                          controller.appointmentsAccepted[index]
                                              ['standard'],
                                      textColor: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      maxLines: 1),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.5, color: white),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            left: 5,
                                            right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  text: controller
                                                          .appointmentsAccepted[
                                                      index]['day'],
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
      ),
    );
    //});
  }

  Widget buildNameWithProfileImageAccepted() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: customText(
              text: 'Accepted Requested',
              textColor: black,
              fontSize: 24,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget homePageListItemCompleted(int index) {
    return SizedBox(
      height: 5 * 140,
      child: Obx(
        () => controller.appointmentsCompleted.isEmpty
            ? SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.notifications_off_rounded,
                            size: 120,
                          ),
                        ],
                      ),
                      customText(
                          text: 'No Data!',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          onPrimary: Colors.black,
                        ),
                        child: customText(text: 'Back', textColor: white),
                      )
                    ]),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.appointmentsCompleted.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    40) *
                                                0.56,
                                        child: customText(
                                            text: controller
                                                    .appointmentsCompleted[
                                                index]['topic'],
                                            textColor: lightWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Container(
                                        height: 25,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(70),
                                            color:
                                                Colors.green.withOpacity(0.15)),
                                        child: Center(
                                          child: customText(
                                              text: controller
                                                      .appointmentsCompleted[
                                                  index]['timeslot'],
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
                                      text: controller
                                              .appointmentsCompleted[index]
                                          ['standard'],
                                      textColor: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      maxLines: 1),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.5, color: white),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            left: 5,
                                            right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  text: controller
                                                          .appointmentsCompleted[
                                                      index]['day'],
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
      ),
    );
    //});
  }

  Widget buildNameWithProfileImageCompleted() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: customText(
              text: 'Completed Requests',
              textColor: black,
              fontSize: 24,
              fontWeight: FontWeight.w600),
        ),
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
