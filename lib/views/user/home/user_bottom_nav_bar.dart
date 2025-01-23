import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:beauty_connect/views/common/profile/profile_screen.dart';
import 'package:beauty_connect/views/user/appointments/appointments_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/admob/v1.dart';
import '../../../constants/global_variables.dart';
import '../../../controllers/general_controller.dart';
import '../../common/profile/settings/settings_screen.dart';
import 'user_home_screen.dart';

class UserBottomNavBar extends StatefulWidget {
  UserBottomNavBar({Key? key,this.selectedIndex = 2}) : super(key: key);
  int selectedIndex;
  @override
  State<UserBottomNavBar> createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  final GeneralController _generalController = Get.find<GeneralController>();

  final List<Widget> _pages = [
    UserHomeScreen(),
    AppointmentsScreen(),
    ProfileScreen(isUser: true),
    SettingsScreen(
      isUser: true,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                              ?AppColors.buttonColor
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
                          "assets/icons/bottom/profile.png",
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
                        Languages.of(context)!.profile,
                        style: bodySmall.copyWith(
                            fontSize: 10,
                            color: _generalController.currentIndex == 2
                                ? AppColors.buttonColor
                                : Colors.grey, fontFamily: _generalController.currentIndex == 2 ? "SemiBoldText" : null),
                      )
                    ],
                  ),
                ),
                label: Languages.of(context)!.profile),
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
