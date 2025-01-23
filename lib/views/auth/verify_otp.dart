import 'package:beauty_connect/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/global_variables.dart';
import '../../guest_mode/utils/custom_dialogbox.dart';
import '../../localization/languages/languages.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/text_form_fields.dart';
import 'forgot_password.dart';
import 'dart:async';
class VerifyOTP extends StatefulWidget {
  final String email;
  final bool fromSignUp;
  final bool isUser;
  const VerifyOTP({Key? key, required this.email, required this.fromSignUp,required this.isUser}) : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final controller = Get.put(AuthController());
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final AuthController _authController = Get.find<AuthController>();

  int _countdown = 20;
  bool _resendVisible = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // showMessage = false;
    startTimer();
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          // Timer reached zero, enable resend button
          _timer.cancel();
          _resendVisible = true;
        }
      });
    });
  }

  void resendOtp() {
    // Logic to resend OTP, e.g., make API call
    setState(() {
      _countdown = 20; // Reset countdown
      _resendVisible = false; // Hide resend button
    });
    startTimer(); // Start the timer again
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldColor,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: widget.fromSignUp == true ? Languages.of(context)!.verifyMobileNumber : Languages.of(context)!.verifyEmailAddress,
          onTapLeading: () {
            if(widget.fromSignUp == true){
              Get.back();
            } else {
              Get.off(() => ForgotPassword(isUser: widget.isUser,));
            }
          },
          leadingButton: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.fromSignUp == true ? Languages.of(context)!.weHaveSentFourDigitCodeOnMobile : Languages.of(context)!.weHaveSentFourDigitCodeOnEmail,
                  style: authSubHeading,
                ),
              ),
            ),
            SizedBox(
              height: 17.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: OtpField(

                  // email: widget.email.toString(),
                  ),
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child:_resendVisible?GestureDetector(
                  onTap: (){
                    if(widget.isUser==true){
                      _authController.sendForgetPasswordCode(_authController.forgetPasswordEmailUser.value);
                    }else{
                      _authController.sendForgetPasswordCodeToBarber(_authController.forgetPasswordEmailBarber.value);
                      print("barber");
                    }
                        print(widget.fromSignUp);
                        print(widget.isUser);
                  },
                  child: Text(Languages.of(context)!.resend,style: TextStyle(color:AppColors.buttonColor),)): Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Languages.of(context)!.resendCodeIn,
                    style: headingSmall.copyWith(
                        color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     // Get.off(() => SignUpScreen(
                  //     //   controller: TextEditingController(),
                  //     // ));
                  //   },
                  //   child: Text(
                  //     Languages.of(context)!.resend,
                  //     style: bodyNormal.copyWith(
                  //       color: AppColors.buttonColor,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  Text(
                     '00:${_countdown.toString().padLeft(2, '0')}', // Use padLeft to format
                    style: bodyNormal.copyWith(
                      color: AppColors.buttonColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 4),
              child: CustomButton(
                  fontWeight: FontWeight.w800,
                  textClr: Colors.black,
                  buttonText: Languages.of(context)!.verify,
                  onTap: () {
                    // print(controller.verifyOtp.value);
                    // print(controller.otp.value);
                    // Map<String, String> map = {
                    //   "email": widget.email.toString(),
                    // };

                    if(widget.isUser==true){
                      if(controller.verifyOtp.value==''){
                        CustomDialog.showErrorDialog(description: "Please enter OTP");
                      }else if(controller.verifyOtp.value.length<4){
                        CustomDialog.showErrorDialog(description: "Please enter complete OTP");
                      }else{
                        if(widget.fromSignUp==true){
                          controller.verifyOtpCode();
                        }else{
                          controller.verifyForgetPasswordCode();
                        }
                      }

                    }if(widget.isUser==false){
                      if(controller.verifyOtp.value==''){
                        CustomDialog.showErrorDialog(description: "Please enter OTP");
                      }else if(controller.verifyOtp.value.length<4){
                        CustomDialog.showErrorDialog(description: "Please enter complete OTP");
                      }else{
                        controller.verifyBarberForgetPasswordCode();

                      }
                    }


                    // if(widget.fromSignUp == true) {
                    //   if(controller.otp.value==controller.verifyOtp.value){
                    //     // print(controller.verifyOtp.value);
                    //     // print(controller.otp.value);
                    //     Get.to(() => SignUpUser());
                    //   }
                    //
                    //  else {
                    //   CustomDialogBox.showErrorDialog(context: context,title: 'Otp does not match',description: '');
                    //   // Get.to(() => ResetPassword(email: ""));
                    //
                    // }

                    // if (key.currentState!.validate()) {
                    //   _authController.verifyOTP(map, context);
                    // }
                    // PageTransition.pageNavigation(page: const ResetPassword());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
