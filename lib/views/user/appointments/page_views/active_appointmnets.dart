import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/global_variables.dart';
import '../../../../widgets/card_widget.dart';
import '../../home/add_new_booking.dart';
import '../cancel_appointment.dart';
import '../receipt.dart';

class ActivePageView extends StatefulWidget {
  const ActivePageView({super.key});

  @override
  State<ActivePageView> createState() => _ActivePageViewState();
}

class _ActivePageViewState extends State<ActivePageView> {
  @override
  Widget build(BuildContext context) {
    return bookingController.activeBookingList.isNotEmpty? Padding(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
      child:bookingController.isLoading==true?CircularProgressIndicator(
        color: AppColors.buttonColor,
      ) :Obx(
            ()=> ListView.builder(
          // shrinkWrap: true,
            itemCount: bookingController.activeBookingList.length,
            // physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 4),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {},
                  child: CardWidget(
                    locationImage:bookingController.activeBookingList[index].barber!.location.toString()=='null'?Container(): Image.asset("assets/icons/location_icon.png", scale: 9,color: AppColors.buttonColor,),
                    averageRating: bookingController.activeBookingList[index].averageRating.toString(),
                    showCancelButton: true,
                    appointmentStatus: Languages.of(context)!.cancelAppointments,
                    image: bookingController
                        .activeBookingList[
                    index]
                        .barber!
                        .image
                        .toString(),
                    title: '',
                    name: bookingController
                        .activeBookingList[index]
                        .barber!
                        .name
                        .toString(),
                    location:bookingController.activeBookingList[index].barber!.location.toString()=='null'?'': bookingController
                        .activeBookingList[index]
                        .barber!
                        .location
                        .toString(),
                    services: bookingController
                        .activeBookingList[index]
                        .services!
                        .map((e) =>
                    e.userServices!.first
                        .name ??
                        '')
                        .toList()
                        .join(","),
                    appointmentCharges:
                    bookingController
                        .activeBookingList[
                    index]
                        .totalAmount
                        .toString(),
                    isActive: true,
                    onTapCancel: () {
                      Get.to(
                              () => CancelAppointment(
                            bookingId:
                            bookingController
                                .activeBookingList[
                            index]
                                .id
                                .toString(),
                            bookingIndex: index,
                          ));
                      print(bookingController
                          .activeBookingList[
                      index]
                          .id
                          .toString());
                    },
                    onTapReceipt: () {
                      Get.to(() => ReceiptScreen(
                        isPaid: true,
                        bookingId: bookingController
                            .activeBookingList[
                        index]
                            .id
                            .toString(),
                      ));
                    },
                  ));
            }),
      ),
    ):Center(
      child: Text(Languages.of(context)!.noUpComingAppointments,style: TextStyle(color: Colors.white),),
    );
  }
}
