import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo/ui/pages/notification_screen.dart';
import '../models/task.dart';

class NotifyHelper {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  String selectedNotificationPayload = '';

  final BehaviorSubject<String> selectNotificationSubject =
  BehaviorSubject<String>();

  initializeNotification() async {
    tz.initializeTimeZones();
    _configureSelectNotificationSubject();
    // tz.setLocalLocation(tz.getLocation(timeZoneName));
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('appicon');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  requestIOSPermissions() {
    flutterLocalNotificationsPlugin.
    resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>
      ()?.requestPermissions(
      sound: true,
      alert: true,
      badge: true,
    );
  }


  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Get.to(NotificationScreen(paylod: payload!));
  }

  displayNotification({required String title, required String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails('your channel id', 'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      showWhen: false,);
    IOSFlutterLocalNotificationsPlugin iosNotificationDetails =
    IOSFlutterLocalNotificationsPlugin();
    NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails,
        payload: 'Default sound');
  }

  cancelNotification(Task task) async {
    await flutterLocalNotificationsPlugin.cancel(task.id!);
  }
  cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  scheduledNotification(int hour,int minutes,Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!,
        task.title,
        task.note,
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      _nextInstanceOfTenAM(
          hour, minutes, task.remind!, task.repeat!, task.date!),

         NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '${task.title}|${task.note}|${task.startTime}|',
    );
  }
  tz.TZDateTime _nextInstanceOfTenAM( int hour, int minutes, int remind, String repeat, String date) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    var formattedDate = DateFormat.yMd().parse(date);
    final tz.TZDateTime fd = tz.TZDateTime.from(formattedDate, tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, fd.year, fd.month, fd.day, hour, minutes);

    scheduledDate = afterRemind(remind, scheduledDate);

    if (scheduledDate.isBefore(now)) {
      if (repeat == 'Daily') {
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
            (formattedDate.day) + 1, hour, minutes);
      }
      if (repeat == 'Weekly') {
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
            (formattedDate.day) + 7, hour, minutes);
      }
      if (repeat == 'Monthly') {
        scheduledDate = tz.TZDateTime(tz.local, now.year,
            (formattedDate.month) + 1, formattedDate.day, hour, minutes);

      }
      scheduledDate = afterRemind(remind, scheduledDate);
    }
    return scheduledDate;
  }
  tz.TZDateTime afterRemind(int remind, tz.TZDateTime scheduledDate) {
    if (remind == 5) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 5));
    }

    if (remind == 10) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 10));
    }

    if (remind == 15) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 15));
    }

    if (remind == 20) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 20));
    }
    return scheduledDate;
  }

  void onDidReceiveLocalNotification(int id, String? title, String? body,
      String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page

    Get.dialog(Text(body!));
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      debugPrint('My payload is ' + payload);
      await Get.to(() => NotificationScreen(paylod: payload));
    });
  }
}


// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
//
//
//
// class NotifyHelper {
//   FlutterLocalNotificationsPlugin
//   flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin(); //
//
//   initializeNotification() async {
//     //tz.initializeTimeZones();
//     // this is for latest iOS settings
//     final DarwinInitializationSettings initializationSettingsIOS =
//     DarwinInitializationSettings(
//         requestSoundPermission: false,
//         requestBadgePermission: false,
//         requestAlertPermission: false,
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification
//     );
//
//     final AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings("appicon");
//
//       final InitializationSettings initializationSettings =
//       InitializationSettings(
//       iOS: initializationSettingsIOS,
//       android:initializationSettingsAndroid,
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//         initializationSettings);
//         onSelectNotification: selectNotification;
//
//   }
//
//   displayNotification({required String title, required String body}) async {
//     print("doing test");
//     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//         'your channel id', 'your channel name',
//         importance: Importance.max, priority: Priority.high);
//     var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics);
//         iOS: iOSPlatformChannelSpecifics;
//
//   }
//
//   void requestIOSPermissions() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//   Future selectNotification(String? payload) async {
//     if (payload != null) {
//       print('notification payload: $payload');
//     } else {
//       print("Notification Done");
//     }
//     Get.to(()=>Container(color: Colors.white,));
//   }
//
//   Future onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     // display a dialog with the notification details, tap ok to go to another page
//  /*   showDialog(
//       //context: context,
//       builder: (BuildContext context) => CupertinoAlertDialog(
//         title: Text(title),
//         content: Text(body),
//         actions: [
//           CupertinoDialogAction(
//             isDefaultAction: true,
//             child: Text('Ok'),
//             onPressed: () async {
//               Navigator.of(context, rootNavigator: true).pop();
//               await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SecondScreen(payload),
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//     );*/
//
//   Get.dialog(Text("hello"));
//   }
//
//
// }
//
// class IOSNotificationDetails {
//   const IOSNotificationDetails();
// }
//
//
