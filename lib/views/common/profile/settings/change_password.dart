import 'package:beauty_connect/controllers/auth_controller.dart';
import 'package:beauty_connect/controllers/general_controller.dart';
import 'package:beauty_connect/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/admob/v1.dart';
import '../../../../constants/custom_validators.dart';
import '../../../../constants/global_variables.dart';
import '../../../../localization/languages/languages.dart';
import '../../../../widgets/custom_widgets.dart';
import '../../../../widgets/text_form_fields.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key,this.isUser});
final bool? isUser;
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _obscureTextOld = true;
  bool _obscureText = true;
  bool _obscureTextConfirm = true;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
TextEditingController oldPasswordController=TextEditingController();
  TextEditingController newPasswordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  AuthController authController=Get.find();
  GeneralController generalController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black12,
        backgroundColor: AppColors.cardColor,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: Languages.of(context)!.changePassword,
          onTapLeading: () {
            Get.back();
          },
          leadingButton: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),
      body: Obx(
        ()=>authController.isLoading==true?Center(
          child: CircularProgressIndicator(
            color: AppColors.buttonColor,

          ),
        ): Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Languages.of(context)!.createNewPasswordForYourAccount,
                      textAlign: TextAlign.center,
                      style: authSubHeadings,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: AuthTextField(
                    validator: (value) => CustomValidator.oldPassword(value,context),
                    controller: oldPasswordController,
                    hintText: Languages.of(context)!.oldPassword,
                    isObscure: _obscureTextOld,
                    prefixIcon: AppImages.lockIcon,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _obscureTextOld = !_obscureTextOld;
                        });
                      },
                      child: Icon(
                        !_obscureTextOld
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: AuthTextField(
                    validator: (value) => CustomValidator.newPassword(value,context),
                    controller: newPasswordController,
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
                const SizedBox(
                  height: 20,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       Languages.of(context)!.passwordMustBeEightCharacters,
                //       textAlign: TextAlign.center,
                //       style: authSubHeading.copyWith(fontSize: 12),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: AuthTextField(
                    validator:(value) => CustomValidator.confirmPassword(value,newPasswordController.text.toString(),context),
                    controller: confirmPasswordController,
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
                const SizedBox(
                  height: 120,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
                  child: CustomButton(
                    fontWeight: FontWeight.w800,
                    textClr: AppColors.buttonTextColor,

                    buttonText: Languages.of(context)!.saveChanges,
                    onTap: () {
                      if(key.currentState!.validate()){
                      if(generalController.isUser==true){
                        authController.changePassword(oldPasswordController.text.toString(), newPasswordController.text.toString(), confirmPasswordController.text.toString(),true);
                        Get.back();
                      }if(generalController.isUser==false){
                        authController.changePassword(oldPasswordController.text.toString(), newPasswordController.text.toString(), confirmPasswordController.text.toString(),false);
                      }
                      }
                    },
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
