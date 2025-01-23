import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:beauty_connect/constants/app_images.dart';
import 'package:beauty_connect/views/auth/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/custom_validators.dart';
import '../../constants/global_variables.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/text_form_fields.dart';

class ResetPassword extends StatefulWidget {
  final email;
  final bool isUser;
  const ResetPassword({
    required this.email,
    Key? key,required this.isUser
  }) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _obscureText = true;
  bool _obscureTextConfirm = true;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordEditingController =
      TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldColor,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: Languages.of(context)!.resetPassword,
          onTapLeading: () {
            Get.off(() => SignInScreen(isUser: true,));
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
                    Languages.of(context)!.createNewPasswordForYourAccount,
                    style: authSubHeading,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(0, -1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: AuthTextField(
                    controller: passwordEditingController,
                    validator: (value) => CustomValidator.password(value,context),
                    hintText: Languages.of(context)!.newPassword,
                    isObscure: _obscureText,
                    prefixIcon: AppImages.lockIcon,
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
              const SizedBox(
                height: 20,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(0, -1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: AuthTextField(
                    controller: confirmPasswordEditingController,
                    validator: (value) => CustomValidator.confirmPassword(
                        value, passwordEditingController.text.toString(),context),
                    hintText: Languages.of(context)!.confirmPassword,
                    isObscure: _obscureTextConfirm,
                    prefixIcon: AppImages.lockIcon,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _obscureTextConfirm = !_obscureTextConfirm;
                        });
                      },
                      child: Icon(
                        !_obscureTextConfirm
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
                child: CustomButton(
                  textClr: AppColors.scaffoldColor,
                  fontWeight: FontWeight.w800,
                  buttonText: Languages.of(context)!.CONTINUE,
                  onTap: () {
                    if(key.currentState!.validate()){
                      if(widget.isUser==true){
                        _authController.resetPassword(passwordEditingController.text.toString(), confirmPasswordEditingController.text.toString());
                      }if(widget.isUser==false){
                        _authController.resetBarberPassword(passwordEditingController.text.toString(), confirmPasswordEditingController.text.toString());
                      }
                    }
                    // Get.offAll(() => SignInScreen(isUser: true,));
                    // Map<String, String> map = {
                    //   "email": widget.email.toString(),
                    //   'password': passwordEditingController.text.toString(),
                    //   'confirm_password':
                    //       confirmPasswordEditingController.text.toString(),
                    // };
                    // if (key.currentState!.validate()) {
                    //   _authController.changePassword(map, context);
                    // }
                  },
                ),
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
