import 'dart:convert';

import 'package:beauty_connect/controllers/auth_controller.dart';
import 'package:beauty_connect/guest_mode/models/barbers_model.dart';
import 'package:beauty_connect/guest_mode/models/services_model.dart';
import 'package:beauty_connect/guest_mode/views/ticket_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/guest_user_model.dart';
import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../utils/custom_dialogbox.dart';
import '../views/ticket_details.dart';
import 'base_controller.dart';

class GuestController extends GetxController{
  RxBool isLoading =false.obs;
  RxString accessToken = "".obs;
  Rxn<int> barberId = Rxn<int>();
  RxList<ServicesModel> serviceList = <ServicesModel>[].obs;
  RxList<ServicesModel> selectedServices = <ServicesModel>[].obs;
  RxList<BarbersModel> availableBarbers=<BarbersModel>[].obs;
  RxList<GuestUserModel> guestUserList=<GuestUserModel>[].obs;
  final BaseController _baseController = BaseController.instance;
  RxString ticketUrl=''.obs;
  AuthController authController=Get.find();
  Future getUserServices() async {
    isLoading.value=true;
    var response = await DataApiService.instance
        .get(
      'get-services-for-guest',
    )
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    isLoading.value=false;
    if (response == null) return;

    print(response);
    var result = json.decode(response);
    if (result['success']) {
      serviceList.value = List<ServicesModel>.from(
          result['data'].map((x) => ServicesModel.fromJson(x)));

    } else {
      // List<dynamic> errorMessages = result['message'];
      // String errorMessage = errorMessages.join('\n');
      CustomDialog.showErrorDialog(description: result['message']);
    }
  }
  Future getAvailableBarbers() async {
    Future.microtask(()async{
      isLoading.value=true;
      var response = await DataApiService.instance
          .post(
          'get-babers-for-guest?service_ids=${selectedServices.map((e){
            return e.id.toString();
          }
          ).toList().join(",")}',{}
      )
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      isLoading.value=false;
      if (response == null) return;

      print(response);
      var result = json.decode(response);
      if (result['success']) {
        availableBarbers.value = List<BarbersModel>.from(
            result['data'].map((x) => BarbersModel.fromJson(x)));


      } else {
        // List<dynamic> errorMessages = result['message'];
        // String errorMessage = errorMessages.join('\n');
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });
  }
  Future createGuestAppointment() async {
    Future.microtask(()async{
      Map<String,String> body={
        'services': selectedServices.map((e){return e.id.toString();}).toList().join(","),
        // 'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'barber_id': barberId.value.toString(),
        'user_id': authController.userData.value!.id.toString(),
        // 'email': email,
        // 'phone': phoneNumber.removeAllWhitespace.replaceAll('-', ''),
        // 'description': '',
        if(barberId.value!=null)
        'barber_id':barberId.toString()
      };
      print(body);
      _baseController.showLoading('Adding Customer');
      var response = await DataApiService.instance
          .post('create-guest-booking',body).catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
      _baseController.hideLoading();
      if (response == null) return;

      print(response);
      var result = json.decode(response);
      if (result['success']) {
        ticketUrl.value=result['e_ticket_url'];
        Get.to(()=> TicketWebView(), transition: Transition.rightToLeft);
        // availableBarbers.value = List<BarbersModel>.from(
        //     result['data'].map((x) => BarbersModel.fromJson(x)));

      } else {
        // List<dynamic> errorMessages = result['message'];
        // String errorMessage = errorMessages.join('\n');
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });
  }

  Future getGuestAppointment() async {
    Future.microtask(()async{
     isLoading.value=true;
      var response = await DataApiService.instance
          .get('user-guest-bookings').catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          CustomDialog.showErrorDialog(description: apiError["reason"]);
        } else {}
      });
     isLoading.value=false;
      if (response == null) return;

      print(response);
      var result = json.decode(response);
      if (result['success']) {
        guestUserList.value = List<GuestUserModel>.from(
            result['data'].map((x) => GuestUserModel.fromJson(x)));
        // availableBarbers.value = List<BarbersModel>.from(
        //     result['data'].map((x) => BarbersModel.fromJson(x)));

      } else {
        // List<dynamic> errorMessages = result['message'];
        // String errorMessage = errorMessages.join('\n');
        CustomDialog.showErrorDialog(description: result['message']);
      }
    });
  }
}