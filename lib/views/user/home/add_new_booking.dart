import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:beauty_connect/views/user/home/barber_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/card_widget.dart';
import '../../../widgets/custom_widgets.dart';

class AddNewBooking extends StatefulWidget {
  final String pageTitle;
  final List<String> name;
  final List<String> images;
  final List<String> titles;
  const AddNewBooking(
      {super.key,
      required this.images,
      required this.titles,
      required this.pageTitle,
      required this.name});

  @override
  State<AddNewBooking> createState() => _AddNewBookingState();
}

BookingController bookingController = Get.find();
class _AddNewBookingState extends State<AddNewBooking> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingController.getAvailableBarbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: AppColors.cardColor,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: widget.pageTitle,
          onTapLeading: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
            ()=> bookingController.isLoading==true? Center(child: CircularProgressIndicator(
              color: AppColors.buttonColor,
            )):
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Languages.of(context)!.chooseBarberToBookAppointment,
                    style: headingSmall,
                  )),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: bookingController.barberDataList.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Get.to(() => BarberDetail(
                                    // images: widget.images,
                                    titles: widget.titles,
                                    name: widget.name,
                                    index: index,
                                  ));
                            },
                            child: CardWidget(
                              locationImage:bookingController.barberDataList[index].location.toString()=='null'||bookingController.barberDataList[index].location.toString().isEmpty?Container(): Image.asset("assets/icons/location_icon.png", scale: 9,color: AppColors.buttonColor,),
                              averageRating:bookingController.barberDataList[index].averageRating.toString() ,
                              location: bookingController.barberDataList[index].location??'',
                              image: bookingController.barberDataList[index].image??'',
                              title: bookingController.barberDataList[index].saloonName??'',
                              name: bookingController.barberDataList[index].name,
                              // services: "sajdj",
                              services: bookingController.barberDataList[index].serviceCharges.map((e){
                                return  bookingController.languageCode=='en'? e.services.first.name ?? '':bookingController.languageCode=='pt'? e.services.first.portugueseName ?? '':e.services.first.frenchName ?? '';

                              }).toList().join(","),
                            ));
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
