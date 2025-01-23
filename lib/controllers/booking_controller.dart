import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:beauty_connect/controllers/timer_controller.dart';
import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:beauty_connect/models/barbers_model.dart';
import 'package:beauty_connect/models/create_booking_model.dart';
import 'package:beauty_connect/models/main_booking_model.dart';
import 'package:beauty_connect/models/receipt_model.dart';
import 'package:beauty_connect/views/barber/home/barber_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../guest_mode/widgets/custom_dialog.dart';
import '../models/barber_notifications_model.dart';
import '../models/barber_services_model.dart';
import '../models/barber_slots_model.dart';
import '../models/guest_user_model.dart';
import '../models/main_barber_booking_model.dart';
import '../models/user_notifications_model.dart';
import '../models/user_unseen_notifications_model.dart';
import '../utils/custom_dialogbox.dart';
import '../utils/shared_preference.dart';
import '../views/user/appointments/summary.dart';
import '../views/user/home/user_bottom_nav_bar.dart';
import 'auth_controller.dart';
import 'base_controller.dart';

class BookingController extends GetxController{
  final BaseController _baseController = BaseController.instance;
  RxList<BarbersModel> barberDataList=<BarbersModel>[].obs;
  RxList<BarberSlots> barberSlotsList=<BarberSlots>[].obs;
  RxList<MainBookigModel> selectedBookingList=<MainBookigModel>[].obs;
  RxList<UnseenNotificationsModel> unSeenNotificationsList=<UnseenNotificationsModel>[].obs;
  RxList<MainBookigModel> completedBookingList=<MainBookigModel>[].obs;
  RxList<MainBookigModel> canceledBookingList=<MainBookigModel>[].obs;
  RxList<MainBookigModel> activeBookingList=<MainBookigModel>[].obs;
  Rxn<CreatedBookingModel> createdBookingList=Rxn<CreatedBookingModel>();
  Rxn<ReceiptModel> bookingReceipt=Rxn<ReceiptModel>();
  RxList<MainBarberBookingModel> barberBookingList=<MainBarberBookingModel>[].obs;
  RxList<MainBarberBookingModel> pendingBarberBookingList=<MainBarberBookingModel>[].obs;
  RxList<MainBarberBookingModel> currentlyServingList=<MainBarberBookingModel>[].obs;
  RxList<MainBarberBookingModel> cancelledBookingList=<MainBarberBookingModel>[].obs;
  RxList<MainBarberBookingModel> barberCompletedBookingList=<MainBarberBookingModel>[].obs;
  RxList<MainBarberBookingModel> pendingAppointments=<MainBarberBookingModel>[].obs;
  RxList<GuestUserModel> guestUserList=<GuestUserModel>[].obs;
  RxList<GuestUserModel> completedGuestUserAppointments=<GuestUserModel>[].obs;
  Rxn<ServicesBarberModel> barberServicesList=Rxn<ServicesBarberModel>();
  Rxn<ServicesBarberModel> servicesList=Rxn<ServicesBarberModel>();
  RxString formattedDate = ''.obs; // Formats as "6/21/2024"
  RxString formattedTime = ''.obs;
  RxBool isLoading = false.obs;
  RxBool guestLoading = false.obs;
  RxBool calenderLoading= false.obs;
  RxInt  differenceInSeconds=0.obs;
  RxString timeMinutesSeconds = ''.obs; // Observable variable for formatted time
  TimerController timerController=TimerController();
  RxString fcmToken=''.obs;
  RxList<UserNotificationsModel> userNotificationsList=<UserNotificationsModel>[].obs;
  RxList<BarberNotificationsModel> barberNotificationsList=<BarberNotificationsModel>[].obs;
  RxList<UserNotificationsModel> completedAppointmentsNotifications=<UserNotificationsModel>[].obs;
  RxString startDay=''.obs;
  RxString endDay=''.obs;
  RxString startTime=''.obs;
  RxString endTime=''.obs;
  RxString languageCode=''.obs;
  // AuthController authController=Get.find();

void updateFcmToken(String token){
  fcmToken.value=token;
}
void updateLanguageCode(String lanCode){
  languageCode.value=lanCode;
}
  Future getBookingReceiptById(String booking_id ,)  async{
    Future.microtask(()async{
      isLoading.value=true;
      Map<String, String> body = {
        'booking_id': booking_id,
      };
      var response = await DataApiService.instance
          .post('get-booking-by-id',body)
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      isLoading.value=false;
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        bookingReceipt.value =  ReceiptModel.fromJson(result['data']);
        String updatedAtString = bookingReceipt.value!.booking!.date.toString();

        // Parse the DateTime string
        DateTime updatedAt = DateTime.parse(updatedAtString);

        // Format date and time separately
        formattedDate.value = DateFormat('MMMM d, y').format(updatedAt); // Formats as "6/21/2024"
        formattedTime.value = DateFormat.jm().format(updatedAt);
        // formattedDate.value = bookingReceipt.value!.booking!.date.toString(); // Formats as "6/21/2024"
        // formattedTime.value =bookingReceipt.value!.booking!.time.toString(); // Formats as "10:33 AM"

        print('Date: $formattedDate');
        print('Time: $formattedTime');


      } else {
        // List<dynamic> errorMessages = result['message'];
        // String errorMessage = errorMessages.join();
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });
  }

