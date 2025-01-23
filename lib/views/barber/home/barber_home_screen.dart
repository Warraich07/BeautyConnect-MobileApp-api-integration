import 'package:beauty_connect/constants/custom_dialog.dart';
import 'package:beauty_connect/controllers/auth_controller.dart';
import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/controllers/general_controller.dart';
import 'package:beauty_connect/controllers/timer_controller.dart';
import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:beauty_connect/views/user/appointments/cancel_appointment.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:beauty_connect/views/common/profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../constants/global_variables.dart';
import '../../../guest_mode/utils/custom_dialogbox.dart';
import '../../../guest_mode/widgets/custom_dialog.dart';
import '../../../widgets/barber_card_widget.dart';
import '../../../widgets/custom_widgets.dart';
import '../../common/notification/notifications.dart';
import '../../common/notification/notifications_barber.dart';
import '../../common/profile/settings/edit_profile.dart';
import '../../user/appointments/summary.dart';
import '../appointments/all_cancel_appointments.dart';
import '../appointments/all_upcoming_appointments.dart';
import '../appointments/barber_appointments_screen.dart';

class BarberHomeScreen extends StatefulWidget {
  const BarberHomeScreen({super.key});

  @override
  State<BarberHomeScreen> createState() => _BarberHomeScreenState();
}

class _BarberHomeScreenState extends State<BarberHomeScreen> {
  BookingController bookingController = Get.find();
  AuthController authController = Get.find();
  TimerController timerController=Get.find<TimerController>();
  final GeneralController _generalController = Get.find<GeneralController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(TimerController(), permanent: true);
    bookingController.getBarberSideBookings();
    bookingController.getUnSeenNotifications();
    print(timerController.remainingSeconds.toString()+" remaining seconds");

