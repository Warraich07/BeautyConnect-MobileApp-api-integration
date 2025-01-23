import 'package:delayed_display/delayed_display.dart';
import 'package:beauty_connect/views/auth/signin_screen.dart';
import 'package:beauty_connect/views/user/home/user_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../constants/app_images.dart';
import '../../constants/global_variables.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/custom_widgets.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int setLanguage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.subscriptionImage,), fit: BoxFit.cover)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 16),
              child: Row(
                children: [
                  ZoomTapAnimation(
                    onTap: () {
                      Get.back();
                    },
                    onLongTap: () {},
                    enableLongTapRepeatEvent: false,
                    longTapRepeatDuration: const Duration(milliseconds: 100),
                    begin: 1.0,
                    end: 0.93,
                    beginDuration: const Duration(milliseconds: 20),
                    endDuration: const Duration(milliseconds: 120),
                    beginCurve: Curves.decelerate,
                    endCurve: Curves.fastOutSlowIn,
                    child:
                    Container(
                      height: 30, width: 30,
                      padding: EdgeInsets.only(left: 5),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: DelayedDisplay(
                      delay: Duration(milliseconds: 800),
                      slidingBeginOffset: Offset(0, -1),
                      child: Text("Be Premium",
                        style: headingLarge.copyWith(
                            color: Colors.white, fontFamily: "LufgaBlack", fontSize: 36), textAlign: TextAlign.center,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: DelayedDisplay(
                      delay: Duration(milliseconds: 900),
                      slidingBeginOffset: Offset(0, -1),
                      child: Text(
                        "Auto renewable, cancel anytime",
                        style: authSubHeading.copyWith(
                            color: Colors.white54, height: 1.5, fontSize: 13),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  DelayedDisplay(
                    delay: Duration(milliseconds: 800),
                    slidingBeginOffset: Offset(0, 1),
                    child: ZoomTapAnimation(
                      onTap: (){
                        showCustomDialog(
                            context,
                            "assets/images/popup/success.png",
                            "Account created successfully",
                            "Congratulations! Your account has been created successfully.",
                            "Go to Home", () {
                              Get.to(()=> SignInScreen(isUser: true,));
                        }, () {
                             null;
                        });
                      },
                      child: Container(
                        height: 90,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 26),
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Paid Subscription", style: headingMedium.copyWith(color: Colors.black, fontSize: 18),),
                            SizedBox(height: 5,),
                            Row(children: [
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Text("\$", style: bodySmall.copyWith(fontSize: 11, height: 1),)),
                              Text("14.99", style: headingLarge.copyWith(fontSize: 16, height: 0)),
                              Text(" / Annually, cancel any time", style: bodySmall,),
                            ],),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  DelayedDisplay(
                    delay: Duration(milliseconds: 900),
                    slidingBeginOffset: Offset(0, 1),
                    child:
                    GestureDetector(
                        onTap: () {
                          Get.offAll(() => SignInScreen(isUser: true),
                              transition: Transition.rightToLeft);
                        },
                        child: Text("12 hours free trial", style: headingSmall.copyWith(color: Colors.white),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      children: [
                        DelayedDisplay(
                          delay: Duration(milliseconds: 900),
                          slidingBeginOffset: Offset(0, 1),
                          child: CustomButton(buttonClr: Colors.white,
                            textClr: Colors.black,
                            buttonText: "Continue With Trial",
                            onTap: () {
                            showCustomDialog(context, "assets/images/popup/failed.png", "Stripe Not Connected", "Something went wrong while connecting your stripe. Please try again", "Try Again", (){
                              showCustomDialog(context, "assets/images/popup/success.png", "Account Created Successfully", "Congratulations! Your account has been created successfully.", "Go to Home", (){Get.offAll(()=> UserBottomNavBar());}, null);
                            }, null);

                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        DelayedDisplay(
                          delay: Duration(milliseconds: 1000),
                          slidingBeginOffset: Offset(0, 1),
                          child:
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Privacy Policy",
                                      style: bodySmall.copyWith(fontFamily: "SemiBoldText", color: Colors.white),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 1,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Restore Purchase",
                                      style: bodySmall.copyWith(fontFamily: "SemiBoldText", color: Colors.white),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 1,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Terms of use",
                                      style: bodySmall.copyWith(fontFamily: "SemiBoldText", color: Colors.white,),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                child: Text(
                                  "You can cancel your subscription or trial anytime by cancelling your subscription through your iTunes account settings, or it will automatically renew. This must be done 24 hours before the end of the trial or any subscription period to avoid being charged. Subscription",
                                  style: bodySmall.copyWith(color: Colors.white60),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
