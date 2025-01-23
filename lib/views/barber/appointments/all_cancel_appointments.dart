import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/views/user/appointments/receipt.dart';
import 'package:beauty_connect/views/user/appointments/summary.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../localization/languages/languages.dart';
import '../../../widgets/barber_card_widget.dart';
import '../../../widgets/card_widget.dart';
import '../../../widgets/custom_widgets.dart';
import '../../user/appointments/cancel_appointment.dart';


class AllCancelAppointmentsBarber extends StatefulWidget {
   AllCancelAppointmentsBarber({super.key});

  @override
  State<AllCancelAppointmentsBarber> createState() => _AllCancelAppointmentsBarberState();
}

class _AllCancelAppointmentsBarberState extends State<AllCancelAppointmentsBarber> {
  BookingController bookingController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingController.getSelectedBookings();
  }
  @override
  Widget build(BuildContext context) {
    return bookingController.cancelledBookingList.isNotEmpty
        ? Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        title: Text(Languages.of(context)!.cancelledAppointments),
      ),
      backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.all(10),
                // height: 300,
                child:  ListView.builder(
                  shrinkWrap: true,
            itemCount: bookingController.cancelledBookingList.length,
            // bookingController.barberBookingList.value.length,
            padding: EdgeInsets.symmetric(horizontal: 4),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {

              return GestureDetector(
                  onTap: () {},
                  child: BarberCardWidget(
                    appointmentStatusButton: Languages.of(context)!.appointmentsCancelled,
                    image:bookingController.cancelledBookingList[index].getUser==null?Center(child: Text(Languages.of(context)!.guest,style: TextStyle(color: Colors.white),),):CachedNetworkImage(imageUrl: bookingController.cancelledBookingList[index].getUser!.image.toString(),fit: BoxFit.cover,),
                    // image: bookingController.cancelledBookingList.value[index].barber!.image.toString(),
                    name:  bookingController.cancelledBookingList[index].getUser==null?
                    bookingController.cancelledBookingList[index].guestUser!.username.toString():
                    bookingController.cancelledBookingList[index].getUser!.name.toString(),
                    isActive: false,
                    isServing: true,
                    onTapCancel: () {
                      Get.to(() => CancelAppointment());
                    },
                    onTapStart: () {},
                    services: bookingController.cancelledBookingList[index].services!.map((e) => e.userServices!.first.name ?? '').toList().join(","),
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
            }),
              ),
        )
        : SizedBox(
      height: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/bottom/appointments.png",
            scale: 2,
            color: Colors.black54,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            Languages.of(context)!.noAppointmentCancelledYet,
            style: bodySmall.copyWith(
                color: Colors.black54, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
