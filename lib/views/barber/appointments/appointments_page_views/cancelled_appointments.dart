import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../constants/global_variables.dart';
import '../../../../localization/languages/languages.dart';
import '../../../../widgets/barber_card_widget.dart';
import '../../../../widgets/barber_status_card_widget.dart';
import '../../../../widgets/card_widget.dart';
import '../../../user/appointments/cancel_appointment.dart';
import '../../../user/home/add_new_booking.dart';

class CancelledPageViewBarber extends StatefulWidget {
  const CancelledPageViewBarber({super.key});

  @override
  State<CancelledPageViewBarber> createState() => _CancelledPageViewBarberState();
}

class _CancelledPageViewBarberState extends State<CancelledPageViewBarber> {
  @override
  Widget build(BuildContext context) {
    return bookingController.cancelledBookingList.isNotEmpty
        ? ListView.builder(

        itemCount: bookingController.cancelledBookingList.length,
        // bookingController.barberBookingList.value.length,
        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 15),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          DateTime dateTime = DateTime.parse(bookingController.cancelledBookingList[index].createdAt.toString());
          String formattedDate = DateFormat('MMMM dd, yyyy - hh:mm a').format(dateTime);
          return GestureDetector(
              onTap: () {},
              child: BarberStatusCardWidget(
                scheduledTime: formattedDate,
                scheduledTimeText: 'Scheduled At',
                isCancelled: true,
                status:Languages.of(context)!.cancelled,
                appointmentStatusButton: Languages.of(context)!.appointmentsCancelled,
                image:bookingController.cancelledBookingList[index].getUser==null?Center(child: Text("Guest",style: TextStyle(color: Colors.white),),):
                CachedNetworkImage(
                  imageUrl:bookingController.cancelledBookingList[index].getUser!.image.toString(),
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
                //   imageUrl: bookingController.cancelledBookingList[index].getUser!.image.toString(),
                //   fit: BoxFit.cover,)
                ,
                // image: bookingController.cancelledBookingList.value[index].barber!.image.toString(),
                name:  bookingController.cancelledBookingList[index].getUser==null?
                bookingController.cancelledBookingList[index].guestUser!.username.toString():
                bookingController.cancelledBookingList[index].getUser!.name.toString(),
                services: bookingController.cancelledBookingList[index].services!.map((e){
                  return  bookingController.languageCode=='en'? e.userServices!.first.name ?? '':bookingController.languageCode=='pt'? e.userServices!.first.portugueseName ?? '':e.userServices!.first.frenchName ?? '';
                }).toList().join(","),
                reasonOfCacellation: bookingController.cancelledBookingList[index].reason,
                isActive: false,
                isServing: true,
                onTapCancel: () {
                  Get.to(() => CancelAppointment());
                },
                onTapStart: () {},
                barberName: bookingController
                    .cancelledBookingList
                [index]
                    .barber!
                    .name
                    .toString(),
                appointmentCharges: bookingController
                    .cancelledBookingList
                    .value[index]
                    .totalAmount??'', startTime: '', endTime: '', onTap: () {  }, buttonText: '',
              ));
        })
        : Center(
      child: Text(
        Languages.of(context)!.noAppointmentCancelledYet,
        style: bodySmall.copyWith(
            color: Colors.white54, fontSize: 13),
      ),
    );
  }
}
