import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/global_variables.dart';
import '../../../controllers/booking_controller.dart';
import '../../../controllers/general_controller.dart';
import '../../../guest_mode/utils/custom_dialogbox.dart';
import '../../../guest_mode/views/service_selection.dart';
import '../../../localization/languages/languages.dart';
import '../../../models/calender_model.dart';
import '../../../widgets/calender_widget.dart';
import '../../../widgets/card_widget.dart';
import '../../../widgets/custom_widgets.dart';

class ReBookAppointment extends StatefulWidget {
  final int index;
  final String? image;
  final String title;
  final String name;
  final bool isAddNew;

  const ReBookAppointment(
      {super.key, required this.image, required this.title, required this.name, this.isAddNew = false, required this.index});

  @override
  State<ReBookAppointment> createState() => _ReBookAppointmentState();
}

class _ReBookAppointmentState extends State<ReBookAppointment> {

  BookingController bookingController = Get.find();
  int selectedIndex = 0;
  List<int> selectedServices = [];
  List<String> bookingTime = [
    "10:00 AM",
    "10:20 AM",
    "10:40 AM",
    "11:00 AM",
    "11:20 AM",
    "11:40 AM",
  ];
  int selectedTime = -1;
  DateTime selectedDayDate = DateTime.now();
  DateTime firstDayDate = DateTime.utc(2000, 12, 18);
  DateTime lastDayDate = DateTime.utc(2090, 12, 18);
  String dayOfWeek = "";
  List<EventModel> events = [];
  GeneralController generalController=Get.find();
  void onTheDaySelected(DateTime day, DateTime focusedDay) {
    // var funcTag = "onTheDaySelected";
    bookingController.barberSlotsList.clear();
    setState(() {
      selectedDayDate = day;
      print(selectedDayDate);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bookingController.getServices(
      bookingController.barberDataList[widget.index].id,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cardColor,
        title: CustomAppBar(pageTitle: widget.isAddNew == false
            ? Languages.of(context)!.reBookAppointment
            :Languages.of(context)!.addNewBooking, onTapLeading: () {
          Get.back();
        },),
      ),
      body: Obx(

            () =>
        bookingController.isLoading.value == true ? Center(
          child: CircularProgressIndicator(
            color: AppColors.buttonColor,

          ),
        ) :
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 15,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Languages.of(context)!.selectServices, style: headingMedium,)),
                SizedBox(height: 10,),
                ListView.builder(
                  itemCount: bookingController.servicesList.value!.serviceCharges
                      .length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      _servicesList(bookingController.servicesList.value!
                          .serviceCharges[index].services!.first.image
                          .toString(),
                          bookingController.languageCode=='en'?
                          bookingController.servicesList.value!.serviceCharges[index].services!.first.name.toString():
                          bookingController.languageCode=='pt'?bookingController.servicesList.value!.serviceCharges[index].services!.first.portugueseName:
                          bookingController.servicesList.value!.serviceCharges[index].services!.first.frenchName,

                          bookingController.servicesList.value!
                          .serviceCharges[index].services!.first.time
                          .toString(), bookingController.servicesList.value!
                          .serviceCharges[index].services!.first.price
                          .toString(), index),
                ),

                // _servicesList("assets/icons/shaving.png", "Shaving", "20 mins", "25.00", 2),
                // _servicesList("assets/icons/facial.png", "Facial", "20 mins", "30.00", 3),
                // _servicesList("assets/icons/massage.png", "Massage", "10 mins", "10.00", 4),

                SizedBox(height: 15,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Languages.of(context)!.barber, style: headingMedium,)),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CardWidget(
                      title: bookingController.barberDataList[widget.index].saloonName??'',
                      services: bookingController.barberDataList[widget.index].serviceCharges.map((e) {
                        return  bookingController.languageCode=='en'? e.services.first.name ?? '':bookingController.languageCode=='pt'? e.services.first.portugueseName ?? '':e.services.first.frenchName ?? '';
                      }).toList().join(","),
                      locationImage:bookingController.barberDataList[widget.index].location.toString()=='null'?Container(): Image.asset("assets/icons/location_icon.png", scale: 9,color: AppColors.buttonColor),
                      averageRating: bookingController.barberDataList[widget.index].averageRating.toString(),
                      location: bookingController.barberDataList[widget.index].location,
                      image: bookingController.barberDataList[widget.index].image!,
                      name: bookingController.barberDataList[widget.index].name),
                ),
                SizedBox(height: 10,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Languages.of(context)!.appointmentDateAndTime,
                      style: headingMedium,
                    )),
                SizedBox(height: 10,),

                bookingController.calenderLoading.value == true
                    ? CircularProgressIndicator(
                  color: AppColors.buttonColor,
                )
                    : Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.cardColor,
                  ),

                      child: Column(
                                        children: [
                      CalenderWidget(selectedDayDate: selectedDayDate,
                          events: events,
                          onTheDaySelected: onTheDaySelected,
                          isWeeklyCalender: true),
                      SizedBox(height: 10,),
                      Wrap(
                        spacing: 5,
                        children: [
                          for (int i = 0; i <
                              bookingController.barberSlotsList.length; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTime = i;
                                  generalController.convert12To24HourFormat(bookingController.barberSlotsList[selectedTime].start,bookingController.barberSlotsList[selectedTime].end);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.greyText,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: selectedTime == i ? AppColors
                                          .buttonColor : Colors.transparent),
                                ),
                                child: Text(
                                  bookingController.barberSlotsList[i].start +
                                      '-' +
                                      bookingController.barberSlotsList[i].end,
                                  style: bodyMedium.copyWith(fontSize: 12),),
                              ),
                            ),

                        ],
                      ),


                                        ],
                                      ),
                    ),
                bookingController.barberSlotsList.isNotEmpty? SizedBox(
                  // width: 300,
                  child: DelayedDisplay(
                    delay: Duration(milliseconds: 1),
                    slidingBeginOffset: Offset(0, 1),
                    child: CustomButton(
                      textClr: AppColors.cardColor,
                      buttonText: Languages.of(context)!.instantBooking,
                      onTap: () {
                        Get.to(() => ServiceSelection(),
                            transition: Transition.rightToLeft);
                      },
                    ),
                  ),
                ):Container(),
                SizedBox(height: 15,),
                widget.isAddNew == false ? Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Languages.of(context)!.yourFeedBack,
                          style: headingMedium,
                        )),
                    SizedBox(height: 10,),
                    Container(
                      width: 100.w,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0.1,
                                blurRadius: 3,
                                offset: Offset(0, 0))
                          ]),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/cameron.png"),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        "Cameron Williamson",
                                        style: headingSmall,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "1 month ago",
                                style: bodySmall.copyWith(
                                    color: Colors.black54),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Lorem ipsum dolor sit amet consectetur. Proin faucibus imperdiet venenatis faucibus aliquet condimentum pretium.",
                            style:
                            bodySmall.copyWith(color: Colors.black54),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DelayedDisplay(
                                delay: Duration(milliseconds: 550),
                                slidingBeginOffset: Offset(0, 0),
                                child: RatingBar.builder(
                                  itemSize: 18,
                                  initialRating: 4,
                                  minRating: 1,
                                  ignoreGestures: true,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                                  itemBuilder: (context, _) =>
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "4.5",
                                style: headingSmall.copyWith(
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ) : SizedBox.shrink(),
                widget.isAddNew == false ? Container(
                  width: 100.w,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0.1,
                            blurRadius: 3,
                            offset: Offset(0, 0))
                      ]),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/images/cameron.png"),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "Cameron Williamson",
                                    style: headingSmall,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "1 month ago",
                            style: bodySmall.copyWith(
                                color: Colors.black54),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet consectetur. Proin faucibus imperdiet venenatis faucibus aliquet condimentum pretium.",
                        style:
                        bodySmall.copyWith(color: Colors.black54),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DelayedDisplay(
                            delay: Duration(milliseconds: 550),
                            slidingBeginOffset: Offset(0, 0),
                            child: RatingBar.builder(
                              itemSize: 18,
                              initialRating: 4,
                              minRating: 1,
                              ignoreGestures: true,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding:
                              EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) =>
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "4.5",
                            style: headingSmall.copyWith(
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ) : SizedBox.shrink(),
                SizedBox(height: 90,),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Obx(() {
        return Container(
          color: AppColors.cardColor,
          padding: EdgeInsets.fromLTRB(16, 2, 16, 15),
          child: CustomButton(
            textClr: AppColors.buttonTextColor,

            onTap: () async {
              if (selectedServices.isEmpty) {
                CustomDialog.showErrorDialog(description: Languages.of(context)!.pleaseSelectAnyService);

                // CustomDialogBox.showErrorDialog(context: context, description: Languages.of(context)!.pleaseSelectAnyService);
                return;
              }

              if (bookingController.barberSlotsList.isEmpty) {
                String serviceSlots = selectedServices.map((index) =>
                bookingController.servicesList.value!.serviceCharges[index]
                    .services!.first.time).toList().join(',');
                print(serviceSlots);
                await bookingController.getSlots(
                    bookingController.barberDataList[widget.index].id
                        .toString(),
                    DateFormat('yyyy-MM-dd').format(selectedDayDate),
                    serviceSlots);
                setState(() {

                });
                return;
              }
              if (selectedTime == -1) {
                CustomDialog.showErrorDialog(description: Languages.of(context)!.pleaseSelectAnyService);
                // CustomDialogBox.showErrorDialog(context: context, description: Languages.of(context)!.pleaseSelectAnySlot);
                return;
              }
              bookingController.createBooking(
                  bookingController.barberDataList[widget.index].id.toString(),
                  DateFormat('yyyy-MM-dd').format(selectedDayDate), '11:00 PM',
                  selectedServices.map((index) => bookingController
                      .servicesList.value!.serviceCharges[index].serviceId)
                      .toList()
                      .join(','),
                  generalController.startTime.value,
                  generalController.endTime.value

              );
            },
            buttonText: bookingController.barberSlotsList.isEmpty
                ? Languages.of(context)!.checkAvailableSlot
                : Languages.of(context)!.bookNow,
          ),
        );
      }),
    );
  }

  _servicesList(String icon, String title, String time, String charges,
      int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          bookingController.barberSlotsList.clear();
          if (selectedServices.contains(index)) {
            selectedServices.remove(index);
          } else {
            selectedServices.add(index);
          }
          selectedIndex = index;
        });
      },
      child: Container(

        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: EdgeInsets.fromLTRB(2, 2, 2, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.cardColor,
            boxShadow: [
              BoxShadow(color: Colors.black12,
                  spreadRadius: 0.1,
                  blurRadius: 3,
                  offset: Offset(0, 0))
            ]
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // CachedNetworkImage(height: 25, width: 25, imageUrl: icon,),
              SizedBox(width: 5,),
              Container(
                  width: MediaQuery.of(context).size.width*.25,
                  child: Text(title, style: headingSmall,
                )),
              Container(
                width: MediaQuery.of(context).size.width*.18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(Languages.of(context)!.servicesTime, style: bodySmall.copyWith(
                        color: Colors.white54, fontSize: 8),),
                    Text(time, style: bodySmall.copyWith(),),
                  ],
                ),
              ),
              VerticalDivider(
                width: 20,
                thickness: 1,
                color: Colors.white54,
              ),
              Container(
                width: MediaQuery.of(context).size.width*.22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Languages.of(context)!.servicesCharges, style: bodySmall.copyWith(
                        color: Colors.white54, fontSize: 8),),
                    Text("\$" + charges, style: bodySmall.copyWith(),),
                  ],
                ),
              ),
              Container(
                height: 15,
                width: 15,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.buttonColor),
                ),
                child: Icon(Icons.circle,
                  color: selectedServices.contains(index) ? AppColors
                      .buttonColor.withOpacity(0.5) : Colors.transparent,
                  size: 10,),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
