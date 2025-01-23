import 'package:get/get.dart';
import 'guest_controller.dart';

class LazyController extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(GuestController());


  }
}