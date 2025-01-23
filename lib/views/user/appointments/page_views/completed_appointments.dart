import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/global_variables.dart';
import '../../../../widgets/card_widget.dart';
import '../../home/add_new_booking.dart';
import '../receipt.dart';

class CompletedPageView extends StatefulWidget {
  const CompletedPageView({super.key});

  @override
  State<CompletedPageView> createState() => _CompletedPageViewState();
}

class _CompletedPageViewState extends State<CompletedPageView> {
  @override
  Widget build(BuildContext context) {
    return bookingController.completedBookingList.isNotEmpty? Padding(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
      child:bookingController.isLoading==true?CircularProgressIndicator(
        color: AppColors.buttonColor,
      ) :Obx(
            ()=> ListView.builder(
          // shrinkWrap: true,
            itemCount: bookingController.completedBookingList.length,
            // physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 4),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return  GestureDetector(
                  onTap: () {},
                  child: CardWidget(
                    averageRating: bookingController.completedBookingList[index].averageRating.toString(),
                    locationImage:bookingController.completedBookingList[index].barber!.location.toString()=='null'?Container(): Image.asset("assets/icons/location_icon.png", scale: 9,color: AppColors.buttonColor,),
                    showCancelButton: false,
                    appointmentStatus: Languages.of(context)!.completedAppointments,
                    image: bookingController.completedBookingList[index].barber!.image.toString(),
                    title: "",
                    name: bookingController.completedBookingList[index].barber!.name.toString(),
                    location:bookingController.completedBookingList[index].barber!.location.toString()=='null'?'': bookingController.completedBookingList[index].barber!.location.toString(),
                    services: bookingController.completedBookingList[index].services!.map((e) => e.userServices!.first.name ?? '').toList().join(","),
                    appointmentCharges: bookingController.completedBookingList[index].totalAmount.toString(),
                    isActive: true,
                    onTapCancel: () {
                      // Get.to(
                      //         () => CancelAppointment(
                      //       bookingId: bookingController.completedBookingList[index].id.toString(),
                      //       bookingIndex: index,
                      //     ));
                      // print(bookingController.completedBookingList[index].id.toString());
                    },
                    onTapReceipt: () {
                      Get.to(() => ReceiptScreen(
                        isPaid: true,
                        bookingId: bookingController.completedBookingList[index].id.toString(),
                      ));
                    },
                  ));
            }),
      ),
    ):Center(
      child: Text(Languages.of(context)!.noCompletedAppointments,style: TextStyle(color: Colors.white),),
    );
  }
}
