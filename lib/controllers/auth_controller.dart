import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:beauty_connect/controllers/general_controller.dart';
import 'package:beauty_connect/views/auth/welcome_screen.dart';
import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:beauty_connect/models/barbers_model.dart';
import 'package:beauty_connect/models/user_model.dart';
import 'package:beauty_connect/utils/shared_preference.dart';
import 'package:beauty_connect/views/auth/barber/complete_profile.dart';
import 'package:beauty_connect/views/auth/reset_password.dart';
import 'package:beauty_connect/views/auth/sign_up_user.dart';
import 'package:beauty_connect/views/user/home/add_new_booking.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../api_services/api_exceptions.dart';
import '../api_services/data_api.dart';
import '../api_services/local_ntofications.dart';
import '../utils/custom_dialogbox.dart';
import '../views/auth/signin_screen.dart';
import '../views/auth/verify_otp.dart';
import '../views/barber/home/barber_bottom_nav_bar.dart';
import '../views/user/home/user_bottom_nav_bar.dart';
import '../widgets/custom_dialog.dart';
import 'base_controller.dart';

class AuthController extends GetxController {

  final AuthPreference _authPreference = AuthPreference.instance;
  RxString accessToken = "".obs;
  String? uploadImageUrlServiceProvider;
  String? uploadImageUrlHomeOwner;
  File? uploadImageFileServiceProvider;
  File? uploadImageFileCustomer;
  final picker = ImagePicker();
  XFile? pickedImage;
  Rxn<UserModel> userData=Rxn<UserModel>();
  Rxn<BarbersModel> barberData=Rxn<BarbersModel>();
  final BaseController _baseController = BaseController.instance;
  RxString otp = ''.obs;
  RxString userEmail=''.obs;
  RxString forgetPasswordEmailUser=''.obs;
  RxString forgetPasswordEmailBarber=''.obs;
  RxString verifyOtp=''.obs;
  RxString phone=''.obs;
  RxString countryCode=''.obs;
  RxString profileStatus='3'.obs;
  RxInt barberID=0.obs;
  GeneralController generalController=Get.find();
  RxBool isLoading=false.obs;
  NotificationsServices notificationsServices = NotificationsServices();
  RxString fcmToken=''.obs;
  RxString barberEmail=''.obs;
  RxString barberPassword=''.obs;
  RxString token=''.obs;
  RxString barberStatus=''.obs;

   saveBarberCredentials(String email,String password)async{
    barberEmail.value=email;
    barberPassword.value=password;
  }

  getFcmToken()async{
     token.value=await FirebaseMessaging.instance.getToken().toString();
    print(token+"this is fcm token");
  }

  Future verifyOtpCode() async {
    _baseController.showLoading();
    Map<String, String> body = {
      'phone': phone.value,
      'otp': verifyOtp.value
    };
    print(body);
    var response = await DataApiService.instance
        .post('verify-otp', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;

    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      Get.to(SignUpUser());
    } else {
      List<dynamic> errorMessages = result['message'];
      String errorMessage = errorMessages.join();
      CustomDialog.showErrorDialog(description: errorMessage);
    }
  }

