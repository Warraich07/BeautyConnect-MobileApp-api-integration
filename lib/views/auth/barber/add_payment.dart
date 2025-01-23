import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../constants/global_variables.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/custom_widgets.dart';
import '../../barber/home/barber_bottom_nav_bar.dart';

class AddPayment extends StatefulWidget {
  final bool isSignUp;
  const AddPayment({Key? key, this.isSignUp= true}) : super(key: key);

  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  int selectedIndex=0;
  List<int> selectedServices =[];
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black12,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: "Payment Method",
          onTapLeading: () {
            Get.back();
          },
          actionButton: Text("4/4", style: bodyNormal.copyWith(color: Colors.grey),),
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
                      "Add your working availability",
                      style: authSubHeading,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Credit & Debit Card", style: headingSmall,)),
                    _addPayment(context, "assets/images/mastercard.png", "Add New", "Add", statusColor: Colors.red),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Other Wallets", style: headingSmall,)),
                    _addPayment(context, "assets/icons/setting/paypal.png", "PayPal", "Add", statusColor: Colors.red),
                    _addPayment(context, "assets/icons/setting/apple.png", "Apple", "Add", statusColor: Colors.red),
                    SizedBox(height: 15,),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: CustomButton(
                  buttonText: "Next",
                  onTap: () {
                    showCustomDialog(context, "assets/images/popup/success.png", "Profile Completed Successfully", "Congratulations! Your profile has been completed  successfully.", "CONTINUE", (){Get.offAll(()=> BarberBottomNavBar());}, null);

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
  _addPayment(
      context,
      String icon,
      String title,
      String status,
      {Color statusColor= AppColors.primaryColor}
      ) {
    return DelayedDisplay(
      slidingBeginOffset: Offset(1, 0),
      delay: Duration(milliseconds: 200),
      child: Column(
        children: [
          ZoomTapAnimation(
            onTap: () {
            },
            child: Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 18),
              margin: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.textFieldColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 35,
                        child: Image.asset(
                          icon,
                          height: 34,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        title,
                        style: headingSmall.copyWith(height: 2),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                    },
                    child: Text(
                      status,
                      style: bodySmall.copyWith(color: statusColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
