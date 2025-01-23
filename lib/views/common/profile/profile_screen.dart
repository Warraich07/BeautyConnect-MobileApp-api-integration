import 'package:beauty_connect/constants/app_images.dart';
import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:beauty_connect/views/common/profile/settings/edit_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/global_variables.dart';
import '../../../controllers/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  final bool isUser;

  ProfileScreen({super.key, required this.isUser});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> images = [
    "assets/images/violin_class.png",
    "assets/images/violin_performance.png",
  ];
  List<String> cardTitle = [
    "Today Violin Class",
    "Violin Lesson 1",
  ];
  List<String> title = [
    "Violin Online Performance",
    "Violin Tutorials",
  ];
  List<int> selectedList = [];
  List<int> selectedListAdmin = [];
  AuthController authController=Get.find();
  BookingController bookingController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black12,
        backgroundColor: AppColors.cardColor,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Container(
                //   color: Colors.green,
                //   child: GestureDetector(
                //       onTap: (){
                //         Get.back();
                //         print("object");
                //       },
                //       child: Icon(Icons.arrow_back_ios)),
                // ),
                Text(
                  Languages.of(context)!.profile,
                  style: headingLarge.copyWith(fontSize: 21),
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                Get.to(()=> EditProfile(isUser: true,));
              },
              child: Row(
                children: [
                  Text(Languages.of(context)!.edit, style: bodyMedium.copyWith(color: AppColors.buttonColor),),
                  SizedBox(width: 2,),
                  Image.asset("assets/icons/setting/edit_icon.png", scale: 4,color: AppColors.buttonColor,),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            CircleAvatar(
              radius: 60,
              backgroundImage: CachedNetworkImageProvider(widget.isUser == true
                  ? authController.userData.value!.image
                  : "assets/images/cameron.png"),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: AppColors.textFieldColor,
                borderRadius: BorderRadius.circular(100)
              ),
              child: Row(
                children: [
                  Image.asset(AppImages.userIcon, scale: 3,color: Colors.white,),
                  SizedBox(width: 10,),
                  Text(authController.userData.value!.name, style: headingSmall,)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: AppColors.textFieldColor,
                  borderRadius: BorderRadius.circular(100)
              ),
              child: Row(
                children: [
                  Image.asset(AppImages.emailIcon, scale: 4,color:Colors.white,),
                  SizedBox(width: 10,),
                  Text(authController.userData.value!.email, style: headingSmall,)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: AppColors.textFieldColor,
                  borderRadius: BorderRadius.circular(100)
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Text(authController.userData.value!.countryCode, style: headingSmall,),
                    VerticalDivider(
                      width: 30,
                      color: Colors.white54,
                    ),
                    Text(authController.userData.value!.phone, style: headingSmall,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
