import 'package:beauty_connect/controllers/auth_controller.dart';
import 'package:beauty_connect/controllers/general_controller.dart';
import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:beauty_connect/utils/shared_preference.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:beauty_connect/views/auth/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../constants/global_variables.dart';
import '../../../../widgets/custom_widgets.dart';
import '../widgets/card_list_widget.dart';
import 'change_password.dart';
import 'edit_profile.dart';

class SettingsScreen extends StatefulWidget {
  final bool isUser;
  const SettingsScreen({super.key, this.isUser = false});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  GeneralController generalController = Get.find<GeneralController>();
  AuthController authController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black12,
        backgroundColor: AppColors.cardColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Languages.of(context)!.settings,
              style: headingLarge.copyWith(fontSize: 21),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              widget.isUser == false?
              CardListWidget(
                suffixIcon: "assets/icons/setting/personal_info.png",
                cardText: Languages.of(context)!.personalInfo,
                onTap: () {
                  Get.to(() => EditProfile(isUser: false),
                      transition: Transition.rightToLeft);
                },
                leadingIcon: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.white,
                ),
              ) : SizedBox.shrink(),
              // widget.isUser == false?
              // CardListWidget(
              //   suffixIcon: "assets/icons/setting/services.png",
              //   cardText: Languages.of(context)!.services,
              //   onTap: () {
              //     Get.to(() => AddServices(isSignUp: false),
              //         transition: Transition.rightToLeft);
              //   },
              //   leadingIcon: Icon(
              //     Icons.arrow_forward_ios,
              //     size: 16,
              //     color: Colors.black,
              //   ),
              // ) : SizedBox.shrink(),
              // widget.isUser == false?
              // CardListWidget(
              //   suffixIcon: "assets/icons/setting/working_hours.png",
              //   cardText: Languages.of(context)!.workingHours,
              //   onTap: () {
              //     Get.to(() => WorkingHours(isSignUp: false),
              //         transition: Transition.rightToLeft);
              //   },
              //   leadingIcon: Icon(
              //     Icons.arrow_forward_ios,
              //     size: 16,
              //     color: Colors.black,
              //   ),
              // ) : SizedBox.shrink(),
              // CardListWidget(
              //   suffixIcon: "assets/icons/setting/payment_method.png",
              //   cardText: Languages.of(context)!.paymentMethods,
              //   onTap: () {
              //     Get.to(() => PaymentMethod(fromSetting: true),
              //         transition: Transition.rightToLeft);
              //   },
              //   leadingIcon: Icon(
              //     Icons.arrow_forward_ios,
              //     size: 16,
              //     color: Colors.black,
              //   ),
              // ),
              CardListWidget(
                suffixIcon: "assets/icons/setting/change_password.png",
                cardText: Languages.of(context)!.changePassword,
                onTap: () {
                  Get.to(() => ChangePassword(isUser: false,),
                      transition: Transition.rightToLeft);
                },
                leadingIcon: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(0, 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: ZoomTapAnimation(
                    onTap: () {
                      _bottomSheetLogout(context);
                    },
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0,0), blurRadius: 3, spreadRadius: 0.2),],

                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            padding: EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.buttonColor.withOpacity(0.2)),
                            child: Icon(
                              Icons.logout,
                              size: 18,
                              color: AppColors.buttonColor,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  Languages.of(context)!.logout,
                                  style: headingSmall.copyWith(
                                      fontFamily: "MediumText",

                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 500),
                slidingBeginOffset: Offset(0, 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ZoomTapAnimation(
                    onTap: () {
                      _bottomSheetDelete(context);
                    },
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0,0), blurRadius: 3, spreadRadius: 0.2),],

                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            padding: EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.buttonColor.withOpacity(0.2)),
                            child: Image.asset(
                              "assets/icons/setting/delete.png",
                              color: AppColors.buttonColor,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  Languages.of(context)!.deleteAccount,
                                  style: headingSmall.copyWith(
                                    fontFamily: "MediumText",
                                      fontSize: 15,
                                      color: AppColors.buttonColor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _bottomSheetDelete(BuildContext context) {
    showModalBottomSheet(
      backgroundColor:  AppColors.cardColor,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 34.h,
          decoration: BoxDecoration(
              color:  AppColors.cardColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
              SizedBox(
              height: 10,
            ),
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(12)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              Languages.of(context)!.deleteAccount,
              style: headingSmall.copyWith( fontSize: 20, color: AppColors.buttonColor),
            ),
            Divider(
              color: Colors.white12,
              height: 30,
              thickness: 1,
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                Languages.of(context)!.areYouSureYouWantToDelete,
                style: headingSmall.copyWith(fontFamily: "MediumText", fontSize: 17,color: Colors.white54),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomButton(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          buttonClr: AppColors.greyText,
                            onTap: () {
                              Get.back();
                            },
                            buttonText: Languages.of(context)!.no,
                            textClr: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: CustomButton(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          textClr: AppColors.buttonTextColor,
                          onTap: () async{
                           await authController.deleteAccount();
                            // AuthPreference.instance.setUserLoggedIn(false);
                            // Get.offAll(() => SignInScreen(isUser: widget.isUser,));
                            // generalController.onBottomBarTapped(0);
                          },
                          buttonText: Languages.of(context)!.yes,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _bottomSheetLogout(BuildContext context) {
    showModalBottomSheet(
      backgroundColor:  AppColors.cardColor,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 34.h,
          decoration: BoxDecoration(
              color:  AppColors.cardColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  Languages.of(context)!.logout,
                  style: headingSmall.copyWith( fontSize: 20,),
                ),
                Divider(
                  color:  Colors.white12,
                  height: 30,
                  thickness: 1,
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    Languages.of(context)!.areYouSureYouWantToLogout,
                    style: headingSmall.copyWith(fontFamily: "MediumText", fontSize: 17,color: Colors.white54),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomButton(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,

                          buttonClr: AppColors.greyText,
                          onTap: () {
                            Get.back();
                          },
                          buttonText: Languages.of(context)!.no,
                          textClr: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: CustomButton(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,

                          textClr: AppColors.buttonTextColor,

                          onTap: () async{
                            print(generalController.isUser);
                            if(generalController.isUser==false){
                              await authController.logoutUser("token");
                              AuthPreference.instance.setUserLoggedIn(false,"barber");
                              Get.offAll(() => SignInScreen(isUser: widget.isUser,));
                            }else{
                              await authController.logoutUser("token");
                              AuthPreference.instance.setUserLoggedIn(false,"user");
                              Get.offAll(() => SignInScreen(isUser: widget.isUser,));
                            }

                            // generalController.onBottomBarTapped(0);
                          },
                          buttonText: Languages.of(context)!.logout,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
