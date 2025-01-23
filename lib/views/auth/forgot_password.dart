import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:beauty_connect/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:sizer/sizer.dart';
import '../../constants/custom_validators.dart';
import '../../constants/global_variables.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/text_form_fields.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key,required this.isUser}) : super(key: key);
  final bool isUser;
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController emailEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldColor,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle:Languages.of(context)!.forgetPassword,
          onTapLeading: () {
            // Get.off(() => LoginScreen());
            Get.back();
          },
          leadingButton: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22,
          ),
        ),
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Languages.of(context)!.enterTheEmailAddressToGetCode,
                    style: authSubHeading,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(0, -1),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
                  child: AuthTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailEditingController,
                    validator: (value) => CustomValidator.email(value,context),
                    hintText: Languages.of(context)!.emailAddress,
                    prefixIcon: AppImages.emailIcon,
                  ),
                ),
              ),
              SizedBox(
                height: 22.h,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
                child: CustomButton(
                  fontWeight: FontWeight.w800,
                  textClr: AppColors.scaffoldColor,
                  buttonText: Languages.of(context)!.continuee,
                  onTap: () async {

                    if (key.currentState!.validate()) {
                      if(widget.isUser==true){
                        _authController.sendForgetPasswordCode(emailEditingController.text.toString());
                      }else{
                        _authController.sendForgetPasswordCodeToBarber(emailEditingController.text.toString());
                        print("barber");
                      }
                      // Get.to(() => VerifyOTP(email: "", fromSignUp: false,));
                    }
                  },
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
}
