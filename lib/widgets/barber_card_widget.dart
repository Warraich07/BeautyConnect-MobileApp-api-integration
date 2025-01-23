import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:beauty_connect/views/user/appointments/summary.dart';
import 'package:beauty_connect/widgets/custom_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../constants/global_variables.dart';
import '../views/barber/home/barber_bottom_nav_bar.dart';
import '../views/user/appointments/re_book_appointment.dart';
import 'comments_widget.dart';
import 'custom_dialog.dart';

class BarberCardWidget extends StatefulWidget {
  final Widget image;
  final String name;
  final bool isActive;
  final bool isServing;
  final bool isCompleted;
  final bool isCancelled;
  final bool isWalkIn;
  final Function? onTapCancel;
  final Function? onTapStart;
  final String? services;
  final String? barberName;
  final String appointmentCharges;
  final String startTime;
  final String endTime;
  final Function()? onTap;
  final String buttonText;
  final Function()? onTapComplete;
  final String? appointmentStatusButton;
  final String? timeLeft;
  final bool? showAppointmentTime;
  const BarberCardWidget(
      {super.key,
      required this.image,
      required this.name,
      this.isActive = false,
      this.onTapCancel,
      this.isCompleted = false,
      this.isCancelled = false,
      this.onTapStart,
      this.isServing = false,
      this.isWalkIn = false,
      this.services,
      this.barberName,
      required this.appointmentCharges,
      required this.startTime,
      required this.endTime,
      required this.onTap,
        required this.buttonText,
        this.onTapComplete,
        this.appointmentStatusButton,
        this.timeLeft,
        this.showAppointmentTime=false
      });

  @override
  State<BarberCardWidget> createState() => _BarberCardWidgetState();
}

class _BarberCardWidgetState extends State<BarberCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: widget.isActive == true || widget.isServing == true
          ? 170
          : widget.isCompleted == true
              ? 110
              : widget.isCancelled == true
                  ? 150
                  : 110,
      padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: widget.isCancelled || widget.isCompleted ? 10 : 0),
      margin: EdgeInsets.fromLTRB(0, 2, 0, 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColors.cardColor,
          boxShadow: [
            BoxShadow(
                color: Colors.white12,
                spreadRadius: 0.1,
                blurRadius: 3,
                offset: Offset(0, 0))
          ]),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 90,
                    width: 90,
                    child: widget.image,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.name,
                              style: headingSmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Tooltip(
                                message: widget.services,
                                child: Text(widget.services ?? '',
                                    style: bodyMedium.copyWith(fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 3),
                              width: 25.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    Languages.of(context)!.barber,
                                    style: bodySmall.copyWith(
                                        color: AppColors.buttonColor, fontSize: 8),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Tooltip(
                                    message: widget.barberName,
                                    child: Text(widget.barberName ?? '',
                                        style: bodyMedium.copyWith(fontSize: 8),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    VerticalDivider(
                                      width: 20,
                                      thickness: 1,
                                      color: Colors.white54,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Languages.of(context)!.appointmentCharges,
                                            style: bodySmall.copyWith(
                                                color: AppColors.buttonColor,
                                                fontSize: 8),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Expanded(
                                            child: Text(
                                                "\$ " +
                                                    widget.appointmentCharges,
                                                style: bodyMedium.copyWith(
                                                    fontSize: 8),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      widget.isServing == false
                          ? Row(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  Languages.of(context)!.appointmentTime,
                                  style: bodyMedium.copyWith(fontSize: 8),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  widget.startTime + "-" + widget.endTime,
                                  style: bodyMedium.copyWith(
                                      fontSize: 8,
                                      color: AppColors.buttonColor),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            )
                          :widget.showAppointmentTime==true?
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            Languages.of(context)!.appointmentTime,
                            style: bodyMedium.copyWith(fontSize: 8),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            widget.startTime + "-" + widget.endTime,
                            style: bodyMedium.copyWith(
                                fontSize: 8,
                                color: AppColors.buttonColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      )
                          : Row(
                              children: [
                                // Text(
                                //   "Time Left: ",
                                //   style: bodyMedium.copyWith(fontSize: 8),
                                //   overflow: TextOverflow.ellipsis,
                                //   maxLines: 1,
                                // ),
                                Text(
                                  widget.timeLeft??'',
                                  style: bodyMedium.copyWith(
                                      fontSize: 8,
                                      color: AppColors.buttonColor),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.isActive == true
              ? Expanded(
                  child: Row(
                    children: [
                      ZoomTapAnimation(
                        onTap: () {
                          setState(() {
                            widget.onTapCancel!();
                          });
                        },
                        child: Container(

                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            width: 46.w,
                            height: 47,
                            decoration: BoxDecoration(
                                color: AppColors.cardColor,
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(color: AppColors.buttonColor)),
                            child: Center(
                              child: Text(Languages.of(context)!.cancelAppointment,
                                  style: bodyMedium.copyWith(fontSize: 12)),
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ZoomTapAnimation(
                        onTap: widget.onTap,
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            height: 47,
                            decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(widget.buttonText,
                                  style:
                                  bodyMedium.copyWith(fontSize: 12,color: AppColors.scaffoldColor)),
                            )),
                      )),
                    ],
                  ),
                )
              : widget.isCompleted == true
                  ? SizedBox.shrink()
                  : widget.isCancelled == true
                      ? Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Reason of Cancellation",
                                  style: headingSmall.copyWith(fontSize: 10),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Bad Weather Condition",
                                  style: bodySmall,
                                )),
                          ],
                        )
                      : widget.isServing == true
                          ? Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: ZoomTapAnimation(
                                    // onTap: () {
                                    //   showCustomDialog(
                                    //       context,
                                    //       "assets/images/popup/ask.png",
                                    //       "Are you sure?",
                                    //       "10 minutes are left in this service. Are you sure that you want to complete this appointment?",
                                    //       "Yes, Complete", () {
                                    //     Get.offAll(() => BarberBottomNavBar());
                                    //   }, null);
                                    // },
                                    child: GestureDetector(
                                      onTap: widget.onTapComplete,
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 36),
                                          height: 47,
                                          decoration: BoxDecoration(
                                            color: AppColors.buttonColor,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Center(
                                            child: Text(widget.appointmentStatusButton??Languages.of(context)!.completeAppointment,
                                                style: bodyMedium.copyWith(
                                                    color: Colors.black)),
                                          )),
                                    ),
                                  )),
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
        ],
      ),
    );
  }
}
