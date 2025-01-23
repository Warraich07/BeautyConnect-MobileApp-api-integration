import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/global_variables.dart';
import '../../../../widgets/barber_card_widget.dart';
import '../../../../widgets/barber_status_card_widget.dart';
import '../../../../widgets/card_widget.dart';
import '../../../user/appointments/cancel_appointment.dart';
import '../../../user/home/add_new_booking.dart';

class CompletedPageViewBarber extends StatefulWidget {
  const CompletedPageViewBarber({super.key});

  @override
  State<CompletedPageViewBarber> createState() => _CompletedPageViewBarberState();
}

class _CompletedPageViewBarberState extends State<CompletedPageViewBarber> {
  @override
  Widget build(BuildContext context) {
    return bookingController.barberCompletedBookingList.isNotEmpty
        ? ListView.builder(
        shrinkWrap: true,
        itemCount: bookingController.barberCompletedBookingList.length,
        // bookingController.barberBookingList.value.length,
        padding: EdgeInsets.symmetric(
            horizontal: 4,vertical: 15),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {

          return GestureDetector(
              onTap: () {},
              child: BarberStatusCardWidget(
                  status:Languages.of(context)!.completed,
                // appointmentStatusButton: "Appointment Completed",
                image:bookingController.barberCompletedBookingList[index].getUser==null?Center(child: Text(Languages.of(context)!.guest,style: TextStyle(color: Colors.white)),):
                CachedNetworkImage(
                  imageUrl:bookingController.barberCompletedBookingList[index].getUser!.image.toString(),
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.buttonColor,

                      )),
                  errorWidget: (context, url,
                      error) =>
                      Image.asset(
                          "assets/img.png"),
                  fit: BoxFit.cover,

                )
                // CachedNetworkImage(
                //   imageUrl: bookingController.barberCompletedBookingList[index].getUser!.image.toString(),
                //   fit: BoxFit.cover,)
                ,


                // image: bookingController.barberCompletedBookingList.value[index].barber!.image.toString(),
                name:  bookingController.barberCompletedBookingList[index].getUser==null?
                bookingController.barberCompletedBookingList[index].guestUser!.username.toString():
                bookingController.barberCompletedBookingList[index].getUser!.name.toString(),
                services: bookingController.barberCompletedBookingList[index].services!.map((e){return  bookingController.languageCode=='en'? e.userServices!.first.name ?? '':bookingController.languageCode=='pt'? e.userServices!.first.portugueseName ?? '':e.userServices!.first.frenchName ?? '';}).toList().join(","),
                isActive: false,
                isServing: true,
                onTapCancel: () {
                  Get.to(() => CancelAppointment());
                },
                onTapStart: () {},
                barberName: bookingController.barberCompletedBookingList.value[index].barber!.name.toString(),
                appointmentCharges: bookingController.barberCompletedBookingList.value[index].totalAmount??'', startTime: '', endTime: '', onTap: () {  }, buttonText: '',
              ));
        })
        : Center(
      child: Text(
        Languages.of(context)!.noCompletedAppointments,
        style: bodySmall.copyWith(
            color: Colors.white54, fontSize: 13),
      ),
    );
  }
}
