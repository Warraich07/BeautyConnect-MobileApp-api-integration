import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/controllers/general_controller.dart';
import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:beauty_connect/views/user/appointments/page_views/active_appointmnets.dart';
import 'package:beauty_connect/views/user/appointments/page_views/cancelled_appointments.dart';
import 'package:beauty_connect/views/user/appointments/page_views/completed_appointments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int selectedIndex = 0;

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
  final List<Widget> _pages = [
    ActivePageView(),
    CompletedPageView(),
    CancelledPageView()
  ];
  GeneralController generalController=Get.find();
  @override
  Widget build(BuildContext context) {

    List<String> topTitle = [Languages.of(context)!.active, Languages.of(context)!.completed, Languages.of(context)!.cancelled];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading :false,
        elevation: 0.5,
        toolbarHeight: 120,
        backgroundColor: AppColors.cardColor,
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
                  physics: ScrollPhysics(),
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          print(selectedIndex);
                          // generalController.updatePageView(index);
                          // print(index);
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
      body: _pages[selectedIndex],
    );
  }
}