  Future cancelBooking(String booking_id,String reason,int itemIndex,String userType,BuildContext context)  async{
    Future.microtask(()async{

      _baseController.showLoading('Cancel Loading...');
      Map<String, String> body = {
        'booking_id': booking_id,
        'reason': reason,
      };
      var response = await DataApiService.instance
          .post('cancel-booking',body)
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      _baseController.hideLoading();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        showCustomDialog(
            context,
            "assets/images/popup/success.png",
            Languages.of(context)!.appointmentsCancelledSuccessfully,
            Languages.of(context)!.yourAppointmentHasBeenCancelled,
            Languages.of(context)!.done, () {
          if(userType=='user'){
            selectedBookingList.removeAt(itemIndex);
            Get.to(() => UserBottomNavBar(),
              transition: Transition.rightToLeft,
            );
          }else{
            Get.to(() => BarberBottomNavBar(),
              transition: Transition.rightToLeft,
            );
          }
        }, null);

      } else {
        // List<dynamic> errorMessages = result['message'];
        // String errorMessage = errorMessages.join();
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });

  }

  Future getSelectedBookings()  async{
    Future.microtask(()async{
      isLoading.value=true;
      var response = await DataApiService.instance
          .get('get-all-bookings')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      isLoading.value=false;
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      // log(result.data);
      if (result['success']) {
        selectedBookingList.value = List<MainBookigModel>.from(
            result['data'].map((x) => MainBookigModel.fromJson(x)));

        canceledBookingList.value = selectedBookingList.where((e)=>e.status=='cancel').toList();
        completedBookingList.value=selectedBookingList.where((e)=>e.status=='complete').toList();
        activeBookingList.value=selectedBookingList.where((e)=>e.status=='start').toList();
        selectedBookingList.value = selectedBookingList.where((e)=>e.status=='pending').toList();

        print(activeBookingList.length.toString());
        print(selectedBookingList.length.toString()+"length of all appointments");
        print(completedBookingList.length.toString()+"length of completed app");
        // Get.to(() => UserBottomNavBar(),
        //   transition: Transition.rightToLeft,
        // );
        // Get.to(() => const OtpVerification());
      } else {
        // List<dynamic> errorMessages = result['message'];
        // String errorMessage = errorMessages.join();
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });

  }
  Future getUnSeenNotifications()  async{
    Future.microtask(()async{
      // _baseController.showLoading("Please Wait...");

      var response = await DataApiService.instance
          .get('get-unseen-notifications')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          // CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      // _baseController.hideLoading();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      // log(result.data);
      if (result['success']) {
        unSeenNotificationsList.value = List<UnseenNotificationsModel>.from(
            result['data'].map((x) => UnseenNotificationsModel.fromJson(x)));


      } else {
        // if(result['message']=='User UnAuthorized'){
        //   CustomDialog.showErrorDialog(description: "Please Contact Support",onTap: ()async{
        //     await authController.logoutUser("token");
        //     AuthPreference.instance.setUserLoggedIn(false,"barber");
        //   });
        // }else{
        //   CustomDialog.showErrorDialog(description: result['message'],);
        // }
      }
    });

  }

  Future updateNotifications()  async{
    Future.microtask(()async{
      isLoading.value=true;
      var response = await DataApiService.instance
          .post('update-notifications',{})
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      isLoading.value=false;
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      // log(result.data);
      if (result['success']) {
        // unSeenNotificationsList.value = List<UnseenNotificationsModel>.from(
        //     result['data'].map((x) => UnseenNotificationsModel.fromJson(x)));

      } else {
        // CustomDialog.showErrorDialog(description: result['message']);
      }
    });

  }

  Future getGuestAppointment() async {
    Future.microtask(()async{
      guestLoading.value=true;
      var response = await DataApiService.instance
          .get('user-guest-bookings').catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      guestLoading.value=false;
      if (response == null) return;

      print(response);
      var result = json.decode(response);
      if (result['success']) {
        guestUserList.value = List<GuestUserModel>.from(
            result['data'].map((x) => GuestUserModel.fromJson(x)));
        completedGuestUserAppointments.value = guestUserList.where((e)=>e.status=='complete').toList();
        // availableBarbers.value = List<BarbersModel>.from(
        //     result['data'].map((x) => BarbersModel.fromJson(x)));

      } else {
        // List<dynamic> errorMessages = result['message'];
        // String errorMessage = errorMessages.join('\n');
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });
  }
  Future createBooking(String barber_id ,String date,String selectedServicesTime,String services,String startTime,String endTime,)  async{

      _baseController.showLoading("Please Wait...");
      Map<String, String> body = {
        'barber_id': barber_id,
        'date': date,
        'time': selectedServicesTime,
        'services': services,
        'start_time': startTime,
        'end_time': endTime
      };
      var response = await DataApiService.instance
          .post('create-booking',body)
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      _baseController.hideLoading();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      String clientError=result['message'];
      if (result['success']) {
        createdBookingList.value =  CreatedBookingModel.fromJson(result['data']);
        String updatedAtString = createdBookingList.value!.updatedAt.toString();

        // Parse the DateTime string
        DateTime updatedAt = DateTime.parse(updatedAtString);

        // Format date and time separately
        formattedDate.value = DateFormat('MMMM d, y').format(updatedAt); // Formats as "6/21/2024"
        formattedTime.value = DateFormat.jm().format(updatedAt); // Formats as "10:33 AM"

        print('Date: $formattedDate');
        print('Time: $formattedTime');
        Get.to(()=> ReviewSummary(bookingId: createdBookingList.value!.id.toString()));

      } else {
        // if(clientError.contains('Client error:')){
        //
        // }
          Get.to(()=> UserBottomNavBar());
        print(result['message']);
        // CustomDialog.showErrorDialog(description: result['message']);
      }
  }
  Future getSlots(String barber_id,String date,String selectedServicesTime)  async{
    Future.microtask(()async{

     _baseController.showLoading('Please Wait...');
      Map<String, String> body = {
        'barber_id': barber_id,
        'date': date,
        'selected_services_time': selectedServicesTime
      };
      var response = await DataApiService.instance
          .post('get-slots',body)
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      _baseController.hideLoading();
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        barberSlotsList.value = List<BarberSlots>.from(
            result['data'].map((x) => BarberSlots.fromJson(x)));
        // Get.to(() => UserBottomNavBar(),
        //   transition: Transition.rightToLeft,
        // );
        // Get.to(() => const OtpVerification());
      } else {
        // List<dynamic> errorMessages = result['message'];
        // String errorMessage = errorMessages.join();
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });

  }
  Future getAvailableBarbers()  async{
    Future.microtask(()async{
      isLoading.value=true;
      var response = await DataApiService.instance
          .get('get-babers')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      isLoading.value=false;
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        barberDataList.value = List<BarbersModel>.from(
            result['data'].map((x) => BarbersModel.fromJson(x)));
        // Get.to(() => UserBottomNavBar(),
        //   transition: Transition.rightToLeft,
        // );
        // Get.to(() => const OtpVerification());
      } else {
        // List<dynamic> errorMessages = result['message'];
        // String errorMessage = errorMessages.join();
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });

  }
  Future getBarberServices(int id)  async{
    Future.microtask(()async{

      isLoading.value=true;
      Map<String, String> body = {
        'barber_id': id.toString(),
      };
      var response = await DataApiService.instance
          .post('get-services',body)
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      isLoading.value=false;
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        barberServicesList.value =  ServicesBarberModel.fromJson(result['data']);
        if(barberServicesList.value!.workingDays!.isNotEmpty){
          startDay.value=barberServicesList.value!.workingDays!.first.day.toString()+"-";
          endDay.value=barberServicesList.value!.workingDays!.last.day.toString()+" | ";
          startTime.value=barberServicesList.value!.workingDays!.first.from.toString()+"-";
          endTime.value=barberServicesList.value!.workingDays!.first.to.toString();
        }else{
          startDay.value="";
          endDay.value="";
          startTime.value="";
          endTime.value="";
        }

        // barberServicesList.value = List<ServicesBarberModel>.from(
        //     result['data'].map((x) => ServicesBarberModel.fromJson(x)));


        // Get.to(() => UserBottomNavBar(),
        //   transition: Transition.rightToLeft,
        // );
        // Get.to(() => const OtpVerification());
      } else {
        // List<dynamic> errorMessages = result['message'];
        // String errorMessage = errorMessages.join();
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });

  }
  Future getServices(int id)  async{
    Future.microtask(()async{
      barberSlotsList.clear();

print('booking detail');
      isLoading.value=true;
      Map<String, String> body = {
        'barber_id': id.toString(),
      };
      var response = await DataApiService.instance
          .post('get-services',body)
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      isLoading.value=false;
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {

        servicesList.value =  ServicesBarberModel.fromJson(result['data']);
        // servicesList.value = List<ServicesBarberModel>.from(
        //     result['data'].map((x) => ServicesBarberModel.fromJson(x)));
        // print(servicesList.length);
        // Get.to(() => UserBottomNavBar(),
        //   transition: Transition.rightToLeft,
        // );
        // Get.to(() => const OtpVerification());
      } else {
        // List<dynamic> errorMessages = result['message'];
        // String errorMessage = errorMessages.join();
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });

  }

  Future getBarberSideBookings()  async{
    Future.microtask(()async{
      isLoading.value=true;
      var response = await DataApiService.instance
          .get('get-barber-all-bookings')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          // CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      isLoading.value=false;
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        barberBookingList.value = List<MainBarberBookingModel>.from(
            result['data'].map((x) => MainBarberBookingModel.fromJson(x)));
        print(barberBookingList.length.toString()+'>>>>>>>all appointments');

        currentlyServingList.value = barberBookingList.where((e)=>e.status=='start').toList();
        cancelledBookingList.value = barberBookingList.where((e)=>e.status=='cancel').toList();
        barberCompletedBookingList.value= barberBookingList.where((e)=>e.status=='complete').toList();
        pendingAppointments.value=barberBookingList.where((e)=>e.status=='pending').toList();
        print(cancelledBookingList.length);
        print(pendingAppointments.length.toString()+'>>>>>>>pending');
        // print(barberBookingList.value[1].totalAmount.toString());
        // Get.to(() => UserBottomNavBar(),
        //   transition: Transition.rightToLeft,
        // );
        // Get.to(() => const OtpVerification());
      } else {
        // List<dynamic> errorMessages = result['message'];
        // String errorMessage = errorMessages.join();

        // if(result['message']=='User UnAuthorized'){
        //   CustomDialog.showErrorDialog(description: "Please Contact Support",onTap: ()async{
        //     await authController.logoutUser("token");
        //     AuthPreference.instance.setUserLoggedIn(false,"barber");
        //   });
        // }else{
        //   CustomDialog.showErrorDialog(description: result['message'],);
        // }
      }
    });

  }
  Future startAppointment(String bookingId,String status)  async{
    Future.microtask(()async{
      // barberSlotsList.clear();

      print('booking detail');
      isLoading.value=true;
      Map<String, String> body = {
        'booking_id': bookingId,
        'status': status,
        'Reason': ''
      };
      var response = await DataApiService.instance
          .post('change-booking-status',body)
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });

      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      isLoading.value=false;
      if (result['success']) {
        getBarberSideBookings();
        // timerController.updateSeconds(0);
        barberBookingList.value = List<MainBarberBookingModel>.from(
            result['data'].map((x) => MainBarberBookingModel.fromJson(x)));
        currentlyServingList.value = barberBookingList.where((e)=>e.status=='start').toList();
        cancelledBookingList.value = barberBookingList.where((e)=>e.status=='cancel').toList();
        print(currentlyServingList.length);

        // updateTimeDifference(startTime??'',endTime??'');

        getBarberSideBookings();
        // print(servicesList.length);
        // print(startedBookingList.value[1].id.toString()+"values is");
        // Get.to(() => UserBottomNavBar(),
        //   transition: Transition.rightToLeft,
        // );
        // Get.to(() => const OtpVerification());
      } else {
        // List<dynamic> errorMessages = result['message'];
        // String errorMessage = errorMessages.join();
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });

  }


  // void updateTimeDifference(String startTime, String endTime) {
  //   DateTime startDate = DateTime.parse("2024-07-03 $startTime:00");
  //   DateTime endDate = DateTime.parse("2024-07-03 $endTime:00");
  //
  //    differenceInSeconds.value = endDate.difference(startDate).inSeconds;
  //
  //   print('Total seconds between $startTime and $endTime: $differenceInSeconds');
  //   Timer.periodic(Duration(minutes: 1), (timer) {
  //     differenceInSeconds.value = endDate.difference(startDate).inSeconds;
  //
  //     print('Total seconds between $startTime and $endTime: $differenceInSeconds');
  //   });
  //   timerController.updateSeconds(differenceInSeconds.value);
  // }
  void updateTimeDifference(String startTime, String endTime) {
    DateTime startDate = DateTime.parse("2024-07-03 $startTime:00");
    DateTime endDate = DateTime.parse("2024-07-03 $endTime:00");

    differenceInSeconds.value = endDate.difference(startDate).inSeconds;

    print('Total seconds between $startTime and $endTime: ${differenceInSeconds.value}');

    timerController.stopTimer(); // Ensure any previous timer is stopped
    timerController.updateSeconds(differenceInSeconds.value); // Start the timer with the new difference

    // Periodically update the difference
    Timer.periodic(Duration(minutes: 1), (timer) {
      differenceInSeconds.value = endDate.difference(startDate).inSeconds;

      print('Updated seconds between $startTime and $endTime: ${differenceInSeconds.value}');
      if (differenceInSeconds.value <= 0) {
        timer.cancel();
      }
    });
  }

  Future shareFeedBack(String barberId,int rating,String reason,String feedBack,String bookingId,String notificationId)  async{
    Future.microtask(()async{
      _baseController.showLoading();
      Map<String, String> body = {
        'barber_id': barberId,
        'rating': rating.toString(),
        'reason': reason,
        'feedback': feedBack,
        'booking_id': bookingId,
        'notification_id': notificationId
      };
      var response = await DataApiService.instance
          .post('create-feedback',body)
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });

      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      _baseController.hideLoading();
      if (result['success']) {
        Get.back();
      print("FeedBack Created");
      } else {
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });

  }


