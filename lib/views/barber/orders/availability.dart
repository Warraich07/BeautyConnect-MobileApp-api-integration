import 'package:beauty_connect/constants/global_variables.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../widgets/custom_widgets.dart';

class Availability extends StatefulWidget {
  const Availability({super.key});

  @override
  State<Availability> createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {
  // final EasyInfiniteDateTimelineController _controller =
  // EasyInfiniteDateTimelineController();
  List<String> bookingTime = [
    "10:00 AM - 10:20 AM",
    "10:20 AM - 10:40 AM",
    "11:00 AM - 11:20 AM",
  ];
  int selectedTime = -1;
  List<String> availableTime = [
    "10:40 AM - 11:00 AM",
    "11:20 AM - 12:40 PM",
  ];
  int selectedAvailTime = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black12,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: "Availability",
          onTapLeading: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
            },
            headerProps:  EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.monthOnly(),
            ),
            dayProps:  EasyDayProps(
              height: 60,
              width: 50,
              inactiveDayStyle: DayStyle(dayNumStyle: headingSmall, dayStrStyle: bodySmall, decoration: BoxDecoration(color: AppColors.textFieldColor.withOpacity(0.7), borderRadius: BorderRadius.circular(8))),
              disabledDayStyle: DayStyle(dayNumStyle: headingSmall, dayStrStyle: bodySmall, ),
              dayStructure: DayStructure.dayStrDayNum,
              activeDayStyle: DayStyle(
                dayNumStyle: headingSmall.copyWith(color: Colors.white),
                dayStrStyle: bodySmall.copyWith(color: Colors.white),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.buttonColor,
                      AppColors.buttonColor
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Today's Appointment",
                  style: headingMedium,
                )),
          ),
          SizedBox(height: 10,),

          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 16),
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
            child: Wrap(
              spacing: 5,
              children: [
                for (int i=0;i<3;i++)
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedTime = i;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Today's Availability",
                  style: headingMedium,
                )),
          ),
          SizedBox(height: 10,),

          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 16),
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
            child: Wrap(
              spacing: 5,
              children: [
                for (int i=0;i<2;i++)
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedAvailTime = i;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: AppColors.buttonColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: selectedAvailTime == i ? AppColors.buttonColor : Colors.transparent),
                      ),
                      child: Text(availableTime[i], style: bodyMedium.copyWith(fontSize: 12),),
                    ),
                  ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
