import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/views/common/profile/settings/payment_method.dart';
import 'package:beauty_connect/views/user/home/user_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/global_variables.dart';
import '../../../localization/languages/languages.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/custom_widgets.dart';

class ReviewSummary extends StatefulWidget {
  final bool isPaid;
  const ReviewSummary({super.key,  this.isPaid = false, this.bookingId});
  final String? bookingId;
  @override
  State<ReviewSummary> createState() => _ReviewSummaryState();
}

class _ReviewSummaryState extends State<ReviewSummary> {
  BookingController bookingController=Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingController.getBookingReceiptById(widget.bookingId??'2');
  }
  @override
  Widget build(BuildContext context) {
    // print(bookingController.bookingReceipt.value!.booking!.status);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cardColor,
        title: CustomAppBar(pageTitle: widget.isPaid == false? Languages.of(context)!.reviewSummary : Languages.of(context)!.appointmentEReceipt, onTapLeading: (){
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
                     boxShadow: [BoxShadow(color: Colors.white12, spreadRadius: 0.1, blurRadius: 3, offset: Offset(0, 0))]
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
                    Container(
                      // color: Colors.green,
                      // height :80,
                      child: ListView.builder(
                          itemCount: bookingController.createdBookingList.value!.services!.length,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return _dataRow(
                               bookingController.languageCode=='en'? bookingController.createdBookingList.value!.services![index].userServices!.first.name.toString():
                               bookingController.languageCode=='pt'? bookingController.createdBookingList.value!.services![index].userServices!.first.portugueseName.toString():
                               bookingController.createdBookingList.value!.services![index].userServices!.first.frenchName.toString()
                                , "\$"+
                                bookingController.createdBookingList.value!.services![index].userServices!.first.price.toString());
                          }),
                    ),
                    Divider(
                      color: Colors.white12,
                      height: 20,
                    ),
                    _dataRow(Languages.of(context)!.total, "\$"+bookingController.createdBookingList.value!.totalAmount.toString(), txtClr: AppColors.buttonColor),
                  ],),
                ),
                SizedBox(height: 20),
               // widget.isPaid == false? Container(
               //    width: 100.w,
               //    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
               //    margin: EdgeInsets.all(2),
               //    decoration: BoxDecoration(
               //        borderRadius: BorderRadius.circular(10),
               //        color: Colors.white,
               //        boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0.1, blurRadius: 3, offset: Offset(0, 0))]
               //    ),
               //    child: Row(
               //      children: [
               //        Image.asset("assets/images/mastercard.png", scale: 3,),
               //        SizedBox(width: 5,),
               //        Expanded(child: Text("MasterCard", style: headingSmall,)),
               //        GestureDetector(
               //            onTap: (){
               //              Get.to(()=> PaymentMethod(fromSetting: false,));
               //            },
               //            child: Text(Languages.of(context)!.change, style: headingSmall.copyWith(color: AppColors.buttonColor),)),
               //      ],
               //    ),
               //  ) : SizedBox.shrink(),
                SizedBox(height: 80,),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: widget.isPaid == false? Container(
        color: AppColors.cardColor,
        padding: EdgeInsets.fromLTRB(16, 2, 16, 15),
        child: CustomButton(
          textClr: AppColors.scaffoldColor,
          onTap: (){
            dialogDoubleButton(context, "assets/images/popup/success.png", Languages.of(context)!.appointmentBookedSuccessfully, Languages.of(context)!.congratulationsAppointmentSuccess, Languages.of(context)!.goToHome, Languages.of(context)!.viewEReceipt,(){
              Get.offAll(()=> UserBottomNavBar());
            }, (){
              Get.back();
              Get.off(()=> ReviewSummary(isPaid: true,));
            }, null);
          },
          buttonText: Languages.of(context)!.confirmPayment,
        ),
      ) : SizedBox.shrink(),
    );
  }
  _dataRow(String title, String desc, {Color txtClr = Colors.white}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 30.w,
              child: Text(title, style: bodySmall.copyWith(color: Colors.white54),)),
          Text(desc, style: headingSmall.copyWith(fontSize: 12, color: txtClr),),
        ],
      ),
    );
  }
}
