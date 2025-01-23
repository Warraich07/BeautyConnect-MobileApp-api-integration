import 'package:beauty_connect/controllers/general_controller.dart';
import 'package:beauty_connect/widgets/country_picker_widget.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:beauty_connect/views/auth/signin_screen.dart';
import 'package:beauty_connect/views/auth/welcome_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:sizer/sizer.dart';
import '../../constants/custom_dialog.dart';
import '../../constants/custom_validators.dart';
import '../../constants/global_variables.dart';
import '../../controllers/auth_controller.dart';
import '../../guest_mode/utils/custom_dialogbox.dart';
import '../../localization/languages/languages.dart';
import '../../widgets/custom_widgets.dart';
import '../common/profile/settings/terms_and_conditions.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  // bool _obscureText = true;
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
  TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController=TextEditingController();

  final GlobalKey<FormState> key = GlobalKey<FormState>();
  bool keepSignIn = false;
  bool agreeTerms = false;
GeneralController generalController=Get.find();
  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize variables here in initState
  //   initialCountry = generalController.initialCountry.value;
  //   number = PhoneNumber(isoCode: initialCountry);
  //
  //   // Assuming AuthController and GeneralController are initialized via GetX (assuming GetX here)
  //   authController = Get.find();
  //   generalController = Get.find();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldColor,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: Languages.of(context)!.enterTheMobileNumber,
          onTapLeading: () {
            Get.offAll(() => WelcomeScreen());
          },

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
                const EdgeInsets.symmetric(horizontal: 18.0),
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 300),
                  slidingBeginOffset: Offset(0, -1),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Languages.of(context)!.youMayReceiveSms,
                      style: authSubHeading,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Form(
                key: _formKey,
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 400),
                  slidingBeginOffset: Offset(-1, 0),
                  child: CountryCodePicker(
                    phoneController: phoneController,
                    // validator: (String? value) => CustomValidator.number(value,context),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 1000),
                slidingBeginOffset: Offset(0, -1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            agreeTerms = !agreeTerms;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 2),
                          height: 24,
                          width: 24,

                          // padding: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: agreeTerms == true
                                    ?AppColors.whiteColor
                                    : AppColors.whiteColor,
                                width: 1.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                              child: Icon(
                                agreeTerms == true ? Icons.check : null,
                                size: 15,
                                color: AppColors.whiteColor,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: Languages.of(context)!.agreeTo,
                            style: headingSmall.copyWith(
                                color: AppColors.whiteColor, fontSize: 13),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => showTermsAndConditions(
                                      context,
                                      "Terms and Conditions for Technical Advice on Home Renovation, Repair, and Improvement:",
                                      ConditionsWidget(isUser: false),
                                      "Go Back".toUpperCase(), () {
                                    Get.back();
                                  }),
                                text: Languages.of(context)!.termsAndConditions,
                                style: headingSmall.copyWith(
                                    color: AppColors.buttonColor,
                                    fontSize: 13),
                              ),
                              TextSpan(
                                text:Languages.of(context)!.and,
                                style: headingSmall.copyWith(
                                    fontSize: 13),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => showTermsAndConditions(
                                      context,
                                      "Privacy Policies for Technical Advice on Home Renovation, Repair, and Improvement:",
                                      ConditionsWidget(isUser: false),
                                      "Go Back".toUpperCase(), () {
                                    Get.back();
                                  }),
                                text: Languages.of(context)!.privacyPolicy,
                                style: headingSmall.copyWith(
                                    color: AppColors.buttonColor,
                                    fontSize: 13),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: CustomButton(
                  fontWeight: FontWeight.w800,
                  textClr: Colors.black,
                  buttonText: Languages.of(context)!.CONTINUE,
                  onTap: () {
                    // Map<String, String> map = {
                    //   "email": emailEditingController.text.toString(),
                    //   "password": passwordEditingController.text.toString(),
                    // };
                      generalController.updatePhone(phoneController.text.toString());

                    // if(_formKey.currentState!.validate()){
                      if(generalController.phoneNumber.value.isEmpty){
                        CustomDialog.showErrorDialog(description:Languages.of(context)!.pleaseEnterPhoneNumber);

                      }else if(phoneController.text.length<6){
                        CustomDialog.showErrorDialog(description: Languages.of(context)!.pleaseEnterValidPhoneNumber);
                      }
                      else if(agreeTerms==true){
                        _authController.sendCode(generalController.countryCode+phoneController.text);
                      }else{
                        CustomDialog.showErrorDialog(description:Languages.of(context)!.pleaseCheckTermsAndConditions);

                        // CustomDialogBox.showErrorDialog(context: context,title: Languages.of(context)!.error,description: Languages.of(context)!.pleaseCheckTermsAndConditions);
                      }
                    // }

                    // _authController.getOtp();
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
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: 100.w,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Languages.of(context)!.alreadyHaveAnAccount,
                style: headingSmall.copyWith(
                    fontSize: 13),
                textAlign: TextAlign.center,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => SignInScreen(isUser: true));
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
        ),
      ),
    );
  }
}
