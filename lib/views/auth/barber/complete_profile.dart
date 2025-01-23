import 'package:beauty_connect/localization/languages/language_fr.dart';
import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:beauty_connect/widgets/text_form_fields.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../constants/custom_dialog.dart';
import '../../../constants/global_variables.dart';
import '../../../controllers/auth_controller.dart';
import '../../../guest_mode/utils/custom_dialogbox.dart';
import '../../../widgets/custom_widgets.dart';

class CompleteProfile extends StatefulWidget {
  final bool isSignUp;
  const CompleteProfile({Key? key, this.isSignUp = true}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final AuthController _authController = Get.find<AuthController>();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
TextEditingController descriptionController=TextEditingController();
TextEditingController locationController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(

        elevation: 5,
        shadowColor: Colors.black12,
        backgroundColor: AppColors.cardColor,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: Languages.of(context)!.completeProfile,
          onTapLeading: () {
            Get.back();
            // Get.back();
          },
          // actionButton: Text(
          //   "1/4",
          //   style: bodyNormal.copyWith(color: Colors.grey),
          // ),
        ),
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 300),
                  slidingBeginOffset: Offset(0, -1),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Enter following details to complete your profile",
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
                      backgroundColor:
                          AppColors.textFieldColor,
                      radius: 65,
                      child: Stack(
                        children: [
                          // Background image (from upload or default)
                          if (_authController.uploadImageFileCustomer != null)
                            Positioned.fill(
                              child: ClipOval(
                                child: Image.file(
                                  _authController.uploadImageFileCustomer!,
                                  fit: BoxFit.cover,
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
                                  color: Color(0xffFF8586),
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
                              color: Colors.white,
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
                  "Upload image",
                  style: headingSmall.copyWith(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.cardColor,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 180, maxHeight: 180),
                    child: TextFormField(
                      controller: descriptionController,
                      cursorColor: Colors.white,
                      style: headingSmall.copyWith(
                          fontSize: 15, overflow: TextOverflow.ellipsis),
                      maxLines: 10,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "Write something about you",
                        hintStyle: bodyMedium.copyWith(
                            color: Colors.white54, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  controller: locationController,
                    hintText: "Location",
                    prefixIcon: "assets/icons/auth/location_icon.png"),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: CustomButton(
                  textClr: Colors.black,
                  buttonText: "Next",
                  onTap: () async {
                    if (_authController.pickedImage == null) {
                      CustomDialog.showErrorDialog(
                          // context: context,
                          description: 'Please select the image');

                      print("not selected");
                    } else {
                      // print(_authController.barberData.value!.id.toString());
                      await _authController.updateBarberProfile(context, descriptionController.text.toString(), locationController.text.toString());
                      print("selected");
                    }
                    // Get.to(()=> AddServices());
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
