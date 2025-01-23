import 'package:beauty_connect/constants/app_images.dart';
import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/widgets/country_picker_widget.dart';
import 'package:beauty_connect/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OrderDetail extends StatefulWidget {
  final String pageTitle;
  final String title;
  final String name;
  final int selectedIndex;

  const OrderDetail(
      {super.key,
        required this.pageTitle,
        required this.title,
        required this.name,
        required this.selectedIndex});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black12,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: widget.pageTitle,
          onTapLeading: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Selected Services",
                    style: headingMedium,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            _servicesList(
                "assets/icons/haircut.png", "Haircut", "20 mins", "20.00"),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Customer Detail",
                    style: headingMedium,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 55,
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 18),
              margin:                EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: AppColors.textFieldColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                children: [
                  Image.asset(AppImages.userIcon, color: Colors.black45, scale: 3,),
                  SizedBox(width: 10,),
                  Text("Cameron Williamson", style: headingSmall.copyWith(color: Colors.black45),)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CountryCodePicker(),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 0.1,
                          blurRadius: 3,
                          offset: Offset(0, 0))
                    ]),
                child: Column(children: [
                  _dataRow("Haircut", "\$20"),
                  Divider(
                    color: Colors.black12,
                    height: 20,
                  ),
                  _dataRow("Total", "\$20", txtClr: AppColors.buttonColor),
                ],),
              ),
            ),
            SizedBox(height: 100,),
          ],
        ),
      ),
      bottomSheet: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(16, 2, 16, 15),
          child: Row(
            children: [
             Expanded(child: CustomButton(onTap: (){}, buttonText: "Complete Appointment",))
            ],
          )
      ),
    );
  }

  _servicesList(String icon, String title, String time, String charges) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                spreadRadius: 0.1,
                blurRadius: 3,
                offset: Offset(0, 0))
          ]),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Image.asset(
              icon,
              scale: 4,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
                  title,
                  style: headingSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Services Time",
                  style: bodySmall.copyWith(color: Colors.black54, fontSize: 8),
                ),
                Text(
                  time,
                  style: bodySmall.copyWith(),
                ),
              ],
            ),
            VerticalDivider(
              width: 20,
              thickness: 1,
              color: Colors.white54,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Services Charges",
                  style: bodySmall.copyWith(color: Colors.black54, fontSize: 8),
                ),
                Text(
                  "\$" + charges,
                  style: bodySmall.copyWith(),
                ),
              ],
            ),
            Container(
              height: 15,
              width: 15,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.buttonColor),
              ),
              child: Icon(
                Icons.circle,
                color: AppColors.buttonColor.withOpacity(0.5),
                size: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
  _dataRow(String title, String desc, {Color txtClr = Colors.black}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: bodySmall.copyWith(color: Colors.black54),overflow: TextOverflow.ellipsis, maxLines: 1,),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
                width: 60.w,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(desc, style: headingSmall.copyWith(fontSize: 12, color: txtClr), overflow: TextOverflow.ellipsis, maxLines: 1,))),
          ),
        ],
      ),
    );
  }
}
