import 'package:beauty_connect/guest_mode/views/service_selection.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../localization/languages/languages.dart';
import '../widgets/custom_widgets.dart';
import '../widgets/language_alert_box.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int setLanguage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return const LanguageChangeAlertBox();
                  },
                );
              }, icon: Icon(Icons.language,color: Colors.black,),),
            ],
          ),
          Spacer(flex: 2,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: DelayedDisplay(
                  delay: Duration(milliseconds: 600),
                  slidingBeginOffset: Offset(0, 1),
                  child: Image.asset("assets/images/app_logo.png", scale: 3,))),
              SizedBox(height: 20,),
              SizedBox(
                width: 60.w,
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 800),
                  slidingBeginOffset: Offset(0, 1),
                  child: CustomButton(
                    buttonText: Languages.of(context)!.instantBooking,
                    onTap: () {
                      Get.to(() => ServiceSelection(),
                          transition: Transition.rightToLeft);
                    },
                  ),
                ),
              ),
            ],
          ),
          Spacer(flex: 3,),
        ],
      ),
    );
  }
}
