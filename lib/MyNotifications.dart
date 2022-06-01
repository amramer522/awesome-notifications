// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// class MyNotifications {
//   static Future<void> init() async {
//     await Firebase.initializeApp();
//
//     FirebaseMessaging.onBackgroundMessage(
//       (RemoteMessage message) async {
//         //   print('Handling a background message ${message.messageId}');
//         AwesomeNotifications().createNotificationFromJsonData(message.data);
//       },
//     );
//     await FirebaseMessaging.instance.getToken().then((value) {
//       print(value);
//     });
//
//     AwesomeNotifications().initialize("resource://drawable/res_app_logo", [
//       NotificationChannel(
//           channelKey: "my_channel",
//           channelName: "My Channel",
//           channelDescription: "My Channel Description",
//           importance: NotificationImportance.High),
//       NotificationChannel(
//           channelKey: "time_select_time",
//           channelName: "My Channel",
//           channelDescription: "My Channel Description",
//           importance: NotificationImportance.High),
//       NotificationChannel(
//           channelKey: "my_scheduled_channel",
//           channelName: "My Scheduled Channel",
//           channelDescription: "My Scheduled Channel Description",
//           importance: NotificationImportance.High)
//     ]);
//   }
//
//   static void listen(context, page) {
//     AwesomeNotifications().isNotificationAllowed().then((value) {
//       if (value) {
//         print("Permission Allowed");
//         AwesomeNotifications().actionStream.listen((event) {
//           if (event.buttonKeyPressed == "1") {
//             print("hello from 1");
//           } else if (event.buttonKeyPressed == "2") {
//             print("hello from 2");
//           } else {
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => page,
//                 ),
//                 (route) => false);
//           }
//         });
//       } else {
//         // request permissions
//         print("No Permissions taken");
//       }
//     });
//   }
//
//   static void close() {
//     AwesomeNotifications().actionSink.close();
//   }
//
//   static void notifyNow() {
//     AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 20,
//         channelKey: "my_channel",
//         body: "hello Amr",
//         title: "hey from App",
//         backgroundColor: Colors.green,
//       ),
//       actionButtons: [
//         NotificationActionButton(key: "1", label: "Accept"),
//         NotificationActionButton(key: "2", label: "Cancel"),
//       ],
//       // schedule: NotificationInterval(interval: 60, repeats: true),
//     );
//   }
//
//   static notifyEvery({seconds = 60}) {
//     AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 30,
//         channelKey: "my_scheduled_channel",
//         title: "Interval Alarm",
//       ),
//       schedule: NotificationInterval(
//         interval: seconds,
//         repeats: true,
//       ),
//     );
//   }
//
//   static void notifyAtSpecificTime({hour, minute}) {
//     AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: 33,
//             channelKey: "time_select_time",
//             title: "from select time",
//             body: "اصحى ياعلاء البيت بيولع"),
//         schedule: NotificationCalendar(hour: hour, minute: minute));
//   }
//
//   static Future<void> cancelAllScheduledNotifications() async {
//     await AwesomeNotifications().cancelAllSchedules();
//   }
// }
