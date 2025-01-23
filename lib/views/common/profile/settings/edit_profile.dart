import 'package:beauty_connect/constants/app_images.dart';
import 'package:beauty_connect/controllers/general_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:beauty_connect/widgets/country_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../constants/custom_validators.dart';
import '../../../../constants/global_variables.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../localization/languages/languages.dart';
import '../../../../widgets/custom_widgets.dart';
import '../../../../widgets/text_form_fields.dart';

class EditProfile extends StatefulWidget {
  final bool isUser;
  const EditProfile({super.key, this.isUser = false});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();

  final TextEditingController phoneEditingController = TextEditingController();
  AuthController authController=Get.find();
  GeneralController generalController=Get.find();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
   String imagePath='';
   final TextEditingController bioController=TextEditingController();
  final TextEditingController locationController=TextEditingController();


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isUser==true){
      imagePath=authController.userData.value!.image;
      print(imagePath);
      nameEditingController.text=authController.userData.value!.name;
      emailEditingController.text=authController.userData.value!.email;
      phoneEditingController.text=authController.userData.value!.phone;
      generalController.initialCountry.value;
      // authController.barberData.value!.name
    }else{
      imagePath=authController.barberData.value!.image??"";
      nameEditingController.text=authController.barberData.value!.name;
      bioController.text=authController.barberData.value!.about==null?"write something about you":authController.barberData.value!.about;
      locationController.text=authController.barberData.value!.location??'Faisalabad';
      print("barber");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=>authController.isLoading==false? Scaffold(
        appBar: AppBar(
          elevation: 5,
          shadowColor: Colors.black12,
          backgroundColor: AppColors.cardColor,
          automaticallyImplyLeading: false,
          title: CustomAppBar(
            pageTitle: Languages.of(context)!.editPersonalInfo,
            onTapLeading: () {
              Get.back();
            },
            leadingButton: Icon(
              Icons.arrow_back_ios,
              size: 22,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Languages.of(context)!.editYourPersonalDetails, style: headingSmall,)),
              ),
              SizedBox(height: 10,),
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(0, 0),
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.scaffoldColor,
                      radius: 65,
                      // backgroundImage:
                      //     _authController.uploadImageFileHomeOwner != null
                      //         ? FileImage(_authController
                      //                 .uploadImageFileHomeOwner!)
                      //             as ImageProvider
                      //         : AssetImage(
                      //             "assets/images/upload_image.png",
                      //             // AppImages.profileImage,
                      //           ),
                      child: Stack(
                        children: [
                          // Background image (from upload or default)
                          if (_authController.uploadImageFileCustomer != null)
                            Positioned.fill(
                              child: ClipOval(
                                child:
                                Image.file(
                                  _authController.uploadImageFileCustomer!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          if (_authController.uploadImageFileCustomer == null)
                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    imageUrl:imagePath,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.buttonColor,

                                        )),
                                    errorWidget: (context, url,
                                        error) =>
                                        Image.asset(
                                            "assets/img.png"),
                                    fit: BoxFit.cover,

                                  ),
                                  // Image.network(
                                  //  widget.isUser == true? imagePath : imagePath,
                                  //   fit: BoxFit.cover,
                                  // ),
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
                        longTapRepeatDuration: const Duration(milliseconds: 100),
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
                              color: AppColors.scaffoldColor,
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
                  Languages.of(context)!.changeImage,
                  style: headingSmall.copyWith(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              AbsorbPointer(
                absorbing: true,
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 400),
                  slidingBeginOffset: Offset(0, -1),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: AuthTextField(
                      controller: nameEditingController,
                      keyboardType: TextInputType.name,
                      prefixIcon: AppImages.userIcon,
                      hintText: widget.isUser == true? authController.userData.value!.name : "name",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              widget.isUser == true?

              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(0, -1),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: AuthTextField(
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: AppImages.emailIcon,
                    controller: emailEditingController,
                    validator: (value) => CustomValidator.email(value,context),
                    hintText: Languages.of(context)!.emailAddress,
                  ),
                ),
              )
                  :
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.textFieldColor,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 180, maxHeight: 180),
                    child: TextFormField(
                      controller: bioController,
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
                        hintText: Languages.of(context)!.writeSomeThingAboutYou,
                        hintStyle: bodyMedium.copyWith(
                            color: Colors.black45, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              widget.isUser == true?
              CountryCodePicker(phoneController: phoneEditingController,) :
              DelayedDisplay(
                delay: Duration(milliseconds: 400),
                slidingBeginOffset: Offset(0, -1),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: AuthTextField(
                    // keyboardType: TextInputType.emailAddress,
                    prefixIcon: "assets/icons/location_icon.png",
                    controller: locationController,
                    validator: (value) => CustomValidator.email(value,context),
                    hintText: "3517 W. Gray St. Utica, Pennsylv...",
                  ),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 700),
                slidingBeginOffset: Offset(0, 0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: CustomButton(
                    fontWeight: FontWeight.w800,

                    textClr: AppColors.buttonTextColor,

                    buttonText:Languages.of(context)!.saveChanges.toUpperCase(),
                    onTap: () {
                          if(widget.isUser==true){
                            authController.updateUserProfile(context, nameEditingController.text, emailEditingController.text, phoneEditingController.text.toString(), generalController.countryCode.isEmpty?authController.userData.value!.countryCode.toString():generalController.countryCode.value.toString(), authController.userData.value!.id.toString());
                          }else{
                            authController.updateBarberProfile(context, bioController.text.toString(), locationController.text.toString());
                          }
                      // Get.back();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ):Container(
        height: 100.h,
        width: 100.w,
        color: Colors.white,
        child: Center(

          child: CircularProgressIndicator(
            color: AppColors.buttonColor,

          ),
        ),
      ),
    );
  }
}
