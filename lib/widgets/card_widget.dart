import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../constants/global_variables.dart';
import '../views/user/appointments/re_book_appointment.dart';

class CardWidget extends StatefulWidget {
  final String image;
  final Widget locationImage;
  final String name;
  final String title;
  final bool isActive;
  final bool isCompleted;
  final bool isCancelled;
  final Function? onTapCancel;
  final Function? onTapReceipt;
  final String? location;
  final String? averageRating;
  final String?
  services;
  final String? appointmentStatus;
  final bool? showCancelButton;
  final String? appointmentCharges;
  final String? reasonOfCancellation;
  double? paddingForServices;

  CardWidget(
      {super.key,
      this.location,
      this.reasonOfCancellation,
      this.averageRating,
      required this.image,
      required this.title,
      required this.name,
      this.isActive = false,
      this.onTapCancel,
      this.isCompleted = false,
      this.isCancelled = false,
      this.onTapReceipt,
      this.services = "",
      this.appointmentStatus,
      this.showCancelButton,
      this.appointmentCharges,
      required this.locationImage,this.paddingForServices});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(

      width: 100.w,
      height: widget.isActive == true || widget.isCompleted == true ? 195
          : widget.isCancelled == true ? 250 : 115,
      padding: EdgeInsets.fromLTRB(10, 10, 10,
          widget.isActive == true || widget.isCompleted == true ? 0 : 10),
      margin: EdgeInsets.fromLTRB(0, 2, 0, 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColors.cardColor,
          // color: Colors.green,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                spreadRadius: 0.1,
                blurRadius: 3,
                offset: Offset(0, 0))
          ]),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.image.toString(),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator(
                            color: AppColors.buttonColor,
                          )),
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/img.png"),
                      fit: BoxFit.cover,
                    ),
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
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              Text(
                                widget.averageRating.toString() == "0.0"|| widget.averageRating.toString() == "null"
                                    ? "0"
                                    : widget.averageRating.toString(),
                                style: headingSmall.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 2,
                      // ),
                      Text(widget.title,
                          style: bodyMedium.copyWith(fontSize: 10),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                      
                        children: [
                          // Image.asset(
                          //   "assets/icons/location_icon.png",
                          //   scale: 9,
                          // ),

                            widget.locationImage,
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                              child: Text(widget.location ?? '',
                                  style: bodyMedium.copyWith(fontSize: 10),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1)),
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only( top: widget.paddingForServices??7),
                              // color: Colors.red,
                              // height: 100,
                              width: 25.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.services!.isEmpty?Container(): Text(
                                    Languages.of(context)!.services,

                                    // "Services",
                                    style: bodySmall.copyWith(color: AppColors.buttonColor, fontSize: 8),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Expanded(
                                    child: Tooltip(
                                      showDuration: Duration(seconds: 3),
                                      message: widget.services,
                                      child: Text(widget.services ?? '',
                                          style: bodyMedium.copyWith(fontSize: 8,),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            widget.isActive == true
                                ? Expanded(
                                    child: IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5),
                                            child: VerticalDivider(
                                              width: 2,
                                              thickness: 1,
                                              color: Colors.white54,
                                            ),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                // SizedBox(
                                                //   height: 2,
                                                // ),
                                                Expanded(
                                                  child: Text(
                                                      "\$" +
                                                          (widget.appointmentCharges ??
                                                              '30'),
                                                      style:
                                                          bodyMedium.copyWith(
                                                              fontSize: 9),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.isCancelled == true
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Reason of Cancellation",
                            style: headingSmall.copyWith(fontSize: 10),
                          )),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Tooltip(
                            message: widget.reasonOfCancellation,
                            child: Text(
                              widget.reasonOfCancellation ?? '',
                              style: bodySmall,
                              maxLines: 1,
                            ),
                          ))
                    ],
                  ),
                )
              : SizedBox.shrink(),
          widget.isActive == true
              ? Expanded(
                  child: Row(
                    children: [
                      widget.showCancelButton == true
                          ? ZoomTapAnimation(
                              onTap: () {
                                setState(() {
                                  widget.onTapCancel!();
                                });
                              },
                              child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  width: 45.w,
                                  height: 47,
                                  decoration: BoxDecoration(
                                      color: AppColors.cardColor,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          color: AppColors.buttonColor)),
                                  child: Center(
                                    child: Text(widget.appointmentStatus ?? "",
                                        style:
                                            bodyMedium.copyWith(fontSize: 12)),
                                  )),
                            )
                          : Container(),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ZoomTapAnimation(
                        onTap: () {
                          widget.onTapReceipt!();
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            height: 47,
                            decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text("View E-Receipt",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black,fontWeight: FontWeight.w500)),
                            )),
                      )),
                    ],
                  ),
                )
              : widget.isCompleted == true
                  ? Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: ZoomTapAnimation(
                            onTap: () {
                              Get.to(() => ReBookAppointment(
                                    index: 3,
                                    image: widget.image,
                                    title: widget.title,
                                    name: widget.name,
                                  ));
                            },
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                margin: EdgeInsets.symmetric(horizontal: 46),
                                height: 47,
                                decoration: BoxDecoration(
                                  color: AppColors.buttonColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text("Re-book Appointment",
                                      style: bodyMedium.copyWith(
                                          color: Colors.white)),
                                )),
                          )),
                        ],
                      ),
                    )
                  : widget.isCancelled == true
                      ? Expanded(
                          child: Column(
                            children: [
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
                                    "Barber could not start your service at the scheduled time",
                                    style: bodySmall,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: ZoomTapAnimation(
                                    onTap: () {
                                      Get.to(() => ReBookAppointment(
                                            index: 3,
                                            image: widget.image,
                                            title: widget.title,
                                            name: widget.name,
                                          ));
                                    },
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
                                          child: Text("Re-book Appointment",
                                              style: bodyMedium.copyWith(
                                                  color: Colors.white)),
                                        )),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
        ],
      ),
    );
  }
}
