import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/controllers/timer_controller.dart';
import 'package:beauty_connect/guest_mode/controllers/guest_controller.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import 'general_controller.dart';



class LazyController extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(BookingController());
    Get.put(GeneralController());
    Get.put(AuthController());
    Get.put(GuestController());
    Get.put(TimerController());
  }
}