  Future resetPassword(String newPassword,String confirmPassword) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'password': newPassword,
      'confirm_password': confirmPassword,
      'email': userEmail.value,
    };
    var response = await DataApiService.instance
        .post('reset-password', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;

    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      // print("Password Changed");
      HapticFeedback.heavyImpact();
      Get.to(()=>SignInScreen(isUser: true));

    } else {
      List<dynamic> errorMessages = result['message'];
      String errorMessage = errorMessages.join();
      CustomDialog.showErrorDialog(description: errorMessage);
    }
  }

  Future verifyForgetPasswordCode() async {
    _baseController.showLoading();
    Map<String, String> body = {
      'otp': verifyOtp.value,
      'email': userEmail.value,
    };
    var response = await DataApiService.instance
        .post('verify-forgot-password', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      print("OTP Verified");
      HapticFeedback.heavyImpact();
      Get.to(()=>ResetPassword(email: userEmail.value,isUser: true,));
    } else {
      String errorMessages = result['message'];
      CustomDialog.showErrorDialog(description: errorMessages);
    }
  }

  Future sendForgetPasswordCode(String email) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'email': email,
    };
    var response = await DataApiService.instance
        .post('forgot-password', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      userEmail.value=email;
      forgetPasswordEmailUser.value=email;
      print("password reset code send to your email");
      HapticFeedback.heavyImpact();
      Get.to(() => VerifyOTP(email: '',fromSignUp: false,isUser: true,),
        transition: Transition.rightToLeft,
      );
    } else {
      String errorMessages = result['message'];
      CustomDialog.showErrorDialog(description: errorMessages);
    }
  }

  Future updateUserProfile(context,String name,String email,String phone,String countryCode,String userId) async {
    // isLoading.value=true;
    _baseController.showLoading();
    Map<String, String> body = {
      'name': name,
      'email': email,
      'phone': phone,
      'country_code': countryCode,
      'user_id': userId
    };

    var response = await DataApiService.instance
        .multiPartImage('update-profile', [uploadImageFileCustomer==null?null:uploadImageFileCustomer!.path.toString()],"image",body,).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    _baseController.hideLoading();
    // isLoading.value=false;

    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      userData.value!.image=result['data']['image'].toString();
      userData.value!.name=result['data']['name'].toString();
      userData.value!.email=result['data']['email'].toString();
      userData.value!.phone=result['data']['phone'].toString();
      userData.value!.countryCode=result['data']['country_code'].toString();
      // generalController.onBottomBarTapped(0);
      generalController.onBottomBarTapped(0);
      Get.offAll(() => UserBottomNavBar(),
        transition: Transition.leftToRight,
      );
      Get.back();

    } else {
      List<dynamic> errorMessages = result['message'];
      String errorMessage = errorMessages.join();
      CustomDialog.showErrorDialog(description: errorMessage);
    }
  }

  Future changePassword(String oldPassword,String newPassword,String confirmNewPassword,bool isUser) async {
    _baseController.showLoading();
    isLoading.value=true;
    Map<String, String> body = {
      'current_password': oldPassword,
      'new_password': newPassword,
      'new_password_confirmation': confirmNewPassword
    };
    var response = await DataApiService.instance
        .post('change-password',body)
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

    isLoading.value=false;
    if (result['success']) {
      print(isUser);
      if(isUser==true){
        AuthPreference.instance.setUserLoggedIn(false,"user");
        Get.offAll(() => SignInScreen(isUser: true,));
      }else{
        AuthPreference.instance.setUserLoggedIn(false,"barber");
        Get.offAll(() => SignInScreen(isUser: false,));
      }
      // print("password changed successfully");

    } else {
      CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  Future deleteAccount() async {
    _baseController.showLoading();
    var response = await DataApiService.instance
        .delete('delete-user',)
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
      Get.to(()=>WelcomeScreen());
      // print("user deleted successfuly");
    } else {
      CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  Future logoutUser(String token) async {
    _baseController.showLoading();
    Map<String, String> body = {};
    var response = await DataApiService.instance
        .post('logout-user', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
     print("logout successful");
    } else {
      CustomDialog.showErrorDialog(description: result['message']);
    }
  }

  Future sendCode(String phoneNumber) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'phone': countryCode.value+phoneNumber,
    };
    var response = await DataApiService.instance
        .post('send-otp', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;

    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      phone.value=phoneNumber;
      otp.value = result['data']['otp'].toString();
      print(otp);
      print(phone.value);
      HapticFeedback.heavyImpact();
        Get.to(() => VerifyOTP(email: '',fromSignUp: true,isUser: true,),
          transition: Transition.rightToLeft,
        );
    } else {
      List<dynamic> errorMessages = result['message'];
      String errorMessage = errorMessages.join();
      CustomDialog.showErrorDialog(description: errorMessage);
    }
  }
  Future loginUser(String email,String password) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'email': email,
      'password':password,
      'fcm_token': bookingController.fcmToken.value
    };
    var response = await DataApiService.instance
        .post('login-user', body)
        .catchError((error) {
      if (error is BadRequestException) {

        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {
        print("not logged in");
      }
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;

    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      userData.value=UserModel.fromJson(result['data']);
      accessToken.value=result['token'];
      print(accessToken.value);
      _authPreference.saveUserDataToken(token: accessToken.value);
      _authPreference.setUserLoggedIn(true,"user");
      _authPreference.saveUserData(token: jsonEncode(userData.value!.toJson()));
      Get.offAll(() => UserBottomNavBar(),
        transition: Transition.rightToLeft,
      );
    } else {
      CustomDialog.showErrorDialog(description: result['message']);
    }
  }
  Future registerUser(context,String name,String email,String phone,String countryCode,String password) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'country_code': countryCode,
    };
    var response = await DataApiService.instance
        .multiPartImage('register-user', [pickedImage!.path.toString()],"image",body,).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);

        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;

    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      notificationsServices.getDeviceToken().then((value) {
        // log(value.toString());
        bookingController.updateFcmNotificationToken(value.toString());
      });
      userData.value=UserModel.fromJson(result['data']);
      accessToken.value=result['token'];
      // _authPreference.saveUserDataToken(token: accessToken.value);
      // _authPreference.setUserLoggedIn(true,"user");
      // _authPreference.saveUserData(token: jsonEncode(userData.value!.toJson()));
      Get.offAll(()=>SignInScreen(isUser: true));
      showCustomDialog(context, "assets/images/popup/success.png", Languages.of(context)!.accountCreatedSuccessfully, Languages.of(context)!.congratulationsYourAccountCreatedSuccessfully, Languages.of(context)!.CONTINUE, (){Get.back();}, null);
    } else {
      String errorMessages = result['message'];
      CustomDialog.showErrorDialog(description: errorMessages);
    }
  }

  Future uploadProfileImage(String inputSource, from) async {
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera' ? ImageSource.gallery : ImageSource.camera,
               maxWidth: 1920);
      // pickedImagePath=pickedImage!.path.toString() as List;
      print("pickedImage");
      print(pickedImage!.path.toString());
      if (from == "user") {
        uploadImageFileCustomer = File(pickedImage!.path);
        uploadImageUrlHomeOwner = pickedImage!.path;

      } else {
        uploadImageFileServiceProvider = File(pickedImage!.path);
        uploadImageUrlServiceProvider = pickedImage!.path;
      }
    } catch (err) {
      if (kDebugMode) {
        // print(err);
      }
    }
  }

  Future loginBarber(String email,String password) async {
    _baseController.showLoading();
    notificationsServices.getDeviceToken().then((value) {
      log(value.toString());
      fcmToken.value=value;
    });
    Map<String, String> body = {
      'email': email,
      'password':password,
      'fcm_token': fcmToken.value
    };
    var response = await DataApiService.instance
        .post('sign-in', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      profileStatus.value=result['message'];
      if(profileStatus.value=='Please Complete your profile'){
        barberID.value=result['user_id'];
        print(barberID.toString);
        CustomDialog.showErrorDialog(buttonText: "Complete Profile",description: "Please Complete your profile",onTap: (){
          generalController.updateUserType(false);
          Get.offAll(() => CompleteProfile());
        });
      }
      else if(profileStatus.value!='Please Complete your profile'){
        barberData.value=BarbersModel.fromJson(result['data']);
        profileStatus.value=result['message'];
        accessToken.value=result['token']??'';
        barberStatus.value=result['data']['status'];
            // print();
        if(barberStatus=='1'){
          _authPreference.saveUserDataToken(token: accessToken.value);
          _authPreference.setUserLoggedIn(true, "barber");
          _authPreference.saveUserData(token: jsonEncode(barberData.value!.toJson()));
          Get.offAll(() => BarberBottomNavBar());
        }else{
          CustomDialog.showErrorDialog(description: "Please Contact support");
        }

      }
    } else {
      CustomDialog.showErrorDialog(description: result['message']);
    }
  }


  Future sendForgetPasswordCodeToBarber(String email) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'email': email,
    };
    var response = await DataApiService.instance
        .post('barber-forgot-password', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;

    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      userEmail.value=email;
      // phone.value=phoneNumber;
      forgetPasswordEmailBarber.value=email;

      otp.value = result['otp'].toString();
      // print(otp);
      // print("password reset code send to your email");
      HapticFeedback.heavyImpact();
      Get.to(() => VerifyOTP(email: '',fromSignUp: false,isUser: false,),
        transition: Transition.rightToLeft,
      );
    } else {
      // List<dynamic> errorMessages = result['message'];
      // String errorMessage = errorMessages.join();
      CustomDialog.showErrorDialog(description: result['message']);
    }
  }
  Future verifyBarberForgetPasswordCode() async {
    _baseController.showLoading();
    Map<String, String> body = {
      'otp': otp.value,
      'email': userEmail.value,
    };
    var response = await DataApiService.instance
        .post('barber-verify-otp', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;

    print(response+ "responded");
    var result = json.decode(response);
    if (result['success']) {
      HapticFeedback.heavyImpact();
      Get.to(()=>ResetPassword(email: userEmail.value,isUser: false,));
    } else {
      List<dynamic> errorMessages = result['message'];
      String errorMessage = errorMessages.join();
      CustomDialog.showErrorDialog(description: errorMessage);
    }

  }

  Future resetBarberPassword(String newPassword,String confirmPassword) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'password': newPassword,
      'password_confirmation': confirmPassword,
      'email': userEmail.value,
    };
    var response = await DataApiService.instance
        .post('barber-reset-password', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);

    if (result['success']) {
      // print("Password Changed");
      HapticFeedback.heavyImpact();
      Get.to(()=>SignInScreen(isUser:false));
    } else {
      List<dynamic> errorMessages = result['message'];
      String errorMessage = errorMessages.join();
      CustomDialog.showErrorDialog(description: errorMessage);
    }

  }

  Future updateBarberProfile(context,String bio,String location) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'user_id': barberID.value.toString(),
      'bio': bio,
      'location': location,
      'lat': '1212',
      'long': '12112'
    };
    var response = await DataApiService.instance.multiPartImage('update-barber-profile', [pickedImage!.path.toString()],"image",body,).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(description: apiError["reason"]);
      } else {}
    });
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response+ "responded");
    var result = json.decode(response);

    if (result['success']) {
      generalController.onBottomBarTapped(0);
      Get.offAll(()=>BarberBottomNavBar());
      loginBarber(barberEmail.value.toString(), barberPassword.value.toString());
    } else {
     String errorMessages = result['message'];
      CustomDialog.showErrorDialog(description: errorMessages);
    }

  }
}
