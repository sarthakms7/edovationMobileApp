import 'package:edovation/bottom_bar_screens_school/donation_requests_school.dart';
import 'package:edovation/bottom_bar_screens_school/home_screen_school.dart';
import 'package:edovation/bottom_bar_screens_school/stats_school.dart';
import 'package:edovation/bottom_bar_screens_user/home_screen.dart';
import 'package:edovation/bottom_bar_screens_user/request_appointment.dart';
import 'package:edovation/bottom_bar_screens_user/profile_user.dart';
import 'package:edovation/bottom_bar_screens_user/stats_user.dart';
import 'package:edovation/bottom_nav_bar_school/common_app_bar_school.dart';
import 'package:edovation/bottom_nav_bar_school/common_app_drawer_school.dart';
import 'package:edovation/controllers/bottom_bar_school_controller.dart';
import 'package:edovation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../bottom_bar_screens_school/profile_school.dart';

class BottomNavBarSchool extends StatefulWidget {
  String schoolId;
  BottomNavBarSchool({required this.schoolId});
  @override
  _BottomNavBarSchoolState createState() => _BottomNavBarSchoolState();
}

class _BottomNavBarSchoolState extends State<BottomNavBarSchool> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = [
    Container(),
    Container(),
    Container(),
    Container()
  ];

  @override
  void initState() {
    _widgetOptions = [
      HomeScreenSchool(
        schoolId: widget.schoolId,
      ),
      BookDonationScreenSchool(schoolId: widget.schoolId),
      StatsScreenSchool(
        schoolId: widget.schoolId,
      ),
      SchoolProfile(
        schoolId: widget.schoolId,
      )
    ];
    Get.put(BottomBarSchoolController());
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      appBar: buildAppBarSchool(_key, context, 0),
      drawer: buildDrawerSchoolS(context, _key),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: "02075D".toColor(),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.white,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.book,
                  text: 'Book',
                ),
                GButton(
                  icon: LineIcons.horizontalSliders,
                  text: 'Stats',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