    // timerController.updateSeconds(timerController.remainingSeconds);

  }
  @override
  Widget build(BuildContext context) {
    return Obx(

      ()=>bookingController.isLoading==false?
      Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          elevation: 5,
          shadowColor: Colors.black12,
          backgroundColor: AppColors.cardColor,
          automaticallyImplyLeading: false,
          title: DelayedDisplay(
            delay: Duration(milliseconds: 200),
            slidingBeginOffset: Offset(0, -1),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // _generalController.onBottomBarTapped(3);
                            // Get.to(()=>Get.to(EditProfile()));
                          },
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                authController.barberData.value!.image!),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Languages.of(context)!.welcome,
                                  style: headingSmall.copyWith(
                                      color: Colors.white)),
                              Text(
                                authController.barberData.value!.name,
                                style: headingLarge.copyWith(fontSize: 17),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      ZoomTapAnimation(
                        onTap: () {
                          Get.to(() => NotificationsBarber(isUser: false),
                              transition: Transition.rightToLeftWithFade);
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                "assets/icons/setting/notifications.png",
                                color: Colors.white,
                                height: 20,
                              ),
                            ),
                            Positioned(
                                right: 0,
                                top: 2,
                                child: Icon(
                                  Icons.circle,
                                  color: bookingController.unSeenNotificationsList.length==0?Colors.grey:AppColors.buttonColor,
                                  size: 7,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  SizedBox(
                    height: 5,
                  ),

                  ///Currently Serving
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        DelayedDisplay(
                          delay: Duration(milliseconds: 500),
                          slidingBeginOffset: Offset(0, -1),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  Languages.of(context)!.currentlyServing,
                                  style: headingLarge.copyWith(fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Obx(
                                      ()=>bookingController.currentlyServingList.isNotEmpty? Row(
                                        children: [
                                          Text(Languages.of(context)!.timeLeft+' :',style: TextStyle(color: AppColors.buttonColor)),
                                          SizedBox(width: 10,),
                                          Text(timerController.time.value,style: TextStyle( color: AppColors.buttonColor),),
                                        ],
                                      ):Container()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        bookingController.currentlyServingList.isNotEmpty
                            ? SizedBox(

                                child: ListView.builder(
                                  shrinkWrap: true,
                                    itemCount: 1,
                                    // bookingController.barberBookingList.value.length,
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {},
                                          child: BarberCardWidget(
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
                                              // timerController.updateSeconds(0);

                                            },
                                            image:bookingController.currentlyServingList[index].getUser==null?Center(child: Text(Languages.of(context)!.guest,style: TextStyle(color: Colors.white),),):
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

                                            ),
                                            // CachedNetworkImage(
                                            //   imageUrl: bookingController.currentlyServingList[index].getUser!.image.toString(),
                                            //   fit: BoxFit.cover,),

                                            // image: bookingController.currentlyServingList.value[index].barber!.image.toString(),
                                            name: bookingController.currentlyServingList[index].getUser==null?
                                            bookingController.currentlyServingList[index].guestUser!.username.toString():
                                            bookingController.currentlyServingList[index].getUser!.name.toString(),
                                            isActive: false,
                                            isServing: true,
                                            onTapCancel: () {
                                              print(bookingController.currentlyServingList[index].services![index].bookingId.toString());
                                              Get.to(() => CancelAppointment(bookingId: bookingController
                                                  .currentlyServingList[index].services![index].bookingId
                                                  .toString(),));

                                            },
                                            onTapStart: () {},
                                            services: bookingController.currentlyServingList[index].services!.map((e){
                                              return  bookingController.languageCode=='en'? e.userServices!.first.name ?? '':bookingController.languageCode=='pt'? e.userServices!.first.portugueseName ?? '':e.userServices!.first.frenchName ?? '';
                                            }).toList().join(","),
                                            barberName: bookingController.currentlyServingList.value[index].barber!.name.toString(),
                                            appointmentCharges: bookingController.currentlyServingList.value[index].totalAmount??'',
                                            startTime: '',
                                            endTime: '', onTap: () {  },
                                            buttonText: '',
                                          ));
                                    }),
                              )
                            : SizedBox(
                                height: 220,
                                child: Column(
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
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),

                  ///Upcoming
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        DelayedDisplay(
                          delay: Duration(milliseconds: 500),
                          slidingBeginOffset: Offset(0, -1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  Languages.of(context)!.yourNextAppointments,
                                  style: headingLarge.copyWith(fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              bookingController.pendingAppointments.isEmpty?Container(): InkWell(
                                onTap: () {
                                  Get.to(()=>AllUpcomingAppointmentsBarber(),);
                                },
                                child: Text(
                                  Languages.of(context)!.seeAll,
                                  style: bodyNormal.copyWith(
                                      fontSize: 12,
                                      color:
                                          AppColors.buttonColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        bookingController.pendingAppointments.isNotEmpty
                            ? Container(
                              // height: 400,
                                child: ListView.builder(
                                  physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: bookingController.pendingAppointments.length>=10?10:bookingController.pendingAppointments.length,
                                    // itemCount: bookingController.pendingAppointments.length>=10?10:bookingController.pendingAppointments.length,
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      DateTime now = DateTime.now();
                                      // Format time as "HH:mm"
                                      String formattedTime = DateFormat('HH:mm').format(now);
                                      return  bookingController.pendingAppointments[index].status.toString()=='pending'? GestureDetector(
                                          child: BarberCardWidget(
                                            // isCancelled: false,
                                            // image: Container(child: Center(child: Text("Guest"),),),
                                            image:bookingController.pendingAppointments[index].getUser==null?Center(child: Text(Languages.of(context)!.guest,style: TextStyle(color: Colors.white),),):CachedNetworkImage(imageUrl: bookingController.pendingAppointments[index].getUser!.image.toString(),
                                              placeholder: (context, url) =>
                                                Center(child: CircularProgressIndicator(
                                                  color: AppColors.buttonColor,

                                                )),
                                              errorWidget: (context, url, error) =>
                                                  Image.asset("assets/img.png"),
                                              fit: BoxFit.cover,),
                                            name: bookingController.pendingAppointments[index].getUser==null?
                                              bookingController.pendingAppointments[index].guestUser!.username.toString():
                                          bookingController.pendingAppointments[index].getUser!.name.toString(),
                                            isActive:true,
                                            isServing: false,
                                            onTapCancel: () {
                                              Get.to(() => CancelAppointment(bookingId: bookingController
                                                  .pendingAppointments[index].services![index].bookingId
                                                  .toString()));
                                            },
                                            onTapStart: () {
                                              print("object");
                                              // Get.to(() => ReviewSummary(
                                              //       isPaid: true,
                                              //     ));
                                            },

                                            services: bookingController.pendingAppointments[index].services!.map((e) {
                                              return  bookingController.languageCode=='en'? e.userServices!.first.name ?? '':bookingController.languageCode=='pt'? e.userServices!.first.portugueseName ?? '':e.userServices!.first.frenchName ?? '';

                                            }).toList().join(","),
                                            barberName: bookingController.pendingAppointments[index].barber!.name.toString(),
                                            appointmentCharges: bookingController.pendingAppointments[index].totalAmount??'',
                                            startTime: bookingController.pendingAppointments[index].startTime??'',
                                            endTime: bookingController.pendingAppointments[index].endTime??'',
                                            onTap: () {
                                              if(bookingController.currentlyServingList.isEmpty){
                                                bookingController.updateTimeDifference(bookingController.pendingAppointments[index].startTime??'', bookingController.pendingAppointments.value[index].endTime??'');
                                                // timerController.updateSeconds(bookingController.differenceInSeconds.value);
                                                // bookingController.currentlyServingList.clear();
                                                // print(bookingController.currentlyServingList.value[index].status);
                                                //   if(bookingController.barberBookingList.isEmpty){
                                                bookingController.startAppointment(bookingController.pendingAppointments[index].id.toString(), 'start',);
                                                // }else{
                                                //   print("not empty");
                                                //
                                                // }
                                              }else{
                                                CustomDialog.showErrorDialog(description: Languages.of(context)!.youCanStartOnlyOneAppointmentAtATime,);
                                                // CustomDialogBox.showErrorDialog(context: context,description: "You can start one appointment at a time");
                                                print("List is not empty");
                                              }
                                          },
                                            buttonText:Languages.of(context)!.start,
                                          )):Container();
                                    }),
                              )
                            : SizedBox(
                                height: 220,
                                child: Column(
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
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),

                  ///Cancelled
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Column(
                  //     children: [
                  //       DelayedDisplay(
                  //         delay: Duration(milliseconds: 500),
                  //         slidingBeginOffset: Offset(0, -1),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 Languages.of(context)!.yourCancelledAppointments,
                  //                 style: headingLarge.copyWith(fontSize: 16),
                  //                 maxLines: 1,
                  //                 overflow: TextOverflow.ellipsis,
                  //               ),
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 Get.to(()=>AllCancelAppointmentsBarber(),);
                  //               },
                  //               child: Text(
                  //                 Languages.of(context)!.seeAll,
                  //                 style: bodyNormal.copyWith(
                  //                     fontSize: 12,
                  //                     color:
                  //                         AppColors.buttonColor.withOpacity(0.5)),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 15,
                  //       ),
                  //       bookingController.cancelledBookingList.isNotEmpty
                  //           ? SizedBox(
                  //         // height: 300,
                  //         child: ListView.builder(
                  //           shrinkWrap: true,
                  //             itemCount: bookingController.cancelledBookingList.length==1?1:2,
                  //             // bookingController.barberBookingList.value.length,
                  //             padding: EdgeInsets.symmetric(horizontal: 4),
                  //             scrollDirection: Axis.vertical,
                  //             itemBuilder: (context, index) {
                  //
                  //               return GestureDetector(
                  //                   onTap: () {},
                  //                   child: BarberCardWidget(
                  //                     appointmentStatusButton: Languages.of(context)!.appointmentsCancelled,
                  //                     image:bookingController.cancelledBookingList[index].getUser==null?Center(child: Text("Guest"),):CachedNetworkImage(imageUrl: bookingController.cancelledBookingList[index].getUser!.image.toString(),fit: BoxFit.cover,),
                  //                     // image: bookingController.cancelledBookingList.value[index].barber!.image.toString(),
                  //                     name:  bookingController.cancelledBookingList[index].getUser==null?
                  //                     bookingController.cancelledBookingList[index].guestUser!.username.toString():
                  //                     bookingController.cancelledBookingList[index].getUser!.name.toString(),
                  //                     isActive: false,
                  //                     isServing: true,
                  //                     onTapCancel: () {
                  //                       Get.to(() => CancelAppointment());
                  //                     },
                  //                     onTapStart: () {},
                  //                     services: bookingController.cancelledBookingList[index].services!.map((e) => e.userServices!.first.name ?? '').toList().join(","),
                  //                     barberName: bookingController
                  //                         .cancelledBookingList
                  //                         [index]
                  //                         .barber!
                  //                         .name
                  //                         .toString(),
                  //                     appointmentCharges: bookingController
                  //                         .cancelledBookingList
                  //                         .value[index]
                  //                         .totalAmount??'', startTime: '', endTime: '', onTap: () {  }, buttonText: '',
                  //                   ));
                  //             }),
                  //       )
                  //           : SizedBox(
                  //               height: 220,
                  //               child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Image.asset(
                  //                     "assets/icons/bottom/appointments.png",
                  //                     scale: 2,
                  //                     color: Colors.black54,
                  //                   ),
                  //                   SizedBox(
                  //                     height: 10,
                  //                   ),
                  //                   Text(
                  //                     Languages.of(context)!.noAppointmentCancelledYet,
                  //                     style: bodySmall.copyWith(
                  //                         color: Colors.black54, fontSize: 13),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //       SizedBox(
                  //         height: 20,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ):Center(
        child: CircularProgressIndicator(
          color: AppColors.buttonColor,

        ),
      ),
    );
  }
  bool isTimeBetween(String startTime, String endTime) {
    DateTime now = DateTime.now();
    // Split startTime and endTime into hours and minutes
    List<String> startParts = startTime.split(':');
    List<String> endParts = endTime.split(':');
    // Construct start and end DateTime objects
    DateTime start = DateTime(now.year, now.month, now.day, int.parse(startParts[0]), int.parse(startParts[1]));
    DateTime end = DateTime(now.year, now.month, now.day, int.parse(endParts[0]), int.parse(endParts[1]));

    // Check if current time is between start and end times
    return now.isAfter(start) && now.isBefore(end);
  }
}


// isActive:formattedTime==bookingController.barberBookingList.value[index].startTime? true:false