import 'package:edovation/authentication/login_screen.dart';
import 'package:edovation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const Edovation());
}

class Edovation extends StatelessWidget {
  const Edovation({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Edovation',
      theme: ThemeData(
        primaryColor: Color(0xFF02075D),
      ),
      home: LoginScreen(),
    );
  }
}
