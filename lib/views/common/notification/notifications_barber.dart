import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/global_variables.dart';
import '../../../widgets/custom_widgets.dart';

class NotificationsBarber extends StatefulWidget {
  final bool isUser;

  const NotificationsBarber({Key? key, this.isUser = false}) : super(key: key);

  @override
  State<NotificationsBarber> createState() => _NotificationsBarberState();
}

class _NotificationsBarberState extends State<NotificationsBarber> {
  BookingController bookingController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingController.updateNotifications();
    bookingController.getAllNotificationsBarber();

  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=>bookingController.isLoading==false? Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.cardColor,
          automaticallyImplyLeading: false,
          title: CustomAppBar(
            pageTitle: Languages.of(context)!.notifications,
            onTapLeading: () {
              bookingController.getUnSeenNotifications();
              Get.back();
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child:bookingController.barberNotificationsList.isNotEmpty? ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: bookingController.barberNotificationsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    String dateTimeString = bookingController.barberNotificationsList[index].createdAt.toString();
                    DateTime dateTime = DateTime.parse(dateTimeString);
                    // print(bookingController.completedAppointmentsNotifications[0].createdAt.toString());
                    String formattedTime = DateFormat('hh:mm a').format(dateTime.toLocal());
                    // String formattedTime = "200";
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Slidable(
                        // closeOnScroll: true,
                        // // Specify a key if the Slidable is dismissible.
                        // key: ValueKey(0),
                        // // The end action pane is the one at the right or the bottom side.
                        // endActionPane: ActionPane(
                        //   // A motion is a widget used to control how the pane animates.
                        //   motion: ScrollMotion(),
                        //
                        //   // A pane can dismiss the Slidable.
                        //   dismissible: DismissiblePane(onDismissed: () {}),
                        //
                        //   // All actions are defined in the children parameter.
                        //   children: [
                        //     // A SlidableAction can have an icon and/or a label.
                        //     SlidableAction(
                        //       backgroundColor: Color(0xFFFE4A49),
                        //       foregroundColor: Colors.white,
                        //       icon: Icons.delete,
                        //       label: 'Delete',
                        //       onPressed: (BuildContext context) {},
                        //     ),
                        //   ],
                        // ),
                        // The child of the Slidable is what the user sees when the
                        // component is not dragged.
                        child: InkWell(
                          onTap: () {},
                          child: DelayedDisplay(
                            delay: const Duration(milliseconds: 300),
                            slidingBeginOffset: const Offset(0, 1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              width: double.infinity,
                              constraints: BoxConstraints(
                                  minHeight: 78, maxHeight: 100
                              ),
                              color: AppColors.cardColor,
                              child: Row(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child:bookingController.barberNotificationsList[index].booking.getUser==null?Image.asset("assets/img.png",height: 50,width: 50,): CachedNetworkImage(
                                        imageUrl: bookingController.barberNotificationsList[index].booking.getUser!.image,
                                        placeholder: (context, url) =>
                                            Center(child: CircularProgressIndicator(
                                              color: AppColors.buttonColor,

                                            )),
                                        errorWidget: (context, url, error) =>
                                            Image.asset("assets/img.png"),
                                        fit: BoxFit.cover,height: 50,width: 50,
                                     )),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: index == 0
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 8,
                                            ),
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxWidth: 72.w, maxHeight: 44),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child:bookingController.barberNotificationsList[index].booking.getUser==null?Text(Languages.of(context)!.guestUserHasBookedAppointment,style: TextStyle(color: Colors.white54),): RichText(
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  text: TextSpan(
                                                    text:bookingController.barberNotificationsList[index].message==Languages.of(context)!.yourAppointmentHasBeenCancelled?'': bookingController.barberNotificationsList[index].booking.getUser!.name,
                                                    style: headingSmall.copyWith(
                                                        color: index == 0 ? Colors
                                                            .white : Colors.white,
                                                        height: 1.2),
                                                    children: <TextSpan>[
                                                      new TextSpan(
                                                        text: bookingController.barberNotificationsList[index].message,
                                                        style: bodyNormal
                                                            .copyWith(
                                                            color: index == 0
                                                                ? Colors.white54
                                                                : Colors.white54,
                                                            fontSize: 13,
                                                            height: 1.2),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // widget.isUser ? Row(
                                        //   mainAxisAlignment:
                                        //   MainAxisAlignment.spaceBetween,
                                        //   crossAxisAlignment: CrossAxisAlignment
                                        //       .end,
                                        //   children: [
                                        //     index == 0 ? Padding(
                                        //       padding: const EdgeInsets.only(
                                        //           left: 8.0),
                                        //       child: SizedBox(
                                        //         width: 57.w,
                                        //         child: Row(
                                        //           mainAxisAlignment:
                                        //           MainAxisAlignment.start,
                                        //           children: [
                                        //             _buttonWidget(
                                        //                 AppColors.buttonColor,
                                        //                 "Confirm Completion",
                                        //                 Colors.white, () {
                                        //               showCustomDialog(
                                        //                   context,
                                        //                   "assets/images/popup/ask.png",
                                        //                   "Are you sure?",
                                        //                   "10 minutes are left in this service. Are you sure that you want to confirm completion of this appointment?",
                                        //                   "Yes, Confirm", () {
                                        //                 Get.off(() =>
                                        //                     ShareFeedback(
                                        //                         image: "assets/images/barber1.png",
                                        //                         title: "Glamour Heaven",
                                        //                         name: "Jane Cooper"));
                                        //               },
                                        //                   null);
                                        //             }),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     )
                                        //         : SizedBox.shrink(),
                                        //     Align(
                                        //         alignment: Alignment.bottomRight,
                                        //         child: Text(
                                        //           model.time,
                                        //           style: bodySmall.copyWith(
                                        //               color: index == 0 ? Colors
                                        //                   .black54 :
                                        //               Colors.black54,
                                        //               height: 1,
                                        //               fontSize: 11),
                                        //         )),
                                        //   ],
                                        // ) :
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .end,
                                            children: [
                                              // index == 0
                                              //     ?
                                              // bookingController.barberNotificationsList[index].type=='Feedback Created'?Container():
                                              // Row(
                                              //   children: [
                                              //     SizedBox(
                                              //       child: _buttonWidget(
                                              //           AppColors.buttonColor,
                                              //           "Confirm",
                                              //           Colors.white, () {
                                              //         showCustomDialog(
                                              //             context,
                                              //             "assets/images/popup/ask.png",
                                              //             "Are you sure?",
                                              //             "10 minutes are left in this service. Are you sure that you want to confirm completion of this appointment?",
                                              //             "Yes, Confirm", () {},
                                              //             null);
                                              //       }),
                                              //     ),
                                              //     SizedBox(width: 5,),
                                              //     SizedBox(
                                              //       child: _buttonWidget(
                                              //           Colors.white,
                                              //           "Cancel",
                                              //           Colors.black, () {
                                              //         showCustomDialog(
                                              //             context,
                                              //             "assets/images/popup/ask.png",
                                              //             "Are you sure?",
                                              //             "10 minutes are left in this service. Are you sure that you want to confirm completion of this appointment?",
                                              //             "Yes, Confirm", () {},
                                              //             null);
                                              //       }),
                                              //     ),
                                              //   ],
                                              // ) ,
                                              //     : index == 1 ? Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       left: 8.0),
                                              //   child: SizedBox(
                                              //     width: 57.w,
                                              //     child: Row(
                                              //       mainAxisAlignment:
                                              //       MainAxisAlignment.start,
                                              //       children: [
                                              //         _buttonWidget(
                                              //             AppColors.buttonColor,
                                              //             "Add Walk-in Customer",
                                              //             Colors.white, () {
                                              //           Get.off(()=> WalkInCustomer());
                                              //         }),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // )
                                                  // : SizedBox.shrink(),
                                              Container(),
                                              Align(
                                                  alignment: Alignment
                                                      .bottomRight,
                                                  child: Text(
                                                    formattedTime,
                                                    style: bodySmall.copyWith(
                                                        color: index == 0 ? Colors
                                                            .white54 :
                                                        Colors.white54,
                                                        height: 1,
                                                        fontSize: 11),
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }):
              Center(child: Text(Languages.of(context)!.notNotificationsYet,style: TextStyle(color: Colors.white54),),)
              ,
            ),
          ],
        ),
      ):Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.buttonColor,

          ),
        ),
      ),
    );
  }

  // _buttonWidget(Color buttonClr, String buttonText, Color textClr,
  //     Function onTap) {
  //   return ZoomTapAnimation(
  //     onTap: () {
  //       onTap();
  //     },
  //     child: Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 14),
  //         height: 40,
  //         decoration: BoxDecoration(
  //           color: buttonClr,
  //           borderRadius: BorderRadius.circular(100),
  //         ),
  //         child: Center(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(buttonText,
  //                   style: headingSmall.copyWith(
  //                     fontSize: 10,
  //                     color: textClr,
  //                   )),
  //             ],
  //           ),
  //         )),
  //   );
  // }

}
