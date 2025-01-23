import 'package:beauty_connect/views/auth/phone_verification_screen.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:beauty_connect/constants/app_images.dart';
import 'package:beauty_connect/views/auth/forgot_password.dart';
import 'package:beauty_connect/views/auth/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/custom_validators.dart';
import '../../constants/global_variables.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/general_controller.dart';
import '../../localization/languages/languages.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/text_form_fields.dart';

class SignInScreen extends StatefulWidget {

  final bool isUser;
  const SignInScreen({Key? key, required this.isUser}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscureText = true;
  // final AuthController _authController = Get.find<AuthController>();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final GeneralController _generalController = Get.find<GeneralController>();

  final GlobalKey<FormState> key = GlobalKey<FormState>();
  bool keepSignIn = false;
  AuthController authController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldColor,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: Languages.of(context)!.signIn,
          onTapLeading: () {
            Get.offAll(() => WelcomeScreen());
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 300),
                  slidingBeginOffset: Offset(0, -1),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Languages.of(context)!.enterFollowingDetailsToSignIn,
                      style: authSubHeading,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(-1, 0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
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
                height: 20,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(0, -1),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: AuthTextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordEditingController,
                    validator: (value) => CustomValidator.password(value,context),
                    hintText: Languages.of(context)!.password,
                    prefixIcon: AppImages.lockIcon,
                    isObscure: _obscureText,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        !_obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => ForgotPassword(isUser: widget.isUser,),
                          transition: Transition.leftToRight);
                      print(widget.isUser);
                    },
                    child: Text(
                      Languages.of(context)!.forgotPassword,
                      style: headingSmall.copyWith(
                        fontSize: 13,
                        color: AppColors.buttonColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: CustomButton(
                  fontWeight: FontWeight.w800,
                  textClr: AppColors.scaffoldColor,
                  buttonText: Languages.of(context)!.signInCapitalized,
                  onTap: () async{
                    // Map<String, String> map = {
                    //   "email": emailEditingController.text.toString(),
                    //   "password": passwordEditingController.text.toString(),
                    // };
                    print(widget.isUser);
                   if(key.currentState!.validate()){
                     if(widget.isUser == true){
                       _generalController.updateUserType(true);
                       _generalController.onBottomBarTapped(0);
                       await authController.loginUser(emailEditingController.text.toString(), passwordEditingController.text.toString());
                     }else if(widget.isUser == false) {
                       _generalController.updateUserType(false);
                       _generalController.onBottomBarTapped(0);
                       authController.saveBarberCredentials(emailEditingController.text.toString(), passwordEditingController.text.toString());
                       await authController.loginBarber(emailEditingController.text.toString(), passwordEditingController.text.toString());
                       // Get.offAll(() => BarberBottomNavBar());
                     }
                   }
                    // if (key.currentState!.validate()) {
                    //   FocusManager.instance.primaryFocus!.unfocus();
                    //   _authController.userLogin(map, context, false);
                    // }
                  },
                ),
              ),
              SizedBox(
                height: 27.h,
              ),
              Column(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:widget.isUser==true? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Languages.of(context)!.doNotHaveAnAccount,
                        style: headingSmall.copyWith(
                            color: Colors.white54, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                      InkWell(
                        onTap: () {
                          if(widget.isUser == true){
                            Get.to(() => PhoneVerificationScreen());
                          } else {
                            // Get.to(() => CompleteProfile());
                          }
                        },
                        child: Text(
                          Languages.of(context)!.signUp,
                          style: headingSmall.copyWith(
                              color: AppColors.buttonColor, fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ):Container(),
                ),
                // SizedBox(
                //   height: 1.h,
                // ),
              ],),
            ],
          ),
        ),
      ),
    );
  }
}
