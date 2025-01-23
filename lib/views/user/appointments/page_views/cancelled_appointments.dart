import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/global_variables.dart';
import '../../../../localization/languages/languages.dart';
import '../../../../widgets/card_widget.dart';
import '../../home/add_new_booking.dart';
import '../receipt.dart';

class CancelledPageView extends StatefulWidget {
  const CancelledPageView({super.key});

  @override
  State<CancelledPageView> createState() => _CancelledPageViewState();
}

class _CancelledPageViewState extends State<CancelledPageView> {
  @override
  Widget build(BuildContext context) {
    return bookingController.canceledBookingList.isNotEmpty? Padding(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
      child:bookingController.isLoading==true?CircularProgressIndicator(
        color: AppColors.buttonColor,
      ) :Obx(
            ()=> ListView.builder(
            itemCount: bookingController.canceledBookingList.length,
            // physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 4),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {},
                  child: CardWidget(
                    paddingForServices:0,

                    reasonOfCancellation: bookingController.canceledBookingList[index].reason.toString()=='null'?"":bookingController.canceledBookingList[index].reason.toString(),
                    isCancelled: true,
                    locationImage:bookingController.canceledBookingList[index].barber!.location.toString()=='null'?Container(): Image.asset("assets/icons/location_icon.png", scale: 9,color: AppColors.buttonColor,),
                    averageRating: bookingController.canceledBookingList[index].averageRating.toString(),
                    appointmentStatus:
                    Languages.of(context)!.canceled,
                    image: bookingController
                        .canceledBookingList[
                    index]
                        .barber!
                        .image
                        .toString(),
                    title: "",
                    name: bookingController
                        .canceledBookingList[
                    index]
                        .barber!
                        .name
                        .toString(),
                    isActive: true,
                    onTapCancel: () {
                      // Get.to(() => CancelAppointment(bookingId: bookingController.selectedBookingList[index].id.toString(),bookingIndex: index,));
                      // print(bookingController.selectedBookingList[index].id.toString());
                    },
                    onTapReceipt: () {
                      Get.to(() => ReceiptScreen(
                        isPaid: true,
                        bookingId:
                        bookingController
                            .canceledBookingList[
                        index]
                            .id
                            .toString(),
                      ));
                    },
                    appointmentCharges:
                    bookingController
                        .canceledBookingList[
                    index]
                        .totalAmount
                        .toString(),
                    location:bookingController.canceledBookingList[index].barber!.location.toString()=='null'?'': bookingController.canceledBookingList[index].barber!.location.toString(),
                    services: bookingController
                        .canceledBookingList[
                    index]
                        .services!
                        .map((e) =>
                    e.userServices!.first
                        .name ??
                        '')
                        .toList()
                        .join(","),
                  ));
            }),
      ),
    ):Center(
        child: Text(Languages.of(context)!.noCancelledAppointments,style: TextStyle(color: Colors.white),));
  }
}
