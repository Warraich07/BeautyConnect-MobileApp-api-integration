import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/views/barber/appointments/appointments_page_views/active_appointmnets.dart';
import 'package:beauty_connect/views/user/appointments/cancel_appointment.dart';
import 'package:beauty_connect/views/user/appointments/summary.dart';
import 'package:beauty_connect/widgets/barber_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../localization/languages/languages.dart';
import 'appointments_page_views/cancelled_appointments.dart';
import 'appointments_page_views/completed_appointments.dart';
import 'barber_appointment_detail.dart';

class BarberAppointmentsScreen extends StatefulWidget {
  const BarberAppointmentsScreen({super.key});

  @override
  State<BarberAppointmentsScreen> createState() => _BarberAppointmentsScreenState();
}

class _BarberAppointmentsScreenState extends State<BarberAppointmentsScreen> {
  int selectedIndex = 0;


  List<String> images = [
    "assets/images/cameron.png",
    "assets/images/jenny.png",
  ];
  List<String> name = [
    "Cameron Williamson",
    "Jenny Wilson",
  ];
  final List<Widget> _pages = [
    ActivePageViewBarber(),
    CompletedPageViewBarber(),
    CancelledPageViewBarber()
  ];
  @override
  Widget build(BuildContext context) {
    List<String> topTitle = [Languages.of(context)!.active, Languages.of(context)!.completed, Languages.of(context)!.canceled];
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,

        appBar: AppBar(

        elevation: 5,
        shadowColor: Colors.black12,
        toolbarHeight: 120,
          backgroundColor: AppColors.cardColor,
          automaticallyImplyLeading:false,

          title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Languages.of(context)!.appointments,
              style: headingLarge.copyWith(fontSize: 21),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 100.w,
              child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        height: 55,
                        width: 28.w,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: selectedIndex == index
                              ? AppColors.buttonColor
                              : AppColors.greyText,
                        ),
                        child: Center(
                            child: Text(
                          topTitle[index],
                          style: bodyMedium.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: selectedIndex == index
                                  ? Colors.black
                                  : Colors.white),
                        )),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      body: _pages[selectedIndex]
    );
  }
}
