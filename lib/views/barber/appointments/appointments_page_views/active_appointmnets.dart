import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/global_variables.dart';
import '../../../../controllers/timer_controller.dart';
import '../../../../guest_mode/widgets/custom_dialog.dart';
import '../../../../widgets/barber_card_widget.dart';
import '../../../../widgets/card_widget.dart';
import '../../../user/appointments/cancel_appointment.dart';
import '../../../user/home/add_new_booking.dart';


class ActivePageViewBarber extends StatefulWidget {
  const ActivePageViewBarber({super.key});

  @override
  State<ActivePageViewBarber> createState() => _ActivePageViewBarberState();
}

class _ActivePageViewBarberState extends State<ActivePageViewBarber> {
  TimerController timerController=Get.find<TimerController>();

  @override
  Widget build(BuildContext context) {
    return bookingController.currentlyServingList.isNotEmpty
        ? SizedBox(
      height: 300,
      child: Obx(
          ()=>bookingController.isLoading==false&& bookingController.currentlyServingList.isNotEmpty? ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            // bookingController.barberBookingList.value.length,
              padding: EdgeInsets.symmetric(horizontal: 4,vertical: 15),            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {},
                  child: BarberCardWidget(

                    showAppointmentTime: true,
                    timeLeft: bookingController.timeMinutesSeconds.value,
                    onTapComplete: (){
                      showCustomDialog(context, "assets/images/popup/ask.png", Languages.of(context)!.areYouSure, Languages.of(context)!.areYouSureYouWantToConfirmCompletionOfThisAppointment,Languages.of(context)!.yesComplete,
                              (){
                            bookingController.startAppointment(bookingController.currentlyServingList.value[index].id.toString(), 'complete');
                            timerController.updateSeconds(0);
                            timerController.stopTimer();
                            print("ok");
                            // Get.offAll(()=> BarberBottomNavBar());
                          }, null);
                      // timerController.onClose();
                      // bookingController.startAppointment(bookingController.currentlyServingList.value[index].id.toString(), 'complete');
                      // timerController.stopTimer();
                    },
                    image:bookingController.currentlyServingList[index].getUser==null?Center(child: Text("Guest",style: TextStyle(color: Colors.white),),):
                    CachedNetworkImage(
                      imageUrl:bookingController.currentlyServingList[index].getUser!.image.toString(),
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
                    //   imageUrl: bookingController.currentlyServingList[index].getUser!.image.toString(),
                    //   fit: BoxFit.cover,)
                    ,

                    // image: bookingController.currentlyServingList.value[index].barber!.image.toString(),
                    name: bookingController.currentlyServingList[index].getUser==null?
                    bookingController.currentlyServingList[index].guestUser!.username.toString():
                    bookingController.currentlyServingList[index].getUser!.name.toString(),
                    isActive: false,
                    isServing: true,
                    onTapCancel: () {
                      Get.to(() => CancelAppointment());
                    },
                    onTapStart: () {},
                    services: bookingController.currentlyServingList[index].services!.map((e){
                      return  bookingController.languageCode=='en'? e.userServices!.first.name ?? '':bookingController.languageCode=='pt'? e.userServices!.first.portugueseName ?? '':e.userServices!.first.frenchName ?? '';
                    }).toList().join(","),
                    barberName: bookingController.currentlyServingList.value[index].barber!.name.toString(),
                    appointmentCharges: bookingController.currentlyServingList.value[index].totalAmount??'',
                    startTime: bookingController.currentlyServingList[index].startTime??'',
                    endTime: bookingController.currentlyServingList[index].endTime??'',
                    onTap: () {  },
                    buttonText: '',
                  ));
            }):Center(
            child: Text("Appointment Completed"),
          ),
      )
    )
        : Center(
      child: Text(
        Languages.of(context)!.noAppointmentBookedYet,
        style: bodySmall.copyWith(
            color: Colors.white54, fontSize: 13),
      ),
    );
  }
}
