// ignore_for_file non_constant_identifier_names
import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  ///Common
  String get continueAsBarber;
  String get effortLessSaloon;
  String get pickYourDream;
  String get getStarted;
  String get alreadyHaveAccount;
  String get signIn;
  String get signInCapitalized;
  String get enterTheMobileNumber;
  String get youMayReceiveSms;
  String get agreeTo;
  String get  termsAndConditions;
  String get  and;
  String get  privacyPolicy;
  String get  CONTINUE;
  String get  alreadyHaveAnAccount ;
  String get verifyMobileNumber;
  String get  verifyEmailAddress;
  String get  weHaveSentFourDigitCodeOnMobile;
  String get  weHaveSentFourDigitCodeOnEmail;
  String get  didNotReceiveAnyCode;
  String get  resend;
  String get  verify;
  String get enterMobileNumber;
  String get phoneNumberIsRequired;
  String get phoneNumberShouldNotBeLessThanSix;
  String get error;
  String get pleaseCheckTermsAndConditions;
//   sign screen
  String get enterFollowingDetailsToSignIn;
  String get emailAddress;
  String get password;
  String get forgotPassword;
  String get doNotHaveAnAccount;
  String get signUp;
  String get emailIsRequired;
  String get pleaseEnterTheValidEmail;
  String get passwordIsRequired;
  String get newPasswordIsRequired;
  String get passwordShouldNotBeLessThanSix;
// signUp Screen
  String get enterFollowingDetailsToCompleteProfile;
  String get enterFollowingDetailsToCreateUser;
  String get uploadImage;
  String get fullName;
  String get confirmPassword;
  String get SIGNUP;
  String get userNameIsRequired;
  String get confirmPasswordIsRequired;
  String get confirmPasswordIsNotMatched;
//   forget password screen
  String get enterTheEmailAddressToGetCode;
  String get sendCode;
  String get continuee;
  String get forgetPassword;
//   reset password screen
  String get resetPassword;
  String get createNewPasswordForYourAccount;
  String get newPassword;
// user home screen
  String get welcome;
  String get yourUpComingAppointments;
  String get seeAll;
  String get cancelAppointments;
  String get youHaveNotBookedAnyAppointment;
  String get addNewBooking;
  String get bookAppointmentNow;
  String get yourCanceledAppointments;
  String get canceled;

  String get bookInQueue;
  String get completedAppointments;
  String get noCompletedAppointments;

//   add new booking screen
  String get chooseBarberToBookAppointment;
//   barber detail screen
  String get reviews;
  String get about;
  String get services;
  String get workingHours;
  String get bookAppointment;
  String get servicesTime;
  String get servicesCharges;
  // re book appointment
  String get reBookAppointment;
  String get selectServices;
  String get barber;
  String get appointmentDateAndTime;
  String get pleaseSelectAnyService;
  String get pleaseSelectAnySlot;
  String get checkAvailableSlot;
  String get bookNow;
//   review summary
  String get saloon;
  String get address;
  String get bookingDate;
  String get bookingTime;
  String get total;
  String get change;
  String get confirmPayment;
  String get appointmentBookedSuccessfully;
  String get congratulationsAppointmentSuccess;
  String get goToHome;
  String get viewEReceipt;
  // profile screen
  String get profile;
  String get edit;
  String get editPersonalInfo;
  String get editYourPersonalDetails;
  String get writeSomeThingAboutYou;
  String get saveChanges;
  String get changeImage;
//   setting screen
  String get settings;
  String get personalInfo;
  String get paymentMethods;
  String get changePassword;
  String get logout;
  String get deleteAccount;
  String get areYouSureYouWantToDelete;
  String get no;
  String get yes;
  String get areYouSureYouWantToLogout;
  String get oldPassword;
  String get passwordMustBeEightCharacters;
  // payment method screen
  String get otherWallets;
  String get remove;
  String get add;
  String get addNewPayment;
  String get areYouSure;
  String get areYouSureYouWantTRemove;
  String get fromThisAccount;
  String get yesRemove;

  String get enterFollowingDetailsToAddPaymentMethod;
  String get cardName;
  String get cardNumber;
  String get expiryDate;
  String get setAsDefault;
  String get addNew;
//   bottom bar
  String get home;
  String get appointments;
//   account created successfully
  String get accountCreatedSuccessfully;
  String get congratulationsYourAccountCreatedSuccessfully;
//   guest mode screen's strings
  String get instantBooking;
  String get serviceSelection;
  String get next;
  String get back;
  String get barberSelection;
  String get availableTime;
  String get proceedWithAny;
  String get customerDetails;
  // String get fullName;
  // String get emailAddress;
  // String get writeSomeThingAboutYou;
  // String get enterMobileNumber;
  //
  // String get userNameIsRequired;
  // String get emailIsRequired;
  String get pleaseEnterValidEmail;
  String get descriptionIsRequired;
  // String get phoneNumberIsRequired;
  String get phoneNumberShouldNotBeLessThanSixDigits;
//   bottom bar appointments
  String get active;
  String get completed;
  String get cancelled;
  // appointment page views
  String get noCancelledAppointments;
  String get noUpComingAppointments;
  String get instantBookings;
  String get noInstantBookings;
  // barber home screen
  String get yourNextAppointments;
  String get start;
  String get noAppointmentBookedYet;
  String get yourCancelledAppointments;
  String get appointmentsCancelled;
  String get appointmentsCancelledSuccessfully;
  String get yourAppointmentHasBeenCancelled;
  String get done;
  String get noAppointmentCancelledYet;
  String get timeLeft;
  String get currentlyServing;
  String get appointmentCharges;
  String get appointmentTime;
  String get cancelAppointment;
  String get completeAppointment;
// barber cancel appointment
  String get scheduleChange;
  String get emergency;
  String get parkingAvailability;
  String get lackOfAmenities;
  String get iHaveAlternativeOption;
  String get other;
  String get chooseReasonForCancellation;
  String get enterYourReason;
// barber setting screen
  String get editYourServiceAndCharges;
  String get chooseTheServicesAndAddCharges;
  String get addServicesCharges;
  String get editYourWorkingHours;
  String get addYourWorkingAvailability;
  String get orders;
  String get upcomingAppointments;
  String get cancelledAppointments;


  String get guest;
  String get appointmentCompleted;
  String get youCanStartOnlyOneAppointmentAtATime;
  String get customer;
  String get walkInCustomer;
  String get normalUser;
  String get areYouSureYouWantToCompleteThisOrder;
  String get yesComplete;
  String get noActiveOrders;
  String get noCompletedOrders;
  String get allAppointments;
  String get yourFeedBack;
  String get enterYourFeedBack;
  String get reviewSummary;
  String get appointmentEReceipt;
  String get shareFeedback;
  String get cancel;
  String get submit;
  String get youHaveAlreadyBookedAnInstantBooking;
  String get notifications;
  String get confirmCompletion;
  String get areYouSureYouWantToConfirmCompletionOfThisAppointment;
  String get yesConfirm;
  String get pleaseSelectTheImage;
  String get completeProfile;
  String get pleaseCompleteYourProfile;
  String get pleaseContactSupport;
  String get notNotificationsYet;
  String get  resendCodeIn;
  String get pleaseEnterPhoneNumber;
  String get pleaseEnterValidPhoneNumber;
  String get oldPasswordIsRequired;
  String get norBarberAvailableForRequiredService;
  String get guestUserHasBookedAppointment;









}
