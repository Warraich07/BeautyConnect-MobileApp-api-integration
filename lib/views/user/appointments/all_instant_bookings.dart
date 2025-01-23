import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/views/user/appointments/receipt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../localization/languages/languages.dart';
import '../../../widgets/card_widget.dart';
import '../../../widgets/custom_widgets.dart';

class AllInstantAppointments extends StatefulWidget {
  AllInstantAppointments({super.key});

  @override
  State<AllInstantAppointments> createState() => _AllInstantAppointmentsState();
}

class _AllInstantAppointmentsState extends State<AllInstantAppointments> {
  BookingController bookingController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingController.getSelectedBookings();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cardColor,
        title: CustomAppBar(
          pageTitle: Languages.of(context)!.instantBooking,
          onTapLeading: () {
            Get.back();
          },
        ),
      ),
      body:  bookingController.guestUserList.isNotEmpty? Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
        child:bookingController.isLoading==true?CircularProgressIndicator(
          color: AppColors.buttonColor,
        ) :Obx(
              ()=> ListView.builder(
                  // shrinkWrap: true,
                  itemCount: bookingController.guestUserList.length,
                  // physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: 4),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {},
                        child: CardWidget(
                          locationImage:bookingController.guestUserList[index].barber.location.toString()=='null'?Container():Image.asset("assets/icons/location_icon.png", scale: 9,color: AppColors.buttonColor,),
                          averageRating: bookingController.guestUserList[index].barber.averageRating.toString()=="null"?"0":bookingController.guestUserList[index].barber.averageRating.toString(),
                          appointmentStatus: Languages.of(context)!.canceled,
                          image: bookingController.guestUserList[index].barber.image.toString(),
                          title: "",
                          name: bookingController.guestUserList[index].barber.name.toString(),
                          isActive: true,
                          onTapCancel: () {
                            // Get.to(() => CancelAppointment(bookingId: bookingController.selectedBookingList[index].id.toString(),bookingIndex: index,));
                            // print(bookingController.selectedBookingList[index].id.toString());
                          },
                          onTapReceipt: () {
                            Get.to(() => ReceiptScreen(
                              isPaid: true,
                              bookingId: bookingController.guestUserList[index].id.toString(),
                            ));
                          },
                          appointmentCharges: bookingController.guestUserList[index].totalAmount.toString(),
                          location: bookingController.guestUserList[index].barber.location.toString()=='null'?''
                              :bookingController.guestUserList[index].barber.location.toString(),
                          services: bookingController.guestUserList[index].services.map((e) => e.userServices.first.name ).toList().join(","),
                        ));
                  }),
        ),
      ):Center(
        child: Text(Languages.of(context)!.noInstantBookings),
      ),
    );
  }
}
