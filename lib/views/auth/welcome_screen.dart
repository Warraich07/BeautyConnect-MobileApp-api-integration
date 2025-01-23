import 'package:delayed_display/delayed_display.dart';
import 'package:beauty_connect/views/auth/signin_screen.dart';
import 'package:beauty_connect/views/auth/phone_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/app_images.dart';
import '../../constants/global_variables.dart';
import '../../localization/languages/languages.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/language_alert_box.dart';

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
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.welcomeImage,), fit: BoxFit.cover),
        ),
        child: DelayedDisplay(
          slidingBeginOffset: Offset(0, 0),
          delay: Duration(milliseconds: 500),
          child: Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.transparent,Colors.transparent,Colors.black, Colors.black], begin: Alignment.topCenter, end: Alignment.bottomCenter),

            ),
            child: Column(
              children: [
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const LanguageChangeAlertBox();
                          },
                        );
                      }, icon: Icon(Icons.language,color: AppColors.whiteColor,),),
                      DelayedDisplay(
                        delay: Duration(milliseconds: 500),
                        slidingBeginOffset: Offset(0, -1),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: (){
                              // generalController.updateUserToBarber(true);
                              Get.to(()=> SignInScreen(isUser: false));
                            },
                            child: Container(
                              // height: 55,
                              width: 100,
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white
                              ),
                              child: Center(
                                child: Text(
                                  Languages.of(context)!.continueAsBarber,
                                  style: authSubHeading.copyWith(
                                      color: Colors.black, fontSize: 13),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: DelayedDisplay(
                          delay: Duration(milliseconds: 500),
                          slidingBeginOffset: Offset(0, -1),
                          child: Text(Languages.of(context)!.effortLessSaloon,
                            style: headingLarge.copyWith(
                                color: Colors.white, height: 1.3, fontSize: 7.w), textAlign: TextAlign.center,),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: DelayedDisplay(
                          delay: Duration(milliseconds: 500),
                          slidingBeginOffset: Offset(0, -1),
                          child: Text(
                            Languages.of(context)!.pickYourDream,
                            style: authSubHeading.copyWith(
                                color: Colors.white54, height: 1.5),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ),
                      SizedBox(height: 17,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          children: [
                            DelayedDisplay(
                              delay: Duration(milliseconds: 500),
                              slidingBeginOffset: Offset(0, 1),
                              child: CustomButton(
                                fontWeight: FontWeight.w800,
                                textClr: Colors.black,
                                buttonClr: AppColors.buttonColor,
                                buttonText: Languages.of(context)!.getStarted.toUpperCase(),
                                onTap: () {
                                  Get.offAll(() => PhoneVerificationScreen(),
                                      transition: Transition.rightToLeft);
                                },
                              ),
                            ),
                            SizedBox(height: 20,),
                            DelayedDisplay(
                              delay: Duration(milliseconds: 500),
                              slidingBeginOffset: Offset(0, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Languages.of(context)!.alreadyHaveAccount,
                                      style: headingSmall.copyWith(
                                          color: Colors.white, fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.offAll(() => SignInScreen(isUser: true),
                                            transition: Transition.rightToLeft);
                                      },
                                      child: Text(
                                        Languages.of(context)!.signIn,
                                        style: headingSmall.copyWith(
                                            color: AppColors.buttonColor, fontSize: 14),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Expanded(child: SizedBox()),
                    ],
                  ),
                ),
                SizedBox(height: 10,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
