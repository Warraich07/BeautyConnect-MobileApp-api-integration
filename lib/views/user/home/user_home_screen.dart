import 'package:beauty_connect/controllers/auth_controller.dart';
import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/views/user/appointments/all_completed_appointments.dart';
import 'package:beauty_connect/views/user/appointments/all_upcoming_appointments.dart';
import 'package:beauty_connect/views/user/appointments/cancel_appointment.dart';
import 'package:beauty_connect/views/user/appointments/receipt.dart';
import 'package:beauty_connect/views/user/home/user_bottom_nav_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:beauty_connect/views/user/home/add_new_booking.dart';
import 'package:beauty_connect/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../constants/global_variables.dart';
import '../../../controllers/general_controller.dart';
import '../../../guest_mode/utils/custom_dialogbox.dart';
import '../../../guest_mode/views/service_selection.dart';
import '../../../localization/languages/languages.dart';
import '../../../widgets/custom_widgets.dart';
import '../../common/notification/notifications.dart';
import '../appointments/all_cancel_appointments.dart';
import '../appointments/all_instant_bookings.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final GeneralController _generalController = Get.find<GeneralController>();

  // GuestController guestController=Get.find();
  BookingController bookingController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingController.getSelectedBookings();
    bookingController.getGuestAppointment();
    bookingController.getUnSeenNotifications();
    // print(bookingController.unSeenNotificationsList.length.toString);
    // bookingController.getCancelBookingList('cancel');
  }

  List<String> images = [
    "assets/images/barber1.png",
    "assets/images/barber2.png",
    "assets/images/barber3.png",
  ];
  List<String> name = [
    "Jane Cooper",
    "Robert Fox",
    "Michel",
  ];
  List<String> title = [
    "Glamour Heaven",
    "Barber of the year",
    "Fine cuts Hair Salon",
  ];
  AuthController authController = Get.find();
  bool isBooked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      InkWell(
                        onTap: () {
                          _generalController.onBottomBarTapped(2);
                          bookingController.updateNotifications();
                          Get.offAll(()=>UserBottomNavBar(),);
                        },
                        child: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                              authController.userData.value!.image),
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
                              authController.userData.value!.name,
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
                      onTap: () async{
                      await Get.to(() => NotificationsUser(),
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
                          Obx(
                          ()=> Positioned(
                                right: 0,
                                top: 2,
                                child: Icon(
                                  Icons.circle,
                                  color: bookingController.unSeenNotificationsList.length==0?Colors.grey:AppColors.buttonColor,
                                  size: 7,
                                )),
                          )
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
      body: Obx(
        () => CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  SizedBox(
                    height: 5,
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
                                  Languages.of(context)!.yourUpComingAppointments,
                                  style: headingSmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => AllUpcomingAppointments());
                                },
                                child: Text(
                                  Languages.of(context)!.seeAll,
                                  style: bodyNormal.copyWith(
                                      fontSize: 12,
                                      color: AppColors.buttonColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        bookingController.isLoading == true
                            ? SizedBox(
                                height: 20.h,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.buttonColor,
                                  ),
                                ),
                              )
                            : bookingController.selectedBookingList.isNotEmpty
                                ? SizedBox(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                        itemCount: bookingController.selectedBookingList.length==1?1:2,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.symmetric(horizontal: 4),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                              onTap: () {},
                                              child: CardWidget(

                                                locationImage:bookingController.selectedBookingList[index].barber!.location.toString()=='null'?Container(): Image.asset("assets/icons/location_icon.png", scale: 9,color: AppColors.buttonColor,),
                                                averageRating: bookingController.selectedBookingList[index].averageRating.toString(),
                                                showCancelButton: true,
                                                appointmentStatus: Languages.of(context)!.cancelAppointments,
                                                image: bookingController.selectedBookingList[index].barber!.image.toString(),
                                                title: "",
                                                name: bookingController.selectedBookingList[index].barber!.name.toString(),
                                                location: bookingController.selectedBookingList[index].barber!.location.toString()=="null"?"":bookingController.selectedBookingList[index].barber!.location.toString(),
                                                services: bookingController.selectedBookingList[index].services!.map((e){
                                                  return  bookingController.languageCode=='en'? e.userServices!.first.name ?? '':bookingController.languageCode=='pt'? e.userServices!.first.portugueseName ?? '':e.userServices!.first.frenchName ?? '';
                                                }).toList().join(","),
                                                appointmentCharges: bookingController.selectedBookingList[index].totalAmount.toString(),
                                                isActive: true,
                                                onTapCancel: () {
                                                  Get.to(
                                                      () => CancelAppointment(
                                                            bookingId: bookingController.selectedBookingList[index].id.toString(),
                                                            bookingIndex: index,
                                                          ));
                                                  print(bookingController.selectedBookingList[index].id.toString());
                                                },
                                                onTapReceipt: () {
                                                  Get.to(() => ReceiptScreen(
                                                        isPaid: true,
                                                        bookingId: bookingController.selectedBookingList[index].id.toString(),
                                                      ));
                                                },
                                              ));
                                        }),
                                  )
                                : SizedBox(
                                    height: 220,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          Languages.of(context)!.youHaveNotBookedAnyAppointment,
                                          style: bodySmall.copyWith(
                                              color: Colors.white54,
                                              fontSize: 13),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 42.0),
                                          child: CustomButton(
                                            // fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            textClr: AppColors.buttonTextColor,
                                            onTap: () {
                                              Get.to(() => AddNewBooking(
                                                  images: images,
                                                  titles: title,
                                                  pageTitle: Languages.of(context)!.addNewBooking,
                                                  name: name));
                                            },
                                            buttonText: Languages.of(context)!.bookAppointmentNow,
                                          ),
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

                  ///Cancelled
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.black,
                    width: 200,
                    child: Divider(

                      color: Colors.white54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        DelayedDisplay(
                          delay: Duration(milliseconds: 500),
                          slidingBeginOffset: Offset(0, -1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  Languages.of(context)!.yourCanceledAppointments,
                                  style: headingSmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => AllCancelAppointments());
                                },
                                child: Text(
                                  Languages.of(context)!.seeAll,
                                  style: bodyNormal.copyWith(fontSize: 12, color: AppColors.buttonColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        bookingController.canceledBookingList.isNotEmpty
                            ? SizedBox(
                                // height: 50.h,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Image.asset(
                                          //   "assets/icons/bottom/appointments.png",
                                          //   scale: 2,
                                          //   color: Colors.black54,
                                          // ),
                                          // SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Text(
                                          //   Languages.of(context)!
                                          //     .youHaveNotBookedAnyAppointment,
                                          //   style: bodySmall.copyWith(
                                          //       color: Colors.black54,
                                          //       fontSize: 13),
                                          // ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40.0),
                                            child: CustomButton(
                                              textClr: AppColors.buttonTextColor,
                                              onTap: () {
                                                Get.to(() => AddNewBooking(
                                                    images: images,
                                                    titles: title,
                                                    pageTitle:
                                                        Languages.of(context)!
                                                            .addNewBooking,
                                                    name: name));
                                              },
                                              buttonText: Languages.of(context)!
                                                  .bookAppointmentNow,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 72.w,
                                            child: DelayedDisplay(
                                              delay: Duration(milliseconds: 1),
                                              slidingBeginOffset: Offset(0, 1),
                                              child: CustomButton(
                                                textClr: AppColors.buttonTextColor,

                                                buttonText: Languages.of(context)!.instantBooking,
                                                onTap: () {
                                                  // if(bookingController.guestUserList.isEmpty){
                                                    Get.to(() => ServiceSelection(),
                                                        transition: Transition.rightToLeft);
                                                  // }
                                                  //   if(bookingController.guestUserList.isNotEmpty){
                                                  //     CustomDialog.showErrorDialog(description: Languages.of(context)!.youHaveAlreadyBookedAnInstantBooking);
                                                  //   }
                                                },
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(

                                      child: ListView.builder(
                                        physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: bookingController.canceledBookingList.length==1?1:2,
                                          // physics: NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4),
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () {},
                                                child: CardWidget(
                                                    paddingForServices:0,
                                                  reasonOfCancellation: bookingController.canceledBookingList[index].reason.toString()=='null'?"":bookingController.canceledBookingList[index].reason.toString(),
                                                  isCancelled: true,
                                                  locationImage:bookingController.canceledBookingList[index].barber!.location.toString()=='null'||bookingController.canceledBookingList[index].barber!.location.toString().isEmpty?Container(): Image.asset("assets/icons/location_icon.png", scale: 9,color: AppColors.buttonColor,),
                                                  averageRating: bookingController.canceledBookingList[index].averageRating.toString(),
                                                  appointmentStatus: Languages.of(context)!.canceled,
                                                  image: bookingController.canceledBookingList[index].barber!.image.toString(),
                                                  title: "",
                                                  name: bookingController.canceledBookingList[index].barber!.name.toString(),
                                                  isActive: true,
                                                  onTapCancel: () {
                                                    // Get.to(() => CancelAppointment(bookingId: bookingController.selectedBookingList[index].id.toString(),bookingIndex: index,));
                                                    // print(bookingController.selectedBookingList[index].id.toString());
                                                  },
                                                  onTapReceipt: () {
                                                    Get.to(() => ReceiptScreen(
                                                          isPaid: true,
                                                          bookingId: bookingController.canceledBookingList[index].id.toString(),
                                                        ));
                                                  },
                                                  appointmentCharges: bookingController.canceledBookingList[index].totalAmount.toString(),
                                                  location: bookingController.canceledBookingList[index].barber!.location.toString()=='null'?'':bookingController.canceledBookingList[index].barber!.location.toString(),
                                                  services: bookingController.canceledBookingList[index].services!.map((e){
                                                   return  bookingController.languageCode=='en'? e.userServices!.first.name ?? '':bookingController.languageCode=='pt'? e.userServices!.first.portugueseName ?? '':e.userServices!.first.frenchName ?? '';
                                                  }

                                                  ).toList().join(","),
                                                ));
                                          }),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(
                                height: 250,
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
                                      Languages.of(context)!.youHaveNotBookedAnyAppointment,
                                      style: bodySmall.copyWith(color: Colors.white54, fontSize: 13),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 42.0),
                                      child: CustomButton(
                                        textClr: AppColors.buttonTextColor,

                                        onTap: () {
                                          Get.to(() => AddNewBooking(
                                              images: images,
                                              titles: title,
                                              pageTitle: Languages.of(context)!.addNewBooking,
                                              name: name));
                                        },
                                        buttonText: Languages.of(context)!.bookAppointmentNow,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 72.w,
                                      child: DelayedDisplay(
                                        delay: Duration(milliseconds: 1),
                                        slidingBeginOffset: Offset(0, 1),
                                        child: CustomButton(
                                          textClr: AppColors.buttonTextColor,

                                          buttonText: Languages.of(context)!.instantBooking,
                                          onTap: () {
                                            // if(bookingController.guestUserList.isEmpty){
                                              Get.to(() => ServiceSelection(),
                                                  transition: Transition.rightToLeft);
                                            // }if(bookingController.guestUserList.isNotEmpty){
                                            //   CustomDialog.showErrorDialog(description: Languages.of(context)!.youHaveAlreadyBookedAnInstantBooking);
                                            // }
                                          },
                                        ),
                                      ),
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
                  //                 Languages.of(context)!.yourCanceledAppointments,
                  //                 style: headingSmall,
                  //                 maxLines: 1,
                  //                 overflow: TextOverflow.ellipsis,
                  //               ),
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //               },
                  //               child: Text(
                  //                 Languages.of(context)!.seeAll,
                  //                 style: bodyNormal.copyWith(
                  //                     fontSize: 12,
                  //                     color:
                  //                     AppColors.buttonColor.withOpacity(0.5)),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 15,
                  //       ),
                  //       bookingController.selectedBookingList.isNotEmpty
                  //           ? SizedBox(
                  //         // height: 50.h,
                  //         child: Column(
                  //           children: [
                  //             SizedBox(
                  //               height: 250,
                  //               child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   SizedBox(
                  //                     width: 60.w,
                  //                     child: DelayedDisplay(
                  //                       delay: Duration(milliseconds: 800),
                  //                       slidingBeginOffset: Offset(0, 1),
                  //                       child: CustomButton(
                  //                         buttonText: Languages.of(context)!.instantBooking,
                  //                         onTap: () {
                  //                           Get.to(() => ServiceSelection(),
                  //                               transition: Transition.rightToLeft);
                  //                         },
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Image.asset(
                  //                     "assets/icons/bottom/appointments.png",
                  //                     scale: 2,
                  //                     color: Colors.black54,
                  //                   ),
                  //                   SizedBox(
                  //                     height: 10,
                  //                   ),
                  //                   Text(
                  //                     Languages.of(context)!.youHaveNotBookedAnyAppointment,
                  //                     style: bodySmall.copyWith(
                  //                         color: Colors.black54, fontSize: 13),
                  //                   ),
                  //                   SizedBox(
                  //                     height: 10,
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.symmetric(
                  //                         horizontal: 42.0),
                  //                     child: CustomButton(
                  //                       onTap: () {
                  //                         Get.to(() => AddNewBooking(
                  //                             images: images,
                  //                             titles: title,
                  //                             pageTitle:Languages.of(context)!.addNewBooking,
                  //                             name: name
                  //                         ));
                  //                       },
                  //                       buttonText: Languages.of(context)!.bookAppointmentNow,
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               height: 50.h,
                  //               child: ListView.builder(
                  //                   shrinkWrap: true,
                  //                   itemCount: bookingController.selectedBookingList.length,
                  //                   // physics: NeverScrollableScrollPhysics(),
                  //                   padding: EdgeInsets.symmetric(horizontal: 4),
                  //                   scrollDirection: Axis.vertical,
                  //                   itemBuilder: (context, index) {
                  //                     return bookingController.selectedBookingList[index].status=='cancel'? GestureDetector(
                  //                         onTap: () {},
                  //                         child: CardWidget(
                  //
                  //                           appointmentStatus: Languages.of(context)!.canceled,
                  //                           image: bookingController.selectedBookingList[index].barber!.image.toString(),
                  //                           title: "",
                  //                           name: bookingController.selectedBookingList[index].barber!.name.toString(),
                  //                           isActive: true,
                  //                           onTapCancel: () {
                  //                             // Get.to(() => CancelAppointment(bookingId: bookingController.selectedBookingList[index].id.toString(),bookingIndex: index,));
                  //                             // print(bookingController.selectedBookingList[index].id.toString());
                  //                           },
                  //
                  //                           onTapReceipt: (){ Get.to(()=> ReceiptScreen(isPaid: true,bookingId: bookingController.selectedBookingList[index].id.toString(),));},
                  //                           appointmentCharges: bookingController.selectedBookingList[index].totalAmount.toString(),
                  //                           location: bookingController.selectedBookingList[index].barber!.location.toString(),
                  //                           services: bookingController.selectedBookingList[index].services!.map((e)=>e.userServices!.first.name??'').toList().join(","),
                  //                         )):Container();
                  //                   }),
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //           : SizedBox(
                  //         height: 250,
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Image.asset(
                  //               "assets/icons/bottom/appointments.png",
                  //               scale: 2,
                  //               color: Colors.black54,
                  //             ),
                  //             SizedBox(
                  //               height: 10,
                  //             ),
                  //             Text(
                  //               Languages.of(context)!.youHaveNotBookedAnyAppointment,
                  //               style: bodySmall.copyWith(
                  //                   color: Colors.black54, fontSize: 13),
                  //             ),
                  //             SizedBox(
                  //               height: 10,
                  //             ),
                  //
                  //             Padding(
                  //               padding: const EdgeInsets.symmetric(
                  //                   horizontal: 42.0),
                  //               child: CustomButton(
                  //                 onTap: () {
                  //                   Get.to(() => AddNewBooking(
                  //                       images: images,
                  //                       titles: title,
                  //                       pageTitle: Languages.of(context)!.addNewBooking,
                  //                       name: name
                  //                   ));
                  //                 },
                  //                 buttonText: Languages.of(context)!.bookAppointmentNow,
                  //               ),
                  //             ),
                  //
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 20,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  bookingController.isLoading.value==false?  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        DelayedDisplay(
                          delay: Duration(milliseconds: 500),
                          slidingBeginOffset: Offset(0, -1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  Languages.of(context)!.bookInQueue,
                                  style: headingSmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     Get.to(() => AllInstantAppointments());
                              //   },
                              //   child: Text(
                              //     Languages.of(context)!.seeAll,
                              //     style: bodyNormal.copyWith(
                              //         fontSize: 12,
                              //         color: AppColors.buttonColor
                              //             .withOpacity(0.5)),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Obx(
                          () => bookingController.isLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.buttonColor,
                                  ),
                                )
                              : bookingController.guestUserList.isEmpty
                                  ? SizedBox()
                                  : SizedBox(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: 1,
                                          physics: NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4),
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  Get.to(() => AllInstantAppointments());
                                                },
                                                child: CardWidget(
                                                  locationImage:Container(),

                                                  averageRating: bookingController.guestUserList[index].barber.averageRating.toString(),

                                                  appointmentStatus: Languages.of(context)!.canceled,
                                                  image: bookingController.guestUserList[index].barber.image.toString(),
                                                  title: "",
                                                  name: bookingController.guestUserList[index].barber.name.toString(),
                                                  isActive: true,
                                                  onTapCancel: () {
                                                    // Get.to(() => CancelAppointment(bookingId: bookingController.selectedBookingList[index].id.toString(),bookingIndex: index,));
                                                    // print(bookingController.selectedBookingList[index].id.toString());
                                                  },
                                                  onTapReceipt: () {
                                                    Get.to(() => ReceiptScreen(
                                                          isPaid: true,
                                                          bookingId: bookingController.guestUserList[index].id.toString(),
                                                        ));
                                                  },
                                                  appointmentCharges: bookingController.guestUserList[index].totalAmount.toString(),
                                                  location: bookingController.guestUserList[index].barber.location.toString()=='null'?'' :bookingController.guestUserList[index].barber.location.toString(),
                                                  services: bookingController.guestUserList[index].services.map((e) {
                                                    return  bookingController.languageCode=='en'? e.userServices.first.name :bookingController.languageCode=='pt'? e.userServices.first.portugueseName :e.userServices.first.frenchName;
                                                  }).toList().join(","),
                                                ));
                                          }),
                                    ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DelayedDisplay(
                          delay: Duration(milliseconds: 500),
                          slidingBeginOffset: Offset(0, -1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  Languages.of(context)!.completedAppointments,
                                  style: headingSmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => AllCompletedAppointments());
                                },
                                child: Text(
                                  Languages.of(context)!.seeAll,
                                  style: bodyNormal.copyWith(
                                      fontSize: 12,
                                      color: AppColors.buttonColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        bookingController.isLoading == true
                            ? SizedBox(
                          height: 20.h,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.buttonColor,
                            ),
                          ),
                        )
                            : bookingController.completedBookingList.isNotEmpty
                            ? SizedBox(

                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: bookingController.completedBookingList.length==1?1:2,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return  GestureDetector(
                                    onTap: () {},
                                    child: CardWidget(
                                      locationImage:bookingController.completedBookingList[index].barber!.location.toString()=='null'?Container(): Image.asset("assets/icons/location_icon.png", scale: 9,color: AppColors.buttonColor,),
                                      averageRating: bookingController.completedBookingList[index].averageRating.toString(),
                                      showCancelButton: false,
                                      appointmentStatus: Languages.of(context)!.completedAppointments,
                                      image: bookingController.completedBookingList[index].barber!.image.toString() ,
                                      title: "",
                                      name: bookingController.completedBookingList[index].barber!.name.toString(),
                                      location: bookingController.completedBookingList[index].barber!.location.toString(),
                                      services: bookingController.completedBookingList[index].services!.map((e) {
                                        return  bookingController.languageCode=='en'? e.userServices!.first.name ?? '':bookingController.languageCode=='pt'? e.userServices!.first.portugueseName ?? '':e.userServices!.first.frenchName ?? '';
                                      }).toList().join(","),
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
                        )
                            : SizedBox(
                          height: 220,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
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
                                Languages.of(context)!.noCompletedAppointments,
                                style: bodySmall.copyWith(
                                    color: Colors.white54,
                                    fontSize: 13),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                            ],
                          ),
                        ),
                        // bookingController.selectedBookingList.isNotEmpty
                        //     ? SizedBox(
                        //   // height: 50.h,
                        //   child: Column(
                        //     children: [
                        //       SizedBox(
                        //         // height: 250,
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //
                        //
                        //             SizedBox(
                        //               height: 10,
                        //             ),
                        //
                        //           ],
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         height: 50.h,
                        //         child: ListView.builder(
                        //             shrinkWrap: true,
                        //             itemCount: bookingController.selectedBookingList.length,
                        //             // physics: NeverScrollableScrollPhysics(),
                        //             padding: EdgeInsets.symmetric(horizontal: 4),
                        //             scrollDirection: Axis.vertical,
                        //             itemBuilder: (context, index) {
                        //               return bookingController.selectedBookingList[index].status=='cancel'? GestureDetector(
                        //                   onTap: () {},
                        //                   child: CardWidget(
                        //
                        //                     appointmentStatus: Languages.of(context)!.canceled,
                        //                     image: bookingController.selectedBookingList[index].barber!.image.toString(),
                        //                     title: "",
                        //                     name: bookingController.selectedBookingList[index].barber!.name.toString(),
                        //                     isActive: true,
                        //                     onTapCancel: () {
                        //                       // Get.to(() => CancelAppointment(bookingId: bookingController.selectedBookingList[index].id.toString(),bookingIndex: index,));
                        //                       // print(bookingController.selectedBookingList[index].id.toString());
                        //                     },
                        //
                        //                     onTapReceipt: (){ Get.to(()=> ReceiptScreen(isPaid: true,bookingId: bookingController.selectedBookingList[index].id.toString(),));},
                        //                     appointmentCharges: bookingController.selectedBookingList[index].totalAmount.toString(),
                        //                     location: bookingController.selectedBookingList[index].barber!.location.toString(),
                        //                     services: bookingController.selectedBookingList[index].services!.map((e)=>e.userServices!.first.name??'').toList().join(","),
                        //                   )):Container();
                        //             }),
                        //       ),
                        //     ],
                        //   ),
                        // )
                        //     : Container(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ):Container(
                      height: MediaQuery.sizeOf(context).height*.30,
                      child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.buttonColor,
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
