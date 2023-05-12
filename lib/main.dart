import 'package:edovation/authentication/login_screen.dart';
import 'package:edovation/splash_screen.dart';
import 'package:edovation/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'bottom_nav_bar_user/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseMessaging fbm = FirebaseMessaging.instance;
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');

  // const InitializationSettings initializationSettings = InitializationSettings(
  //   android: initializationSettingsAndroid,
  // );

  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // await fbm.subscribeToTopic("newOrder");
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   log('Got a message whilst in the foreground!');
  //   log('Message data: ${message.data}');

  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;

  //   // If `onMessage` is triggered with a notification, construct our own
  //   // local notification to show to users using the created channel.
  //   if (notification != null && android != null) {
  //     flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(channel.id, channel.name,
  //               channelDescription: channel.description,
  //               icon: android.smallIcon,
  //               playSound: true
  //               // other properties...
  //               ),
  //         ));
  //   }
  // });
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const Edovation());
}

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   description:
//       'This channel is used for important notifications.', // description
//   playSound: true,
//   importance: Importance.max,
// );

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();

//   log("Handling a background message: ${message.messageId}");
// }

// sendNotification(String title, String token, String body) async {
//   final data = {
//     'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//     'id': '1',
//     'status': 'done',
//     'message': title,
//   };

//   try {
//     http.Response response =
//         await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
//             headers: <String, String>{
//               'Content-Type': 'application/json',
//               'Authorization':
//                   'key=AAAA0wAgqqk:APA91bEstgUmdqYnTaTX15ix1sPDr4CjCJhffvUsqzQSGgSlYbzJKGwa71hNuTeNO1ETEjn51-dF4NDupRG7G4j8NsBlfxI7WhwMCkQTBsiXPxUjVttL1UYdgWBgdbqkFuFnQ8n8RXoK'
//             },
//             body: jsonEncode(<String, dynamic>{
//               'notification': <String, dynamic>{'title': title, 'body': body},
//               'priority': 'high',
//               'data': data,
//               'to': token
//             }));

//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       print("Yeh notification is sent");
//     } else {
//       print("Error");
//     }
//   } catch (e) {
//     log(e.toString());
//   }
// }

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.white
    ..indicatorColor = '02075D'.toColor()
    ..textColor = '02075D'.toColor()
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class Edovation extends StatelessWidget {
  const Edovation({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        builder: EasyLoading.init(),
        title: 'Edovation',
        theme: ThemeData(
          primaryColor: Color(0xFF02075D),
        ),
        home: SplashScreen());
  }
}
