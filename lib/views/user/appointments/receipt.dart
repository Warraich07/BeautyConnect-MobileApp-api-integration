import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/views/common/profile/settings/payment_method.dart';
import 'package:beauty_connect/views/user/home/user_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/dfareporting/v4.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/global_variables.dart';
import '../../../localization/languages/languages.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/custom_widgets.dart';

class ReceiptScreen extends StatefulWidget {
  final bool isPaid;
  const ReceiptScreen({super.key,  this.isPaid = false, this.bookingId});
  final String? bookingId;
  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  BookingController bookingController=Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingController.getBookingReceiptById(widget.bookingId??'2');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cardColor,
        title: CustomAppBar(pageTitle: widget.isPaid == false? "Review Summary" : "Appointment E-Receipt", onTapLeading: (){
          if(widget.isPaid == false){
            Get.back();
          } else {
            Get.offAll(()=> UserBottomNavBar());
          }
        },),
      ),
      body: Obx(
            ()=>bookingController.isLoading==true?Center(
          child: CircularProgressIndicator(
            color: AppColors.buttonColor,
          ),
        ): Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 15,),
                widget.isPaid == true ? Image.asset("assets/images/barcode.png",color: Colors.white,) : SizedBox.shrink(),
                SizedBox(height: 15,),
                Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.cardColor,
                      boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0.1, blurRadius: 3, offset: Offset(0, 0))]
                  ),
                  child: Column(children: [
                    _dataRow(Languages.of(context)!.saloon, bookingController.bookingReceipt.value!.booking!.saloonName.toString()),
                    _dataRow(Languages.of(context)!.address, bookingController.bookingReceipt.value!.booking!.saloonAddress.toString()),
                    _dataRow(Languages.of(context)!.barber,bookingController.bookingReceipt.value!.booking!.barber!.name.toString()),
                    _dataRow(Languages.of(context)!.bookingDate, bookingController.formattedDate.toString()),
                    _dataRow(Languages.of(context)!.bookingTime, bookingController.formattedTime.toString()),
                  ],),
                ),
                SizedBox(height: 20),
                Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.cardColor,
                      boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0.1, blurRadius: 3, offset: Offset(0, 0))]
                  ),
                  child: Column(children: [
                    ListView.builder(
                      shrinkWrap: true,
                        itemCount: bookingController.bookingReceipt.value!.booking!.services!.length,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return _dataRow(bookingController.bookingReceipt.value!.booking!.services![index].userServices!.first.name.toString(), "\$"+bookingController.bookingReceipt.value!.booking!.services![index].userServices!.first.price.toString()??"");
                        })
                    ,

                    Divider(
                      color: Colors.white12,
                      height: 20,
                    ),
                    _dataRow("Total", "\$"+bookingController.bookingReceipt.value!.booking!.totalAmount.toString(), txtClr: AppColors.buttonColor),
                  ],),
                ),
                SizedBox(height: 20),
                widget.isPaid == false? Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0.1, blurRadius: 3, offset: Offset(0, 0))]
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/images/mastercard.png", scale: 3,),
                      SizedBox(width: 5,),
                      Expanded(child: Text("MasterCard", style: headingSmall,)),
                      GestureDetector(
                          onTap: (){
                            Get.to(()=> PaymentMethod(fromSetting: false,));
                          },
                          child: Text("Change", style: headingSmall.copyWith(color: AppColors.buttonColor),)),
                    ],
                  ),
                ) : SizedBox.shrink(),
                SizedBox(height: 80,),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: widget.isPaid == false? Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(16, 2, 16, 15),
        child: CustomButton(
          onTap: (){
            dialogDoubleButton(context, "assets/images/popup/success.png", "Appointment Booked Successfully", "Congratulations! Your appointment has been booked successfully.", "Go to Home", "View E-Receipt",(){
              Get.offAll(()=> UserBottomNavBar());
            }, (){
              Get.back();
              Get.off(()=> ReceiptScreen(isPaid: true,));
            }, null);
          },
          buttonText: "Confirm Payment",
        ),
      ) : SizedBox.shrink(),
    );
  }
  _dataRow(String title, String desc, {Color txtClr = Colors.white54}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: bodySmall.copyWith(color: Colors.white),overflow: TextOverflow.ellipsis, maxLines: 1,),
          Text(desc, style: headingSmall.copyWith(fontSize: 12, color: txtClr), overflow: TextOverflow.ellipsis, maxLines: 1,),
        ],
      ),
    );
  }
}
