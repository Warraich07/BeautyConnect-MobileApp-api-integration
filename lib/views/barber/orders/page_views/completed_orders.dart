import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../constants/global_variables.dart';
import '../../../user/home/add_new_booking.dart';

class CompletedOrders extends StatefulWidget {
  const CompletedOrders({super.key});

  @override
  State<CompletedOrders> createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return bookingController.barberCompletedBookingList.isNotEmpty? Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: bookingController.barberCompletedBookingList.length,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16, 15, 16, 0),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Get.to(() => OrderDetail(
                    //   selectedIndex: selectedIndex,
                    //   pageTitle: name[index],
                    //   title: name[index],
                    //   name: name[index],
                    // ));
                  },
                  child: Container(
                    width: 100.w,
                    height:  selectedIndex == 0 ?105 : 110,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(0, 12, 0, 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColors.cardColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 0.1,
                              blurRadius: 3,
                              offset: Offset(0, 0))
                        ]),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            bookingController.barberCompletedBookingList[index].getUser==null?
                                            bookingController.barberCompletedBookingList[index].guestUser!.username.toString():
                                            bookingController.barberCompletedBookingList[index].getUser!.name.toString(),
                                            style: headingSmall,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                bookingController.barberCompletedBookingList[index].services!.map((e){
                                                  return  bookingController.languageCode=='en'? e.userServices!.first.name ?? '':bookingController.languageCode=='pt'? e.userServices!.first.portugueseName ?? '':e.userServices!.first.frenchName ?? '';

                                                }).toList().join(","),
                                                style: headingSmall.copyWith(fontSize: 10),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 20.w,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 8,),
                                                Text(
                                                  Languages.of(context)!.barber,
                                                  style: bodySmall.copyWith(color: AppColors.buttonColor, fontSize: 8),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(bookingController
                                                    .barberCompletedBookingList
                                                    [index]
                                                    .barber!
                                                    .name
                                                    .toString(),
                                                    style: bodyMedium.copyWith(fontSize: 8),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  VerticalDivider(
                                                    width: 2,
                                                    thickness: 1,
                                                    color: Colors.white54,
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 10),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            Languages.of(context)!.appointmentCharges,
                                                            style: bodySmall.copyWith(color: AppColors.buttonColor, fontSize: 8),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Expanded(
                                                            child: Text("\$ "+bookingController.barberCompletedBookingList[index].totalAmount.toString(),
                                                                style: bodyMedium.copyWith(fontSize: 8),
                                                                overflow: TextOverflow.ellipsis,
                                                                maxLines: 1),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  VerticalDivider(
                                                    width: 2,
                                                    thickness: 1,
                                                    color: Colors.white54,
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 10),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            Languages.of(context)!.customer,
                                                            style: bodySmall.copyWith(color: AppColors.buttonColor, fontSize: 8),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Expanded(
                                                            child: Text(bookingController.barberCompletedBookingList[index].getUser==null?
                                                            Languages.of(context)!.walkInCustomer:Languages.of(context)!.normalUser,

                                                                style: bodyMedium.copyWith(fontSize: 8),
                                                                overflow: TextOverflow.ellipsis,
                                                                maxLines: 1),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    selectedIndex == 0? Row(
                                      children: [
                                        Container()
                                        // Text("Time Left: ", style:  bodyMedium.copyWith(fontSize: 8),
                                        //   overflow: TextOverflow.ellipsis,
                                        //   maxLines: 1,),
                                        // Text("10 mins", style:  bodyMedium.copyWith(fontSize: 8, color: AppColors.buttonColor),
                                        //   overflow: TextOverflow.ellipsis,
                                        //   maxLines: 1,),
                                      ],
                                    ) : Row(
                                      children: [

                                        Text(Languages.of(context)!.completed, style:  bodyMedium.copyWith(fontSize: 10, color: AppColors.buttonColor),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(Languages.of(context)!.completed,
                                style: bodyMedium.copyWith(fontSize: 8,color:AppColors.buttonColor),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2),
                          ],
                        )
                        // selectedIndex == 0 ?
                        // Expanded(
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //           child: ZoomTapAnimation(
                        //             onTap: (){
                        //               // showCustomDialog(context, "assets/images/popup/ask.png", "Are you sure?", "Are you sure that you want to complete this walk-in customer order.", "Yes, Complete", (){Get.offAll(()=> BarberBottomNavBar());}, null);
                        //
                        //             },
                        //             child: Container(
                        //                 padding: const EdgeInsets.symmetric(horizontal: 6),
                        //                 margin: EdgeInsets.symmetric(horizontal: 36),
                        //                 height: 47,
                        //                 decoration: BoxDecoration(
                        //                   color: AppColors.buttonColor,
                        //                   borderRadius: BorderRadius.circular(100),
                        //                 ),
                        //                 child: Center(
                        //                   child: Text(Languages.of(context)!.appointmentCompleted,
                        //                       style: bodyMedium.copyWith(
                        //                           color: AppColors.scaffoldColor
                        //                       )),
                        //                 )),
                        //           )),
                        //     ],
                        //   ),) : SizedBox.shrink(),
                      ],
                    ),
                  ),
                );
              }),
        ),
        SizedBox(height: 20,),
      ],
    ):Expanded(
      child: Center(
        child: Text(Languages.of(context)!.noCompletedOrders ,style: TextStyle(
            color: Colors.white
        ),),
      ),
    );
  }
}
