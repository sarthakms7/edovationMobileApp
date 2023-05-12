import 'dart:developer';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:edovation/bottom_bar_screens_user/appointment_screens/appoint_details_screen.dart';
import 'package:edovation/controllers/bottom_bar_user_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/custom_text.dart';

class DonationScreenUser extends StatefulWidget {
  const DonationScreenUser({Key? key}) : super(key: key);

  @override
  _DonationScreenUserState createState() => _DonationScreenUserState();
}

class _DonationScreenUserState extends State<DonationScreenUser>
    with SingleTickerProviderStateMixin {
  BottomBarUserController controller = Get.find();
  bool checkBoxValue1 = false;
  late TabController controllerTab = TabController(length: 2, vsync: this);

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
        () => controller.donations.isEmpty
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
                      customText(text: 'No Data!', fontSize: 20),
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
                itemCount: controller.donations.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => AppointmentDetailsUser(
                              snap: controller.donations[index],
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
                                            text:
                                                '${controller.donations[index]['number_of_books'].toStringAsFixed(0)} Books',
                                            textColor: lightWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  customText(
                                      text: controller.donations[index]
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
                                                      .donations[index]['date'],
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
              text: 'Book Donations',
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
        () => controller.donationsCompleted.isEmpty
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
                      customText(text: 'No Data!', fontSize: 20),
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
                itemCount: controller.donationsCompleted.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => AppointmentDetailsUser(
                              snap: controller.donationsCompleted[index],
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
                                            text:
                                                '${controller.donationsCompleted[index]['number_of_books']} Books',
                                            textColor: lightWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  customText(
                                      text: controller.donationsCompleted[index]
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
                                                          .donationsCompleted[
                                                      index]['date'],
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
