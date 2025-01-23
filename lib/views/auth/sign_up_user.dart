import 'package:beauty_connect/controllers/general_controller.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:beauty_connect/views/auth/signin_screen.dart';
import 'package:beauty_connect/views/auth/welcome_screen.dart';
import 'package:beauty_connect/widgets/country_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../constants/app_images.dart';
import '../../constants/custom_validators.dart';
import '../../constants/global_variables.dart';
import '../../controllers/auth_controller.dart';
import '../../guest_mode/utils/custom_dialogbox.dart';
import '../../localization/languages/languages.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/text_form_fields.dart';

class SignUpUser extends StatefulWidget {
  final bool isSignUp;
  // final PhoneNumber phoneNumber;
  const SignUpUser({Key? key, this.isSignUp= true,
    // required this.phoneNumber
  }) : super(key: key);

  @override
  State<SignUpUser> createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordEditingController =
  TextEditingController();
  final TextEditingController phoneEditingController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> accountType = [
    'Teacher',
    'Parent',
  ];
  String? selectedType;
  bool _obscureText = true;
  bool _obscureTextConfirm = true;
AuthController authController=Get.find();
GeneralController generalController =Get.find();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneEditingController.text=generalController.phoneNumber.value;

  }
  final GeneralController _generalController = Get.find<GeneralController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldColor,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: widget.isSignUp == true? Languages.of(context)!.signUp : "Create User",
          onTapLeading: () {
            if(widget.isSignUp == true){
              Get.offAll(() => WelcomeScreen());
            }
            Get.back();
            // Get.back();
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 300),
                  slidingBeginOffset: Offset(0, -1),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.isSignUp == true?
                      Languages.of(context)!.enterFollowingDetailsToCompleteProfile : Languages.of(context)!.enterFollowingDetailsToCreateUser,
                      style: authSubHeading,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(0, 0),
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.textFieldColor,
                      radius: 66,
                      child: Stack(
                        children: [
                          // Background image (from upload or default)
                          if (_authController.uploadImageFileCustomer != null)
                            Positioned.fill(
                              child: ClipOval(
                                child: Image.file(
                                  _authController.uploadImageFileCustomer!,
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ),
                          if (_authController.uploadImageFileCustomer == null)
                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Image.asset(
                                  "assets/images/upload_profile.png",
                                  fit: BoxFit.contain,
                                  color: Color(0xff656565),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 10,
                      child: ZoomTapAnimation(
                        onTap: () async {
                          await _authController.uploadProfileImage(
                              "gallery", "user");
                          setState(() {});
                        },
                        onLongTap: () {},
                        enableLongTapRepeatEvent: false,
                        longTapRepeatDuration:
                            const Duration(milliseconds: 100),
                        begin: 1.0,
                        end: 0.93,
                        beginDuration: const Duration(milliseconds: 20),
                        endDuration: const Duration(milliseconds: 120),
                        beginCurve: Curves.decelerate,
                        endCurve: Curves.fastOutSlowIn,
                        child: CircleAvatar(
                            radius: 14,
                            backgroundColor: AppColors.buttonColor,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 16,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(0, 0),
                child: Text(
                  Languages.of(context)!.uploadImage,
                  style: headingSmall.copyWith(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(0, -1),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: AuthTextField(
                    controller: nameEditingController,
                    keyboardType: TextInputType.name,
                    prefixIcon: AppImages.userIcon,
                    validator: (value) =>
                        CustomValidator.isEmptyUserName(value,context),
                    hintText: Languages.of(context)!.fullName,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            DelayedDisplay(
              delay: Duration(milliseconds: 400),
              slidingBeginOffset: Offset(0, -1),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: AuthTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailEditingController,
                  prefixIcon: AppImages.emailIcon,
                  validator: (value) => CustomValidator.email(value,context),
                  hintText: Languages.of(context)!.emailAddress,
                ),
              ),
            ),
              SizedBox(
                height: 15,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(0, -1),
                child: AbsorbPointer(
                    absorbing: true,
                    child: CountryCodePicker(
                      phoneController: phoneEditingController,
                      validator: (String? value) => CustomValidator.number(value,context),)),
              ),
              SizedBox(
                height: 15,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(0, -1),
                child: Padding(

                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: AuthTextField(
                    controller: passwordEditingController,
                    keyboardType: TextInputType.visiblePassword,
                    isObscure: _obscureText,
                    prefixIcon: AppImages.lockIcon,
                    validator: (value) => CustomValidator.password(value,context),
                    hintText: Languages.of(context)!.password,
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
              SizedBox(
                height: 15,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(0, -1),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: AuthTextField(
                    controller: confirmPasswordEditingController,
                    keyboardType: TextInputType.visiblePassword,
                    isObscure: _obscureTextConfirm,
                    prefixIcon: AppImages.lockIcon,
                    validator: (value) => CustomValidator.confirmPassword(value,passwordEditingController.text.toString(),context),
                    hintText: Languages.of(context)!.confirmPassword,
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
              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: CustomButton(
                  fontWeight: FontWeight.w800,
                  textClr: Colors.black,
                  buttonText: Languages.of(context)!.SIGNUP,
                  onTap: () async{
                    // Map<String, dynamic> map = {
                    //   "email": emailEditingController.text.toString(),
                    //   "password": passwordEditingController.text.toString(),
                    //   "name": nameEditingController.text.toString(),
                    // };
                    if(_formKey.currentState!.validate()){
                      if(authController.pickedImage==null){
                        CustomDialog.showErrorDialog(description:Languages.of(context)!.pleaseSelectTheImage);
                        // CustomDialogBox.showErrorDialog(context: context,description: 'Please select the image',title: '');

                        print("not selected");
                      }else{
                        _generalController.onBottomBarTapped(0);
                        await authController.registerUser(context, nameEditingController.text.toString(), emailEditingController.text.toString(), generalController.phoneNumber.value, generalController.countryCode.value, passwordEditingController.text.toString());

                        print("selected");
                      }

                    }


                    // if (key.currentState!.validate()) {
                    //   _authController.userRegister(map, context, false);
                    // }
                  },
                ),
              ),
              SizedBox(
                height: widget.isSignUp == true? 20 : 0,
              ),
              widget.isSignUp == true? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Languages.of(context)!.alreadyHaveAnAccount,
                      style: headingSmall.copyWith(
                          color: Colors.white54, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAll(() => SignInScreen(isUser: true));
                      },
                      child: Text(
                        Languages.of(context)!.signIn,
                        style: headingSmall.copyWith(
                            color: AppColors.buttonColor, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ) : SizedBox.shrink(),
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
