import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/views/user/appointments/receipt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../localization/languages/languages.dart';
import '../../../widgets/card_widget.dart';
import '../../../widgets/custom_widgets.dart';

class AllCompletedAppointments extends StatefulWidget {
  AllCompletedAppointments({super.key});

  @override
  State<AllCompletedAppointments> createState() => _AllCompletedAppointmentsState();
}

class _AllCompletedAppointmentsState extends State<AllCompletedAppointments> {
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
          pageTitle: Languages.of(context)!.completedAppointments,
          onTapLeading: () {
            Get.back();
          },
        ),
      ),
      body: bookingController.completedBookingList.isNotEmpty? Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
        child:bookingController.isLoading==true?CircularProgressIndicator(                                                    color: AppColors.buttonColor,

        ) :Obx(
              ()=> ListView.builder(
                  // shrinkWrap: true,
                  itemCount: bookingController.completedBookingList.length,
                  // physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return  GestureDetector(
                        onTap: () {},
                        child: CardWidget(
                          locationImage:bookingController.completedBookingList[index].barber!.location.toString()=='null'?Container(): Image.asset("assets/icons/location_icon.png", scale: 9,color: AppColors.buttonColor,),
                          averageRating: bookingController.completedBookingList[index].averageRating.toString(),
                          showCancelButton: false,
                          appointmentStatus: Languages.of(context)!.completedAppointments,
                          image: bookingController.completedBookingList[index].barber!.image.toString() ?? '',
                          title: "",
                          name: bookingController.completedBookingList[index].barber!.name.toString(),
                          location:bookingController.completedBookingList[index].barber!.location.toString()=='null'?'': bookingController.completedBookingList[index].barber!.location.toString(),
                          services: bookingController.completedBookingList[index].services!.map((e){
                            return  bookingController.languageCode=='en'? e.userServices!.first.name ?? '':bookingController.languageCode=='pt'? e.userServices!.first.portugueseName ?? '':e.userServices!.first.frenchName ?? '';
                          }).toList().join(","),
                          appointmentCharges: bookingController.completedBookingList[index].totalAmount.toString(),
                          isActive: true,
                          onTapCancel: () {
                            // Get.to(
                            //         () => CancelAppointment(
                            //       bookingId: bookingController.completedBookingList[index].id.toString(),
                            //       bookingIndex: index,
                            //     ));
                            // print(bookingController.completedBookingList[index].id.toString());
                          },
                          onTapReceipt: () {
                            Get.to(() => ReceiptScreen(
                              isPaid: true,
                              bookingId: bookingController.completedBookingList[index].id.toString(),
                            ));
                          },
                        ));
                  }),
        ),
      ):Center(
        child: Text(Languages.of(context)!.noCompletedAppointments),
      ),
    );
  }
}
