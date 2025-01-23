import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/controllers/timer_controller.dart';
import 'package:beauty_connect/views/user/appointments/receipt.dart';
import 'package:beauty_connect/views/user/appointments/summary.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../localization/languages/languages.dart';
import '../../../widgets/barber_card_widget.dart';
import '../../../widgets/card_widget.dart';
import '../../../widgets/custom_widgets.dart';
import '../../user/appointments/cancel_appointment.dart';

class AllUpcomingAppointmentsBarber extends StatefulWidget {
  const AllUpcomingAppointmentsBarber({super.key});

  @override
  State<AllUpcomingAppointmentsBarber> createState() => _AllUpcomingAppointmentsBarberState();
}

class _AllUpcomingAppointmentsBarberState extends State<AllUpcomingAppointmentsBarber> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingController.getSelectedBookings();
  }
  BookingController bookingController=Get.find();
  TimerController timerController=Get.find();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(

        title: Text(Languages.of(context)!.upcomingAppointments,style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.cardColor,
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
      ),

          body:bookingController.barberBookingList.isEmpty
              ?Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/bottom/appointments.png",
                scale: 2,
                color: Colors.white54,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                Languages.of(context)!.noAppointmentBookedYet,
                style: bodySmall.copyWith(
                    color: Colors.white54, fontSize: 13),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 42.0),
                child: Container(),
              )
            ],
          ): Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
                  child:bookingController.pendingAppointments.isEmpty?Center(
                    child: Text(Languages.of(context)!.noUpComingAppointments,style: TextStyle(color: AppColors.whiteColor),),
                  ): ListView.builder(
              shrinkWrap: true,
              itemCount: bookingController.barberBookingList.length,
              padding: EdgeInsets.symmetric(horizontal: 4),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DateTime now = DateTime.now();

                // Format time as "HH:mm"
                String formattedTime = DateFormat('HH:mm').format(now);
                return  bookingController.barberBookingList[index].status.toString()=='pending'? GestureDetector(
                    child: BarberCardWidget(
                      // isCancelled: false,
                      // image: Container(child: Center(child: Text("Guest"),),),
                      image:bookingController.barberBookingList[index].getUser==null?Center(child: Text("Guest"),):CachedNetworkImage(imageUrl: bookingController.barberBookingList[index].getUser!.image.toString(),fit: BoxFit.cover,),
                      name: bookingController.barberBookingList[index].getUser==null?
                      bookingController.barberBookingList[index].guestUser!.username.toString():
                      bookingController.barberBookingList[index].getUser!.name.toString(),
                      isActive:true,
                      isServing: false,
                      onTapCancel: () {
                        Get.to(() => CancelAppointment(appointmentId : bookingController.barberBookingList.value[index].id,));
                        print(bookingController.barberBookingList[index].id);
                      },
                      onTapStart: () {
                        print("object");
                        // Get.to(() => ReviewSummary(
                        //       isPaid: true,
                        //     ));
                      },
                      services: bookingController.barberBookingList[index].services!.map((e){
                        return  bookingController.languageCode=='en'? e.userServices!.first.name ?? '':bookingController.languageCode=='pt'? e.userServices!.first.portugueseName ?? '':e.userServices!.first.frenchName ?? '';
                      }).toList().join(","),
                      barberName: bookingController.barberBookingList[index].barber!.name.toString(),
                      appointmentCharges: bookingController.barberBookingList[index].totalAmount??'',
                      startTime: bookingController.barberBookingList[index].startTime??'',
                      endTime: bookingController.barberBookingList[index].endTime??'',
                      onTap: () {
                        if(bookingController.currentlyServingList.isEmpty){
                          bookingController.updateTimeDifference(bookingController.barberBookingList[index].startTime??'', bookingController.barberBookingList.value[index].endTime??'');
                          timerController.updateSeconds(bookingController.differenceInSeconds.value);
                          // bookingController.currentlyServingList.clear();
                          // print(bookingController.currentlyServingList.value[index].status);
                          //   if(bookingController.barberBookingList.isEmpty){
                          bookingController.startAppointment(bookingController.barberBookingList[index].id.toString(), 'start',);
                          // }else{
                          //   print("not empty");
                          //
                          // }
                        }else{
                          print("List is not empty");
                        }
                      },
                      buttonText:Languages.of(context)!.start,
                    )):Container();
              }),
                ),
          ),
        );

  }
}
