import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/models/user_model.dart';
import 'package:beauty_connect/utils/shared_preference.dart';
import 'package:beauty_connect/views/auth/welcome_screen.dart';
import 'package:beauty_connect/views/barber/home/barber_bottom_nav_bar.dart';
import 'package:beauty_connect/views/user/home/user_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'api_services/local_ntofications.dart';
import 'api_services/notifications_services.dart';
import 'controllers/auth_controller.dart';
import 'controllers/booking_controller.dart';
import 'models/barbers_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  getData() async {

    // AuthPreference.instance.setUserLoggedIn(false);
    // bool isLoggedIn = await AuthPreference.instance.getUserLoggedIn();
    Map<String, dynamic> userStatus = await AuthPreference.instance.getUserLoggedIn();
    bool isLoggedIn = userStatus["isLoggedIn"];
    String userType = userStatus["userType"];
    print(isLoggedIn);
    print(userType);
    if (isLoggedIn==true && userType=="user") {
      _authController.accessToken.value =
      await AuthPreference.instance.getUserDataToken();
      print(await AuthPreference.instance.getUserData());
      String result = await AuthPreference.instance.getUserData();
      Map<String,dynamic> userMap = jsonDecode(result) as Map<String, dynamic>;
      _authController.userData.value = UserModel.fromJson( userMap);


      Timer(
          const Duration(seconds: 4),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => UserBottomNavBar())));
    }else if (isLoggedIn==false && userType=="user")  {
      Timer(
          const Duration(seconds: 4),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WelcomeScreen())));
    }else if (isLoggedIn==true && userType=="barber"){
      _authController.accessToken.value =
      await AuthPreference.instance.getUserDataToken();
      print(await AuthPreference.instance.getUserData());
      String result = await AuthPreference.instance.getUserData();
      Map<String,dynamic> userMap = jsonDecode(result) as Map<String, dynamic>;
      _authController.barberData.value = BarbersModel.fromJson( userMap);


      Timer(
          const Duration(seconds: 4),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BarberBottomNavBar())));
    }else{
      Timer(
          const Duration(seconds: 4),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WelcomeScreen())));
    }
  }
  BookingController bookingController=Get.find();
  final AuthPreference _authPreference = AuthPreference.instance;
   setData()async{

      _authController.accessToken.value=await _authPreference.getUserDataToken();
  }
  @override
  void initState() {
    super.initState();
    _authController.getFcmToken();
   print( _authController.token.value.toString()+"this is");
    setData();
    NotificationsServices notificationsServices = NotificationsServices();
    notificationsServices.requestNotificationsPermission();
    notificationsServices.getDeviceToken().then((value) async{
      log(value.toString());
      bookingController.updateFcmToken(value);
      Map<String, dynamic> userStatus = await AuthPreference.instance.getUserLoggedIn();
      bool isLoggedIn = userStatus["isLoggedIn"];
      if(isLoggedIn==true){
        bookingController.updateFcmNotificationToken(value.toString());
      }
    });

    notificationsServices.firebaseInit(context);
    PushNotifications.sendNotificationToSelectedDriver(_authController.token.toString());
    getData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 35.h,),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Image.asset(
                  "assets/images/app_logo_black.png",scale: 4,
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            SizedBox(
              height: 50,
              width: 50,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
              SpinKitCircle(
              color: Colors.white,
                size: 50.0,
              ),
                ],
              ),
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
