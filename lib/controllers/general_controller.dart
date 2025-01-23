import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constants/custom_dialog.dart';

class GeneralController extends GetxController {
  RxInt _currentIndex = 0.obs;
  List<String> selectedDate = List.filled(12, '');
  int get currentIndex => _currentIndex.value;
  RxString countryCode = ''.obs;
  RxString phoneNumber=''.obs;
  RxString initialCountry='PT'.obs;
  RxString dialCode='+351'.obs;
  RxBool isUser=false.obs;
  RxInt pageViewIndex=0.obs;
  Timer? _timer;
  int remainingSeconds =1;
  final time = '00.00'.obs;
  RxInt seconds=200.obs;
  final startTime = ''.obs; // RxString for start time
  final endTime = ''.obs;   // RxString for end time

  void convert12To24HourFormat(String startTime12, String endTime12) {
    final DateFormat format12 = DateFormat('hh:mm a');
    final DateFormat format24 = DateFormat('HH:mm');


    final DateTime startTimeDT = format12.parse(startTime12);
    final String formattedStartTime = format24.format(startTimeDT);
    startTime.value = formattedStartTime; // Assign formatted start time to RxString

    final DateTime endTimeDT = format12.parse(endTime12);
    final String formattedEndTime = format24.format(endTimeDT);
    endTime.value = formattedEndTime; // Assign formatted end time to RxString
  }

  void updateSeconds(int timeInSeconds){
    seconds.value=timeInSeconds;
    _startTimer(seconds.value);
  }
  @override
  void onReady(){
    _startTimer(seconds.value);
    super.onReady();
  }

  @override
  void onClose(){
    if(_timer!=null){
      _timer!.cancel();
    }
    super.onClose();
  }

  _startTimer(int seconds){
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if(remainingSeconds==0){
        timer.cancel();
      }else{
        int minutes = remainingSeconds~/60;
        int seconds = (remainingSeconds%60);
        time.value = minutes.toString().padLeft(2, "0")+
            ":"+seconds.toString().padLeft(2, "0");
        remainingSeconds--;
      }
    });
  }

void updateUserType(bool isUserLogin){
  isUser.value=isUserLogin;
}
  void updateIsoCode(String isoCode){
     initialCountry.value=isoCode;
  }

  void updatePhone(String phone) {
    phoneNumber.value = phone;
  }

  void updateIsoAndDialCode(String initialCountryCode,String IsoCode) {
    initialCountry.value=initialCountryCode;
    countryCode.value = IsoCode;
  }

  void onBottomBarTapped(int index) {
    _currentIndex.value = index;
  }
  void updatePageView(int index){
    pageViewIndex.value=index;
  }

  showLoading([String? message]) {
    CustomDialogBox.showLoading(message);
  }

  hideLoading() {
    CustomDialogBox.hideLoading();
  }

  // successDialog(BuildContext context, String titleHead, String description) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(builder: (context, setState) {
  //           return AlertDialog(
  //             backgroundColor: Colors.white,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10)),
  //             // title: Text("Notice"),
  //             // content: Text("Launching this missile will destroy the entire universe. Is this what you intended to do?"),
  //             actions: [
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                     horizontal: 20.0, vertical: 10),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     SizedBox(
  //                       height: 2.h,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       children: [
  //                         GestureDetector(
  //                             onTap: () {
  //                               Get.back();
  //                             },
  //                             child: const Icon(
  //                               Icons.close,
  //                               color: Colors.black,
  //                             )),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 1.h,
  //                     ),
  //                     const Icon(
  //                       Icons.done,
  //                       color: Colors.black,
  //                       size: 40,
  //                     ),
  //                     SizedBox(
  //                       height: 1.h,
  //                     ),
  //                     Text(
  //                       titleHead,
  //                       style:
  //                           title.copyWith(fontSize: 22, color: Colors.black),
  //                     ),
  //                     SizedBox(
  //                       height: 1.h,
  //                     ),
  //                     Text(
  //                       description,
  //                       style: bodySmall.copyWith(fontSize: 16),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                     SizedBox(
  //                       height: 4.h,
  //                     ),
  //                     SizedBox(
  //                       child: CustomButton(
  //                         buttonText: "OK",
  //                         onTap: () {
  //                           Get.back();
  //                         },
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           );
  //         });
  //       });
  // }

  // errorDialog(BuildContext context, String titleHead, String description) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(builder: (context, setState) {
  //           return AlertDialog(
  //             backgroundColor: Colors.white,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10)),
  //             // title: Text("Notice"),
  //             // content: Text("Launching this missile will destroy the entire universe. Is this what you intended to do?"),
  //             actions: [
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                     horizontal: 20.0, vertical: 10),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     SizedBox(
  //                       height: 2.h,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       children: [
  //                         GestureDetector(
  //                             onTap: () {
  //                               Get.back();
  //                             },
  //                             child: const Icon(
  //                               Icons.close,
  //                               color: Colors.black,
  //                             )),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 1.h,
  //                     ),
  //                     const Icon(
  //                       Icons.error,
  //                       color: Colors.black,
  //                       size: 40,
  //                     ),
  //                     SizedBox(
  //                       height: 1.h,
  //                     ),
  //                     Text(
  //                       titleHead,
  //                       style:
  //                           title.copyWith(fontSize: 22, color: Colors.black),
  //                     ),
  //                     SizedBox(
  //                       height: 1.h,
  //                     ),
  //                     Text(
  //                       description,
  //                       style: bodySmall.copyWith(fontSize: 16),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                     SizedBox(
  //                       height: 4.h,
  //                     ),
  //                     SizedBox(
  //                       child: CustomButton(
  //                         buttonText: "OK",
  //                         onTap: () {
  //                           Get.back();
  //                         },
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           );
  //         });
  //       });
  // }

  // String convertToCompactRepresentation(int value) {
  //   if (value < 1000) {
  //     return value.toString();
  //   } else if (value < 1000000) {
  //     double result = value / 1000.0;
  //     return result
  //             .toStringAsFixed(result.truncateToDouble() == result ? 0 : 1) +
  //         'k';
  //   } else {
  //     double result = value / 1000000.0;
  //     return result
  //             .toStringAsFixed(result.truncateToDouble() == result ? 0 : 1) +
  //         'M';
  //   }
  // }
}
