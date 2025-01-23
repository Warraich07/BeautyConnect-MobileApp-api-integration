import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:beauty_connect/views/user/home/share_feedback.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../constants/global_variables.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/custom_widgets.dart';

class NotificationsUser extends StatefulWidget {
  final bool isUser;

  const NotificationsUser({Key? key, this.isUser = true}) : super(key: key);

  @override
  State<NotificationsUser> createState() => _NotificationsUserState();
}

class _NotificationsUserState extends State<NotificationsUser> {
  BookingController bookingController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingController.updateNotifications();
    bookingController.getAllNotificationsUser();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=>bookingController.isLoading==false? Scaffold(
        backgroundColor: Colors.black,
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
              child:bookingController.completedAppointmentsNotifications.isNotEmpty? ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: bookingController.completedAppointmentsNotifications.length,
                  itemBuilder: (BuildContext context, int index) {

                    String dateTimeString = bookingController.completedAppointmentsNotifications[index].createdAt.toString();
                    DateTime dateTime = DateTime.parse(dateTimeString);
                    String formattedTime = DateFormat('hh:mm a').format(dateTime.toLocal());
                    print(formattedTime); // Output: 06:27 PM

                    // NotificationsModel model = widget.isUser == true
                    //     ? notificationsUser[index]
                    //     : notificationsBarber[index];
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
                              color: bookingController.completedAppointmentsNotifications[index].isFeedback.toString()=='1'|| bookingController.completedAppointmentsNotifications[index].message.toString()=="Appointment created successfully." || bookingController.completedAppointmentsNotifications[index].booking.status=='cancel'||bookingController.completedAppointmentsNotifications[index].type.toString()=='Appointment start'
                                  ? AppColors.cardColor
                                  : AppColors.buttonColor.withOpacity(0.3),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(imageUrl: bookingController.completedAppointmentsNotifications[index].booking.barber.image.toString(),fit: BoxFit.cover,height: 50,width: 50,),
                                  ),
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
                                                child: RichText(
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  text: TextSpan(
                                                    text: '',
                                                    style: headingSmall.copyWith(
                                                        color: index == 0 ? Colors
                                                            .black : Colors.black,
                                                        height: 1.2),
                                                    children: <TextSpan>[
                                                      new TextSpan(
                                                        text:bookingController.completedAppointmentsNotifications[index].message.toString(),
                                                        style: bodyNormal
                                                            .copyWith(
                                                            color: index == 0
                                                                ? AppColors.whiteColor
                                                                : AppColors.whiteColor,
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
                                         // Confirm completion button row
                                         Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            // index == 0 ?

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: SizedBox(
                                                width: 57.w,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    bookingController.completedAppointmentsNotifications[index].isFeedback.toString()=='1'|| bookingController.completedAppointmentsNotifications[index].message.toString()=="Appointment created successfully." || bookingController.completedAppointmentsNotifications[index].booking.status=='cancel'||bookingController.completedAppointmentsNotifications[index].type.toString()=='Appointment start'?
                                                   Container()
                                                        : _buttonWidget(
                                                        AppColors.buttonColor,
                                                        "Confirm Completion",
                                                        Colors.white, () {
                                                      showCustomDialog(
                                                          context,
                                                          "assets/images/popup/ask.png",
                                                          "Are you sure?",
                                                          Languages.of(context)!.areYouSureYouWantToConfirmCompletionOfThisAppointment,
                                                          "Yes, Confirm", () {
                                                        Get.off(() =>
                                                            ShareFeedback(
                                                                barberName: bookingController.completedAppointmentsNotifications[index].booking.barber.name.toString(),
                                                                barberImagePath: bookingController.completedAppointmentsNotifications[index].booking.barber.image.toString(),
                                                                bookingID: bookingController.completedAppointmentsNotifications[index].bookingId.toString(),
                                                                notificationId: bookingController.completedAppointmentsNotifications[index].id.toString(),
                                                                barberId: bookingController.completedAppointmentsNotifications[index].booking.barber.id.toString(),
                                                                image: "assets/images/barber1.png",
                                                                title: "Glamour Heaven",
                                                                name: "Jane Cooper"));
                                                      },
                                                          null);
                                                    }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Align(
                                                alignment: Alignment.bottomRight,
                                                child: Text(
                                                  formattedTime,
                                                  style: bodySmall.copyWith(
                                                      color: index == 0 ? Colors.white54 : Colors.white54,
                                                      height: 1,
                                                      fontSize: 11),
                                                )),
                                          ],
                                        )
                                        // Expanded(
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        //     crossAxisAlignment: CrossAxisAlignment
                                        //         .end,
                                        //     children: [
                                        //       index == 0
                                        //           ? Row(
                                        //         children: [
                                        //           SizedBox(
                                        //             child: _buttonWidget(
                                        //                 AppColors.buttonColor,
                                        //                 "Confirm",
                                        //                 Colors.white, () {
                                        //               showCustomDialog(
                                        //                   context,
                                        //                   "assets/images/popup/ask.png",
                                        //                   "Are you sure?",
                                        //                   "10 minutes are left in this service. Are you sure that you want to confirm completion of this appointment?",
                                        //                   "Yes, Confirm", () {},
                                        //                   null);
                                        //             }),
                                        //           ),
                                        //           SizedBox(width: 5,),
                                        //           SizedBox(
                                        //             child: _buttonWidget(
                                        //                 Colors.white,
                                        //                 "Cancel",
                                        //                 Colors.black, () {
                                        //               showCustomDialog(
                                        //                   context,
                                        //                   "assets/images/popup/ask.png",
                                        //                   "Are you sure?",
                                        //                   "10 minutes are left in this service. Are you sure that you want to confirm completion of this appointment?",
                                        //                   "Yes, Confirm", () {},
                                        //                   null);
                                        //             }),
                                        //           ),
                                        //         ],
                                        //       ) : Container()
                                        //       // index == 1 ?
                                        //       // Padding(
                                        //       //   padding: const EdgeInsets.only(
                                        //       //       left: 8.0),
                                        //       //   child: SizedBox(
                                        //       //     width: 57.w,
                                        //       //     child: Row(
                                        //       //       mainAxisAlignment:
                                        //       //       MainAxisAlignment.start,
                                        //       //       children: [
                                        //       //         _buttonWidget(
                                        //       //             AppColors.buttonColor,
                                        //       //             "Add Walk-in Customer",
                                        //       //             Colors.white, () {
                                        //       //           Get.off(()=> WalkInCustomer());
                                        //       //         }),
                                        //       //       ],
                                        //       //     ),
                                        //       //   ),
                                        //       // )
                                        //       //
                                        //       //     : SizedBox.shrink(),
                                        //       // Align(
                                        //       //     alignment: Alignment
                                        //       //         .bottomRight,
                                        //       //     child: Text(
                                        //       //       "timeess",
                                        //       //       style: bodySmall.copyWith(
                                        //       //           color: index == 0 ? Colors
                                        //       //               .black54 :
                                        //       //           Colors.black54,
                                        //       //           height: 1,
                                        //       //           fontSize: 11),
                                        //       //     )),
                                        //     ],
                                        //   ),
                                        // )
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
                  }):Expanded(child: Center(child: Text('No notifications yet',style: TextStyle(color: Colors.white),))),
            ),
          ],
        ),
      ):Scaffold(
        backgroundColor: Colors.black,
        body: Center(
        child: CircularProgressIndicator(
          color: AppColors.buttonColor,

        ),
      ),),
    );
  }

  _buttonWidget(Color buttonClr, String buttonText, Color textClr,
      Function onTap) {
    return ZoomTapAnimation(
      onTap: () {
        onTap();
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          height: 40,
          decoration: BoxDecoration(
            color: buttonClr,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(buttonText,
                      style: headingSmall.copyWith(
                        fontSize: 10,
                        color: textClr,
                      )),
                ],
              ),
            ),
          )),
    );
  }

}
