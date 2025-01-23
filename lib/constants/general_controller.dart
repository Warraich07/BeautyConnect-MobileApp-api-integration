import 'package:get/get.dart';

class GeneralTYpeController extends GetxController {
  RxInt _currentIndex = 2.obs;
  int get currentIndex => _currentIndex.value;
  // RxBool isUser=false.obs;
  // void updateUserToBarber(bool value){
  //   isUser.value=value;
  // }
  void onBottomBarTapped(int index) {
    _currentIndex.value = index;
  }


}
int languageCount=0;