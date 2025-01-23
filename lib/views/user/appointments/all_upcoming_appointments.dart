import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/views/user/appointments/receipt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../localization/languages/languages.dart';
import '../../../widgets/card_widget.dart';
import '../../../widgets/custom_widgets.dart';
import 'cancel_appointment.dart';

class AllUpcomingAppointments extends StatefulWidget {
  const AllUpcomingAppointments({super.key});

  @override
  State<AllUpcomingAppointments> createState() => _AllUpcomingAppointmentsState();
}

class _AllUpcomingAppointmentsState extends State<AllUpcomingAppointments> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingController.getSelectedBookings();
  }
  BookingController bookingController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cardColor,
        title: CustomAppBar(
            pageTitle: Languages.of(context)!.allAppointments,
            onTapLeading: () {
              Get.back();
            },
          ),
      ),
      body: bookingController.selectedBookingList.isNotEmpty? Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
        child:bookingController.isLoading==true?CircularProgressIndicator(
          color: AppColors.buttonColor,
        ) :Obx(
            ()=> ListView.builder(
                // shrinkWrap: true,
                itemCount: bookingController.selectedBookingList.length,
                // physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 4),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {},
                      child: CardWidget(
                        // averageRating: ,
                        locationImage:bookingController.selectedBookingList[index].barber!.location.toString()=='null'?Container(): Image.asset("assets/icons/location_icon.png", scale: 9,color: AppColors.buttonColor,),

                        showCancelButton: true,
                        appointmentStatus: Languages.of(context)!.cancelAppointments,
                        image: bookingController
                            .selectedBookingList[
                        index]
                            .barber!
                            .image
                            .toString() ??
                            '',
                        title: "",
                        name: bookingController
                            .selectedBookingList[index]
                            .barber!
                            .name
                            .toString(),
                        location:bookingController.selectedBookingList[index].barber!.location.toString()=='null'?'': bookingController
                            .selectedBookingList[index]
                            .barber!
                            .location
                            .toString(),
                        services: bookingController
                            .selectedBookingList[index]
                            .services!
                            .map((e) {
                          return  bookingController.languageCode=='en'? e.userServices!.first.name ?? '':bookingController.languageCode=='pt'? e.userServices!.first.portugueseName ?? '':e.userServices!.first.frenchName ?? '';
                        })
                            .toList()
                            .join(","),
                        appointmentCharges:
                        bookingController
                            .selectedBookingList[
                        index]
                            .totalAmount
                            .toString(),
                        isActive: true,
                        onTapCancel: () {
                          Get.to(
                                  () => CancelAppointment(
                                bookingId:
                                bookingController
                                    .selectedBookingList[
                                index]
                                    .id
                                    .toString(),
                                bookingIndex: index,
                              ));
                          print(bookingController
                              .selectedBookingList[index]
                              .id
                              .toString());
                        },
                        onTapReceipt: () {
                          Get.to(() => ReceiptScreen(
                            isPaid: true,
                            bookingId: bookingController
                                .selectedBookingList[
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
      ),
    );
  }
}
