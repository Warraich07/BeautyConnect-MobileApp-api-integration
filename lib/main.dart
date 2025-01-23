import 'dart:io';
import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/controllers/lazy_controller.dart';
import 'package:beauty_connect/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:workmanager/workmanager.dart';
import 'controllers/auth_controller.dart';
import 'controllers/general_controller.dart';
import 'controllers/timer_controller.dart';
import 'localization/locale_constants.dart';
import 'localization/localizations_delegate.dart';
import 'package:firebase_core/firebase_core.dart';
// final AuthController _authController = Get.find<AuthController>();
BookingController bookingController=Get.find();
void main() async{
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // Get.put(TimerController(), permanent: true);
  Workmanager().initialize(callbackDispatcher);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }






  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  Locale? _locale;


  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }


  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      // print(locale.toString "this is locals");


      setState(() {
        _locale = locale;
        print(_locale.toString()+' local');
        // print(bookingController.languageCode.value);

        // print(_locale.toString() +"this is local for localization");
        // _locale = Locale(DEVICE_LOCALE.value, '');
      });
      if(_locale.toString()=='pt'){
        bookingController.updateLanguageCode('en');
        print(bookingController.languageCode.value);
      }if(_locale.toString()=='en'){
        bookingController.updateLanguageCode('pt');
        print(bookingController.languageCode.value);
      }if(_locale.toString()=='fr'){
        bookingController.updateLanguageCode('fr');
        print(bookingController.languageCode.value);
      }
    });

    super.didChangeDependencies();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale("en", ""),
          const Locale("pt", ""),
          const Locale("fr","")
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode &&
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        locale: _locale,
        initialBinding: LazyController(),
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        title: "Beauty Connect",
        theme: ThemeData(
          useMaterial3: false,
            highlightColor: Colors.transparent,
            splashColor: Colors.white,
            primarySwatch: Colors.orange,
            scaffoldBackgroundColor: AppColors.scaffoldColor),
        home: SplashScreen(),
      );
    });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(GeneralController());
    Get.put(AuthController());
    initializeDateFormatting();
  }
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message)async{
Firebase.initializeApp();
}


void backgroundTask() {
  Workmanager().executeTask((task, inputData) async {
    final prefs = await SharedPreferences.getInstance();
    int remainingSeconds = prefs.getInt('remainingSeconds') ?? 0;

    // While there are remaining seconds, decrement every second
    while (remainingSeconds > 0) {
      await Future.delayed(Duration(seconds: 1));
      remainingSeconds--;
      await prefs.setInt('remainingSeconds', remainingSeconds);

      if (remainingSeconds <= 0) {
        // Notify the user or perform an action
      }
    }
    return Future.value(true);
  });
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    backgroundTask();
    return Future.value(true);
  });
}

