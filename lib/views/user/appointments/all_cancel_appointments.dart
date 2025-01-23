import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/views/user/appointments/receipt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../localization/languages/languages.dart';
import '../../../widgets/card_widget.dart';
import '../../../widgets/custom_widgets.dart';

class AllCancelAppointments extends StatefulWidget {
   AllCancelAppointments({super.key});

  @override
  State<AllCancelAppointments> createState() => _AllCancelAppointmentsState();
}

class _AllCancelAppointmentsState extends State<AllCancelAppointments> {
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
          pageTitle: Languages.of(context)!.cancelAppointments,
          onTapLeading: () {
            Get.back();
          },
        ),
      ),
      body: bookingController.canceledBookingList.isNotEmpty? Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
        child:bookingController.isLoading==true?CircularProgressIndicator(                                                    color: AppColors.buttonColor,

        ) :Obx(
              ()=> ListView.builder(

              itemCount: bookingController.canceledBookingList.length,
              // physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 4),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {},
                    child: CardWidget(
                      paddingForServices:0,

                      averageRating: bookingController.canceledBookingList[index].averageRating.toString(),
                      isCancelled: true,
                      // reasonOfCancellation: "dasda",
                      reasonOfCancellation: bookingController.canceledBookingList[index].reason.toString()=='null'?"":bookingController.canceledBookingList[index].reason.toString(),
                      locationImage:bookingController.canceledBookingList[index].barber!.location.toString()=='null'?Container(): Image.asset("assets/icons/location_icon.png", scale: 9,color: AppColors.buttonColor,),
                      appointmentStatus:
                      Languages.of(context)!
                          .canceled,
                      image: bookingController
                          .canceledBookingList[
                      index]
                          .barber!
                          .image
                          .toString(),
                      title: "",
                      name: bookingController
                          .canceledBookingList[
                      index]
                          .barber!
                          .name
                          .toString(),
                      isActive: true,
                      onTapCancel: () {
                        // Get.to(() => CancelAppointment(bookingId: bookingController.selectedBookingList[index].id.toString(),bookingIndex: index,));
                        // print(bookingController.selectedBookingList[index].id.toString());
                      },
                      onTapReceipt: () {
                        Get.to(() => ReceiptScreen(
                          isPaid: true,
                          bookingId:
                          bookingController
                              .canceledBookingList[
                          index]
                              .id
                              .toString(),
                        ));
                      },
                      appointmentCharges:
                      bookingController
                          .canceledBookingList[
                      index]
                          .totalAmount
                          .toString(),
                      location:bookingController.canceledBookingList[index].barber!.location.toString()=='null'?'': bookingController
                          .canceledBookingList[
                      index]
                          .barber!
                          .location
                          .toString(),
                      services: bookingController
                          .canceledBookingList[
                      index]
                          .services!.map((e){
                        return  bookingController.languageCode=='en'? e.userServices!.first.name ?? '':bookingController.languageCode=='pt'? e.userServices!.first.portugueseName ?? '':e.userServices!.first.frenchName ?? '';

                      })
                          .toList()
                          .join(","),
                    ));
              }),
        ),
      ):Center(
        child: Text(Languages.of(context)!.noCancelledAppointments,style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
