import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/views/user/appointments/cancel_appointment.dart';
import 'package:beauty_connect/views/user/appointments/re_book_appointment.dart';
import 'package:beauty_connect/views/user/appointments/summary.dart';
import 'package:beauty_connect/widgets/card_widget.dart';
import 'package:beauty_connect/widgets/custom_widgets.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../models/calender_model.dart';
import '../../../widgets/calender_widget.dart';
import '../../../widgets/custom_dialog.dart';

class AppointmentDetail extends StatefulWidget {
  final String pageTitle;
  final String image;
  final String title;
  final String name;
  final int selectedIndex;

  const AppointmentDetail(
      {super.key,
      required this.pageTitle,
      required this.image,
      required this.title,
      required this.name,
      required this.selectedIndex});

  @override
  State<AppointmentDetail> createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  List<String> bookingTime = [
    "10:00 AM",
        "10:20 AM",
        "10:40 AM",
        "11:00 AM",
        "11:20 AM",
        "11:40 AM",
  ];
  int selectedTime = -1;
  DateTime selectedDayDate = DateTime.now();
  DateTime firstDayDate = DateTime.utc(2000, 12, 18);
  DateTime lastDayDate = DateTime.utc(2090, 12, 18);
  String dayOfWeek = "";
  List<EventModel> events = [];

  void onTheDaySelected(DateTime day, DateTime focusedDay) {
    var funcTag = "onTheDaySelected";
    setState(() {
      selectedDayDate = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cardColor,
        title: CustomAppBar(
            pageTitle: widget.pageTitle,
            onTapLeading: () {
              Get.back();
            },
            actionButton: widget.selectedIndex == 0
                ? Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            showCustomDialog(
                                context,
                                "assets/images/popup/success.png",
                                "Appointment has been pioritized",
                                "Your appoint for Glamour Heaven has been set to the priority.",
                                "Done", () {
                              Get.back();
                            }, null);
                          },
                          child: Text(
                            "Prioritize",
                            style: bodySmall.copyWith(
                                fontSize: 10, color: AppColors.buttonColor),
                          )),
                      SizedBox(
                        width: 2,
                      ),
                      Image.asset(
                        "assets/icons/prioritize.png",
                        scale: 5,
                      ),
                    ],
                  )
                : SizedBox.shrink()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Selected Services",
                    style: headingMedium,
                  )),
              SizedBox(
                height: 10,
              ),
              _servicesList(
                  "assets/icons/haircut.png", "Haircut", "20 mins", "20.00"),
              _servicesList(
                  "assets/icons/shaving.png", "Shaving", "20 mins", "25.00"),
              SizedBox(
                height: 15,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Barber",
                    style: headingMedium,
                  )),
              SizedBox(
                height: 10,
              ),
              CardWidget(
                locationImage: Container(),
                  image: widget.image, title: widget.title, name: widget.name),
              SizedBox(
                height: 5,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Appointment date and time",
                    style: headingMedium,
                  )),
              SizedBox(height: 10,),
              CalenderWidget(selectedDayDate: selectedDayDate, events: events, onTheDaySelected: onTheDaySelected, isWeeklyCalender: true),
              SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 5,
                children: [
                  for (int i=0;i<6;i++)
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedTime = i;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: AppColors.buttonColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: selectedTime == i ? AppColors.buttonColor : Colors.transparent),
                        ),
                        child: Text(bookingTime[i], style: bodyMedium.copyWith(fontSize: 12),),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 10,),
              widget.selectedIndex == 0
                  ? SizedBox.shrink()
                  : SizedBox(
                      height: 5,
                    ),
              widget.selectedIndex == 0
                  ? SizedBox.shrink()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.selectedIndex == 1
                            ? "Your Feedback"
                            : "Cancelled by barber",
                        style: headingMedium,
                      )),
              SizedBox(
                height: 10,
              ),
              widget.selectedIndex == 0
                  ? SizedBox.shrink()
                  : widget.selectedIndex == 1
                      ? Container(
                          width: 100.w,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 0.1,
                                    blurRadius: 3,
                                    offset: Offset(0, 0))
                              ]),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/cameron.png"),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            "Cameron Williamson",
                                            style: headingSmall,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "1 month ago",
                                    style: bodySmall.copyWith(
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet consectetur. Proin faucibus imperdiet venenatis faucibus aliquet condimentum pretium.",
                                style:
                                    bodySmall.copyWith(color: Colors.black54),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  DelayedDisplay(
                                    delay: Duration(milliseconds: 550),
                                    slidingBeginOffset: Offset(0, 0),
                                    child: RatingBar.builder(
                                      itemSize: 18,
                                      initialRating: 4,
                                      minRating: 1,
                                      ignoreGestures: true,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "4.5",
                                    style: headingSmall.copyWith(
                                      fontSize: 11,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: 100.w,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 0.1,
                                    blurRadius: 3,
                                    offset: Offset(0, 0))
                              ]),
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
                            ],
                          ),
                        ),
              SizedBox(height: 100,),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(16, 2, 16, 15),
        child: widget.selectedIndex == 0
            ? Row(
                children: [
                  Expanded(
                    child: ZoomTapAnimation(
                      onTap: () {
                        Get.to(() => CancelAppointment());
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: AppColors.buttonColor)),
                          child: Center(
                            child: Text("Cancel", style: headingSmall.copyWith(fontSize: 14)),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 65,
                      child: CustomButton(
                        fontSize: 14,
                        onTap: () {
                          Get.to(()=> ReviewSummary(isPaid: true,));
                        },
                        buttonText: "View E-Receipt",
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: CustomButton(
                  onTap: () {
                    Get.to(() => ReBookAppointment(
                      index: 3,
                          image: widget.image,
                          title: widget.title,
                          name: widget.name,
                        ));
                  },
                  buttonText: "Re-book Appointment",
                ),
              ),
      ),
    );
  }

  _servicesList(String icon, String title, String time, String charges) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.fromLTRB(2, 2, 2, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                spreadRadius: 0.1,
                blurRadius: 3,
                offset: Offset(0, 0))
          ]),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Image.asset(
              icon,
              scale: 4,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              title,
              style: headingSmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Services Time",
                  style: bodySmall.copyWith(color: Colors.black54, fontSize: 8),
                ),
                Text(
                  time,
                  style: bodySmall.copyWith(),
                ),
              ],
            ),
            VerticalDivider(
              width: 20,
              thickness: 1,
              color: Colors.white54,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Services Charges",
                  style: bodySmall.copyWith(color: Colors.black54, fontSize: 8),
                ),
                Text(
                  "\$" + charges,
                  style: bodySmall.copyWith(),
                ),
              ],
            ),
            Container(
              height: 15,
              width: 15,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.buttonColor),
              ),
              child: Icon(
                Icons.circle,
                color: AppColors.buttonColor.withOpacity(0.5),
                size: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
