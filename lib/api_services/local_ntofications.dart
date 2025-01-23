import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../controllers/booking_controller.dart';
import '../controllers/general_controller.dart';
import '../views/common/notification/notifications.dart';
import '../views/common/notification/notifications_barber.dart';

class NotificationsServices {
  BookingController bookingController = Get.find();
  GeneralController generalController=Get.find();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void initLocalNotification(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings = AndroidInitializationSettings("ic_launcher");
    var initializationSetting = InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payLoad) {
      handleMessage(context,message);
        });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      initLocalNotification(context, message);
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(), "High Importance Channel",
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        channel.id.toString(), channel.name.toString(),
        channelDescription: "your channel description",
        importance: Importance.high,
        priority: Priority.high,
      icon: '@drawable/ic_launcher',
    );
    NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  void requestNotificationsPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        badge: true,
        announcement: true,
        alert: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // DebugUtils.printDebug(StringResources.userGrantedPermission);
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // DebugUtils.printDebug(StringResources.userGrantedProvisionalPermission);
    } else {
      // DebugUtils.printDebug(StringResources.userDidNotGrantPermission);
    }
  }

  void handleMessage(BuildContext context ,RemoteMessage message){
    if(generalController.isUser==true){
      bookingController.updateNotifications();
      Get.to(NotificationsUser());
    }else{
      bookingController.updateNotifications();
      Get.to(NotificationsBarber());
    }


  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();

    return token!;
  }
}