  Future updateFcmNotificationToken(String fcmToken)  async{
    Future.microtask(()async{
      isLoading.value=true;
      Map<String, String> body = {
        'fcm_token': fcmToken
      };
      var response = await DataApiService.instance
          .post('update-fcm-token',body)
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          // CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });

      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      isLoading.value=false;
      if (result['success']) {
        print("notification updated");
      } else {
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });

  }
  Future getAllNotificationsUser()  async{
    Future.microtask(()async{
      isLoading.value=true;
      var response = await DataApiService.instance
          .get('get-all-notifications')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      isLoading.value=false;
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        userNotificationsList.value = List<UserNotificationsModel>.from(
            result['notifications'].map((x) => UserNotificationsModel.fromJson(x)));
        completedAppointmentsNotifications.value=userNotificationsList.where((e)=>e.booking.status=='complete' || e.booking.status=='cancel').toList();
        completedAppointmentsNotifications.value=userNotificationsList.value;
        // print(notificationsLength);
      } else {
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });

  }

  Future getAllNotificationsBarber()  async{
    Future.microtask(()async{
      isLoading.value=true;
      var response = await DataApiService.instance
          .get('get-all-notifications')
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      isLoading.value=false;
      if (response == null) return;
      print(response+ "responded");
      var result = json.decode(response);
      if (result['success']) {
        barberNotificationsList.value = List<BarberNotificationsModel>.from(
            result['notifications'].map((x) => BarberNotificationsModel.fromJson(x)));
      } else {
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });

  }
}

