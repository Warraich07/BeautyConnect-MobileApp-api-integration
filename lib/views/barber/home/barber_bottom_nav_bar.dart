import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:beauty_connect/views/barber/appointments/barber_appointments_screen.dart';
import 'package:beauty_connect/views/barber/orders/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/global_variables.dart';
import '../../../controllers/general_controller.dart';
import '../../common/profile/settings/settings_screen.dart';
import 'barber_home_screen.dart';

class BarberBottomNavBar extends StatelessWidget {
  BarberBottomNavBar({Key? key}) : super(key: key);

  final GeneralController _generalController = Get.find<GeneralController>();

  final List<Widget> _pages = [
    BarberHomeScreen(),
    BarberAppointmentsScreen(),
    OrdersScreen(),
    SettingsScreen(
      isUser: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        body: _pages[_generalController.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            _generalController.onBottomBarTapped(value);
          },
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(color: AppColors.buttonColor, fontSize: 10),
          unselectedLabelStyle: const TextStyle(color: Colors.grey, fontSize: 10),
          backgroundColor: AppColors.cardColor,
          selectedItemColor: AppColors.buttonColor,
          unselectedItemColor: Colors.black.withOpacity(.60),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24,
                        child: Image.asset(
                          "assets/icons/bottom/home.png",
                          fit: BoxFit.fill,
                          color: _generalController.currentIndex == 0
                              ? AppColors.buttonColor
                              : Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        Languages.of(context)!.home,
                        style: bodySmall.copyWith(
                            fontSize: 10,
                            color: _generalController.currentIndex == 0
                                ? AppColors.buttonColor
                                : Colors.grey, fontFamily: _generalController.currentIndex == 0 ? "SemiBoldText" : null),
                      )
                    ],
                  ),
                ),
                label: Languages.of(context)!.home),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24,
                        child: Image.asset(
                          "assets/icons/bottom/appointments.png",
                          fit: BoxFit.fill,
                          color: _generalController.currentIndex == 1
                              ? AppColors.buttonColor
                              : Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        Languages.of(context)!.appointments,
                        style: bodySmall.copyWith(
                            fontSize: 10,
                            color: _generalController.currentIndex == 1
                                ? AppColors.buttonColor
                                : Colors.grey, fontFamily: _generalController.currentIndex == 1 ? "SemiBoldText" : null),
                      )
                    ],
                  ),
                ),
                label: Languages.of(context)!.appointments),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    bottom: 4,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24,
                        child: Image.asset(
                          "assets/icons/bottom/orders.png",
                          fit: BoxFit.fill,
                          color: _generalController.currentIndex == 2
                              ? AppColors.buttonColor
                              : Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        Languages.of(context)!.orders,
                        style: bodySmall.copyWith(
                            fontSize: 10,
                            color: _generalController.currentIndex == 2
                                ? AppColors.buttonColor
                                : Colors.grey, fontFamily: _generalController.currentIndex == 2 ? "SemiBoldText" : null),
                      )
                    ],
                  ),
                ),
                label: Languages.of(context)!.orders),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    bottom: 4,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24,
                        child: Image.asset(
                          "assets/icons/bottom/settings.png",
                          fit: BoxFit.fill,
                          color: _generalController.currentIndex == 3
                              ? AppColors.buttonColor
                              : Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        Languages.of(context)!.settings,
                        style: bodySmall.copyWith(
                            fontSize: 10,
                            color: _generalController.currentIndex == 3
                                ? AppColors.buttonColor
                                : Colors.grey, fontFamily: _generalController.currentIndex == 2 ? "SemiBoldText" : null),
                      )
                    ],
                  ),
                ),
                label: Languages.of(context)!.settings),
          ],
        ),
      ),
    );
  }
}
