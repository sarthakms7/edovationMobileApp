import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edovation/bottom_nav_bar_user/common_app_bar_user.dart';
import 'package:edovation/controllers/bottom_bar_user_controller.dart';
import 'package:edovation/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';
import '../utils/custom_text.dart';

class RequestDonationScreen extends StatefulWidget {
  RequestDonationScreen({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RequestDonationScreenState createState() => _RequestDonationScreenState();
}

bool isTapped = false;

class _RequestDonationScreenState extends State<RequestDonationScreen> {
  Widget buildNameWithProfileImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: customText(
              text: 'Request Donation',
              textColor: black,
              fontSize: 24,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  bool isResendTapped = false;
  int start = 30;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode _pinPutFocusNode = FocusNode();

  BottomBarUserController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey();

  var requestController = TextEditingController();
  var marController = TextEditingController();
  var roiController = TextEditingController();
  var phoneController = TextEditingController();
  var _value1 = 'Flat';
  var _value = '-';
  var _school = '0';
  var dropDown = true;
  var _day = '-1';
  var dropDownDay = true;
  var _timeslot = '-1';
  var dropDownTimeslot = true;
  var _standard = '-1';
  var dropDownStandard = true;
  DateTime _selectedDate = DateTime.now();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(30),
  );

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [];
    for (int i = 0; i < controller.schools.length; i++) {
      menuItems.add(DropdownMenuItem(
          value: i.toString(), child: Text(controller.schools[i]['name'])));
    }

    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsStandard {
    List<DropdownMenuItem<String>> menuItems = [];
    int indexi = controller.schoolIndex.value;
    _standard = controller.schools[indexi]['standards'][0];
    for (int i = 0; i < controller.schools[indexi]['standards'].length; i++) {
      menuItems.add(DropdownMenuItem(
          value: controller.schools[indexi]['standards'][i],
          child: Text(controller.schools[indexi]['standards'][i])));
    }

    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsDays {
    List<DropdownMenuItem<String>> menuItems = [];
    int indexi = controller.schoolIndex.value;
    _day =
        controller.schools[controller.schoolIndex.value]['days_available'][0];
    for (int i = 0;
        i < controller.schools[indexi]['days_available'].length;
        i++) {
      int nextDay = DateTime.monday;
      if (controller.schools[indexi]['days_available'][i] == 'Monday') {
        nextDay = DateTime.monday;
      } else if (controller.schools[indexi]['days_available'][i] == 'Tuesday') {
        nextDay = DateTime.tuesday;
      } else if (controller.schools[indexi]['days_available'][i] ==
          'Wednesday') {
        nextDay = DateTime.wednesday;
      } else if (controller.schools[indexi]['days_available'][i] ==
          'Thursday') {
        nextDay = DateTime.thursday;
      } else if (controller.schools[indexi]['days_available'][i] == 'Friday') {
        nextDay = DateTime.friday;
      } else if (controller.schools[indexi]['days_available'][i] ==
          'Saturday') {
        nextDay = DateTime.saturday;
      } else if (controller.schools[indexi]['days_available'][i] == 'Sunday') {
        nextDay = DateTime.sunday;
      }
      DateTime dateForSession = DateTime.now().next(nextDay);
      menuItems.add(DropdownMenuItem(
          value: DateFormat('dd-MM-yyyy').format(dateForSession),
          child: Text(DateFormat('dd-MM-yyyy').format(dateForSession))));
    }

    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsTimeslot {
    List<DropdownMenuItem<String>> menuItems = [];
    int indexi = controller.schoolIndex.value;
    _timeslot = controller.schools[indexi]['timeslot'][0];
    for (int i = 0; i < controller.schools[indexi]['timeslot'].length; i++) {
      menuItems.add(DropdownMenuItem(
          value: controller.schools[indexi]['timeslot'][i],
          child: Text(controller.schools[indexi]['timeslot'][i])));
    }

    return menuItems;
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  void initState() {
    controller.schoolIndex.value = 0;
    int nextDay = DateTime.monday;
    if (controller.schools[controller.schoolIndex.value]['days_available'][0] ==
        'Monday') {
      nextDay = DateTime.monday;
    } else if (controller.schools[controller.schoolIndex.value]
            ['days_available'][0] ==
        'Tuesday') {
      nextDay = DateTime.tuesday;
    } else if (controller.schools[controller.schoolIndex.value]
            ['days_available'][0] ==
        'Wednesday') {
      nextDay = DateTime.wednesday;
    } else if (controller.schools[controller.schoolIndex.value]
            ['days_available'][0] ==
        'Thursday') {
      nextDay = DateTime.thursday;
    } else if (controller.schools[controller.schoolIndex.value]
            ['days_available'][0] ==
        'Friday') {
      nextDay = DateTime.friday;
    } else if (controller.schools[controller.schoolIndex.value]
            ['days_available'][0] ==
        'Saturday') {
      nextDay = DateTime.saturday;
    } else if (controller.schools[controller.schoolIndex.value]
            ['days_available'][0] ==
        'Sunday') {
      nextDay = DateTime.sunday;
    }
    DateTime dateForSession = DateTime.now().next(nextDay);
    _day = DateFormat('dd-MM-yyyy').format(dateForSession);
    _standard =
        controller.schools[controller.schoolIndex.value]['standards'][0];
    _timeslot = controller.schools[controller.schoolIndex.value]['timeslot'][0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: buildAppBarUser(_scaffoldKey, context, -2),
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  buildNameWithProfileImage(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    width: screenWidth * 0.9,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 10.0, 10.0, 10.0),
                              child: const Text(
                                "School Name",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )),
                        Expanded(
                          flex: 5,
                          child: InputDecorator(
                            decoration:
                                myInputDecoration(hintText: 'School Name'),
                            isEmpty: _school == null,
                            child: DropdownButton(
                              isExpanded: true,
                              value: _school,
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _school = newValue!;
                                  controller.schoolIndex.value =
                                      int.parse(_school);
                                  int nextDay = DateTime.monday;
                                  if (controller.schools[controller.schoolIndex.value]['days_available'][0] ==
                                      'Monday') {
                                    nextDay = DateTime.monday;
                                  } else if (controller.schools[controller.schoolIndex.value]
                                          ['days_available'][0] ==
                                      'Tuesday') {
                                    nextDay = DateTime.tuesday;
                                  } else if (controller.schools[controller.schoolIndex.value]
                                          ['days_available'][0] ==
                                      'Wednesday') {
                                    nextDay = DateTime.wednesday;
                                  } else if (controller.schools[controller.schoolIndex.value]
                                          ['days_available'][0] ==
                                      'Thursday') {
                                    nextDay = DateTime.thursday;
                                  } else if (controller.schools[controller.schoolIndex.value]
                                          ['days_available'][0] ==
                                      'Friday') {
                                    nextDay = DateTime.friday;
                                  } else if (controller.schools[controller.schoolIndex.value]
                                          ['days_available'][0] ==
                                      'Saturday') {
                                    nextDay = DateTime.saturday;
                                  } else if (controller.schools[controller.schoolIndex.value]
                                          ['days_available'][0] ==
                                      'Sunday') {
                                    nextDay = DateTime.sunday;
                                  }
                                  DateTime dateForSession =
                                      DateTime.now().next(nextDay);
                                  _day = DateFormat('dd-MM-yyyy')
                                      .format(dateForSession);
                                  _timeslot = controller
                                          .schools[controller.schoolIndex.value]
                                      ['timeslot'][0];
                                  _standard = controller
                                          .schools[controller.schoolIndex.value]
                                      ['standards'][0];
                                  dropDown = false;
                                });
                              },
                              items: dropdownItems,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    width: screenWidth * 0.9,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 10.0, 10.0, 10.0),
                              child: const Text(
                                "Standard",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )),
                        Expanded(
                          flex: 5,
                          child: InputDecorator(
                            decoration: myInputDecoration(hintText: 'Standard'),
                            isEmpty: _standard == null,
                            child: DropdownButton(
                              isExpanded: true,
                              value: _standard,
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _standard = newValue!;

                                  dropDownStandard = false;
                                });
                              },
                              items: dropdownItemsStandard,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    width: screenWidth * 0.9,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 10.0, 10.0, 10.0),
                              child: const Text(
                                "Number of Books",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )),
                        Expanded(
                          flex: 5,
                          child: InputDecorator(
                            decoration:
                                myInputDecoration(hintText: 'Number of Books'),
                            isEmpty: requestController == null,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter The Number of Books';
                                }
                                if (!isNumeric(value)) {
                                  return 'Please Enter a Number';
                                }
                              },
                              maxLines: 1,
                              controller: requestController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    width: screenWidth * 0.9,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 10.0, 10.0, 10.0),
                              child: const Text(
                                "Select Date",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )),
                        Expanded(
                          flex: 5,
                          child: InputDecorator(
                              decoration: myInputDecoration(
                                  hintText: 'Brief Info About You'),
                              isEmpty: _day == null,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: '02075D'.toColor()),
                                onPressed: _presentDatePicker,
                                child: const Text(
                                  'Choose Date',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    width: screenWidth * 0.9,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 10.0, 10.0, 10.0),
                              child: const Text(
                                "Selected Date",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )),
                        Expanded(
                          flex: 5,
                          child: InputDecorator(
                              decoration: myInputDecoration(
                                  hintText: 'Brief Info About You'),
                              isEmpty: _day == null,
                              child: TextButton(
                                onPressed: () {},
                                child: _selectedDate == null
                                    ? const Text(
                                        'No date Chosen',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        _selectedDate
                                            .toString()
                                            .substring(0, 11),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                              )),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          // final isValid = _formKey.currentState!.validate();

                          if (_formKey.currentState!.validate()) {
                            try {
                              _formKey.currentState!.save();

                              String uid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              EasyLoading.show(status: 'Requesting...');

                              log('adding request');

                              String docId = await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('donation_requests')
                                  .add({
                                'venue': controller
                                        .schools[controller.schoolIndex.value]
                                    ['name'],
                                'lat': controller
                                        .schools[controller.schoolIndex.value]
                                    ['lat'],
                                'long': controller
                                        .schools[controller.schoolIndex.value]
                                    ['long'],
                                'number_of_books':
                                    double.parse(requestController.text.trim()),
                                'date':
                                    _selectedDate.toString().substring(0, 11),
                                'qr_code': uid,
                                'status': 'pending',
                                'standard': _standard,
                                'timestamp': DateTime.now()
                              }).then((value) => value.id);
                              await FirebaseFirestore.instance
                                  .collection('schools')
                                  .doc(controller
                                      .schools[controller.schoolIndex.value].id)
                                  .collection('donation_requests')
                                  .add({
                                'standard': _standard,
                                'date':
                                    _selectedDate.toString().substring(0, 11),
                                'number_of_books':
                                    double.parse(requestController.text.trim()),
                                'timestamp': DateTime.now(),
                                'user_id': uid,
                                'status': 'pending',
                                'doc_id': docId
                              });
                              log('request added');

                              roiController.clear();

                              requestController.clear();

                              EasyLoading.showSuccess(
                                  'Request Added Successfully!');
                              EasyLoading.dismiss();
                            } catch (e) {
                              //EasyLoading.showError('Something went wrong!');
                              EasyLoading.dismiss();
                              log(e.toString());
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: "02075D".toColor(),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 80)),
                        child: const Text(
                          'Send Request',
                          style: TextStyle(fontSize: 18),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),

                  //button
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
