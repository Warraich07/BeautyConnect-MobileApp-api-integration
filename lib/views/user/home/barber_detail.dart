import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:beauty_connect/views/user/appointments/re_book_appointment.dart';
import 'package:beauty_connect/views/user/home/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/booking_controller.dart';
import '../../../widgets/custom_widgets.dart';

class BarberDetail extends StatefulWidget {

  // final List<String> images;
  final List<String> name;
  final List<String> titles;
  final int index;

  const BarberDetail({super.key, required this.titles, required this.name , required this.index, });

  @override
  State<BarberDetail> createState() => _BarberDetailState();
}

class _BarberDetailState extends State<BarberDetail> with TickerProviderStateMixin {
  late TabController _tabController;
  BookingController bookingController = Get.find();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this); // Adjust the length according to the number of tabs
    bookingController.getBarberServices(bookingController.barberDataList[widget.index].id);
  }

  List<String> weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
          ()=> Scaffold(
            appBar: AppBar(
              toolbarHeight: 200,
              title: Text(""),
              backgroundColor: Colors.black,
              flexibleSpace: CustomAppBarForBarberDetailScreen(
                imageUrl: bookingController.barberDataList[widget.index].image!,
                averageRating:double.parse(bookingController.barberDataList[widget.index].averageRating.toString()),
                feedbackCount: bookingController.barberServicesList.value?.feedbackCount ?? 0,
              ),
              // Optionally add leading icon
              leading: Padding(
                padding: const EdgeInsets.only(left: 5.0,bottom:150 ),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black54,
                    ),
                    child: Icon(Icons.arrow_back, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ),
        body: bookingController.isLoading==true?Center(
          child: CircularProgressIndicator(
            color: AppColors.buttonColor,

          )
        ):
        Container(
          child: CustomScrollView(
            slivers: [
              // SliverAppBar(
              //   expandedHeight: 220.0,
              //   floating: false,
              //   pinned: true,
              //   backgroundColor: Colors.black,
              //   leading: Padding(
              //     padding: const EdgeInsets.only(left: 5.0),
              //     child: GestureDetector(
              //         onTap: (){
              //           Get.back();
              //         },
              //         child: Container(
              //             height: 30,
              //             width: 30,
              //             margin: EdgeInsets.all(10),
              //             decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 color: Colors.black54
              //             ),
              //             child: Icon(Icons.arrow_back, color: Colors.white, size: 20,))),
              //   ),
              //   flexibleSpace: FlexibleSpaceBar(
              //     centerTitle: true,
              //     background: SizedBox(
              //       // height: 220,
              //       width: 100.w,
              //       child: Stack(
              //         fit: StackFit.loose,
              //         alignment: Alignment.topCenter,
              //         children: [
              //           Positioned(
              //             // top: 25,
              //             child: Container(
              //
              //               height: 230,
              //               width: 100.w,
              //               child: CachedNetworkImage(imageUrl: bookingController.barberDataList[widget.index].image!,
              //                 placeholder: (context, url) =>
              //                   Center(
              //                       child: CircularProgressIndicator(
              //                         color: AppColors.buttonColor,
              //                       )),
              //                 errorWidget: (context, url,
              //                     error) =>
              //                     Image.asset(
              //                         "assets/img.png"),
              //                 fit: BoxFit.cover,),
              //             ),
              //           ),
              //           Positioned(
              //
              //             bottom: 0,
              //             child: Container(
              //               height: 40,
              //               padding: EdgeInsets.symmetric(horizontal: 20),
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(100),
              //                 color: AppColors.buttonColor,
              //               ),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Icon(Icons.star, color: Colors.black, size: 18,),
              //                   Text(bookingController.barberDataList[widget.index].averageRating.toString(), style: headingSmall.copyWith(fontSize: 12, color: Colors.black),),
              //                   SizedBox(width: 4,),
              //                   Text("(${bookingController.barberServicesList.value?.feedbackCount.toString()} ${Languages.of(context)!.reviews})", style: headingSmall.copyWith(fontSize: 12, color: Colors.black),),
              //
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(bookingController.barberDataList[widget.index].name, style: headingSmall.copyWith(fontSize: 22,color:  Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis,)),
                      SizedBox(height: 5,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(bookingController.barberDataList[widget.index].saloonName??"", style: bodyMedium.copyWith(fontSize: 14, color: Colors.white54),)),
                      Divider(height: 30, color: Colors.black12,),
                      Row(
                        children: [
                          bookingController.barberDataList[widget.index].location.toString()==''?Container(): Image.asset("assets/icons/location_icon.png", scale: 9,color: AppColors.buttonColor,),
                          SizedBox(width: 4,),
                          Expanded(child: Text(bookingController.barberDataList[widget.index].location??"", style: bodyMedium.copyWith(fontSize: 12, color: Colors.white54), overflow: TextOverflow.ellipsis, maxLines: 2)),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          bookingController.startDay.isEmpty?Container(): Image.asset("assets/icons/time_icon.png", scale: 4,color: AppColors.buttonColor,),
                          SizedBox(width: 4,),
                          // bookingController.barberServicesList.value!.workingDays![index].from.toString()
                          Expanded(child: Text(bookingController.startDay.value.toString()+bookingController.endDay.value.toString()+bookingController.startTime.value.toString()+bookingController.endTime.value.toString(), style: bodyMedium.copyWith(fontSize: 12, color: Colors.white54), overflow: TextOverflow.ellipsis, maxLines: 1)),
                          // Expanded(child: Text("Mon-Sun | 10 am - 10 pm", style: bodyMedium.copyWith(fontSize: 12, color: Colors.black54), overflow: TextOverflow.ellipsis, maxLines: 1)),
                        ],
                      ),
                      Divider(height: 20, color: Colors.white12),
                      // Add more widgets here that describe the details about the barber.
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeaderProfile(
                  widget: Container(
                    color: Colors.black,
                    child: TabBar(

                      controller: _tabController,
                      labelStyle: headingSmall.copyWith(fontSize: 14),
                      // indicatorColor: Colors.red,
                      indicatorPadding: EdgeInsets.only(top: 55),
                      labelColor: AppColors.buttonColor,
                      unselectedLabelColor: Colors.white54,
                      indicator: BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      tabs: [
                        Tab(text: Languages.of(context)!.about),
                        Tab(text: Languages.of(context)!.services),
                        Tab(text: Languages.of(context)!.reviews),
                      ],
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 100.w,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.cardColor,
                                      boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0.5, blurRadius: 2, offset: Offset(0, 0))]
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(Languages.of(context)!.about, style: headingSmall,)),
                                      SizedBox(height: 5,),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(bookingController.barberServicesList.value!.about.toString(), style: bodySmall.copyWith(color: Colors.white, fontSize: 13),)),
                                    ],
                                  ),
                                ),
                                Divider(height: 30, color: Colors.black12,),
                                Container(
                                  width: 100.w,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.cardColor,
                                      boxShadow: [BoxShadow(color: Colors.white12, spreadRadius: 0.5, blurRadius: 2, offset: Offset(0, 0))]
                                  ),
                                  child:
                                  Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(Languages.of(context)!.workingHours, style: headingSmall,)),

                                      ListView.builder(
                                        padding: EdgeInsets.only(bottom: 5,top: 10),
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: bookingController.barberServicesList.value!.workingDays!.length,
                                        itemBuilder: (context, index) =>  _workingHours(index, bookingController.barberServicesList.value!.workingDays![index].from.toString(), bookingController.barberServicesList.value!.workingDays![index].to.toString()),)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: bookingController.barberServicesList.value!.serviceCharges.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context,index)=>
                                    _servicesList(
                                        bookingController.barberServicesList.value!.serviceCharges[index].services![0].image.toString(),

                                       bookingController.languageCode=='en'? bookingController.barberServicesList.value!.serviceCharges[index].services!.first.name.toString():
                                       bookingController.languageCode=='pt'?bookingController.barberServicesList.value!.serviceCharges[index].services!.first.portugueseName.toString():
                                       bookingController.barberServicesList.value!.serviceCharges[index].services!.first.frenchName.toString(),

                                        bookingController.barberServicesList.value!.serviceCharges[index].services!.first.time.toString()+' mins',
                                        bookingController.barberServicesList.value!.serviceCharges[index].services![0].price.toString()),

                                ),
                              ],
                            ),
                            bookingController.barberServicesList.value!.feedback!.isNotEmpty? ListView.builder(
                              padding: EdgeInsets.only(bottom: 100),
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                                itemCount: bookingController.barberServicesList.value!.feedback!.length,
                                itemBuilder: (context,index)=>
                                    Container(
                                      width: 100.w,

                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.fromLTRB(2, 2, 2, 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: AppColors.cardColor,
                                          boxShadow: [BoxShadow(color: Colors.white12, spreadRadius: 0.1, blurRadius: 3, offset: Offset(0, 0))]
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    // Image.network("src")
                                                    ClipRRect(
                                                      borderRadius:BorderRadius.circular(30),
                                                      child: Container(
                                                        height:30,
                                                        width:30,
                                                        child: CachedNetworkImage(
                                                          imageUrl:bookingController.barberServicesList.value!.feedback![index].user!.image.toString(),
                                                          placeholder: (context, url) =>
                                                              Center(
                                                                  child: CircularProgressIndicator(
                                                                    color: AppColors.buttonColor,
                                                      
                                                                  )),
                                                          errorWidget: (context, url,
                                                              error) =>
                                                              Image.asset(
                                                                  "assets/img.png"),
                                                          fit: BoxFit.cover,
                                                      
                                                          width: double.infinity,
                                                          // height: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(bookingController.barberServicesList.value!.feedback![index].user!.name.toString(), style: headingSmall, overflow: TextOverflow.ellipsis, maxLines: 1,),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text("10 days ago", style: bodySmall.copyWith(color: Colors.white54),)
                                            ],
                                          ),
                                          SizedBox(height: 6,),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(bookingController.barberServicesList.value!.feedback![index].feedback.toString()=='null'?'':bookingController.barberServicesList.value!.feedback![index].feedback.toString(), style: bodySmall.copyWith(color: Colors.white54),)),
                                          SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              DelayedDisplay(
                                                delay: Duration(milliseconds: 550),
                                                slidingBeginOffset: Offset(0, 0),
                                                child: RatingBar.builder(
                                                  itemSize: 18,
                                                  initialRating: double.parse(bookingController.barberServicesList.value!.feedback![index].rating.toString()),
                                                  minRating: 1,
                                                  ignoreGestures: true,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: false,
                                                  itemCount: 5,
                                                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                                  itemBuilder: (context, _) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 5,),
                                              Text(
                                                bookingController.barberServicesList.value!.feedback![index].rating.toString(),
                                                style: headingSmall.copyWith(
                                                  fontSize: 11,),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    )
                            ):Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          color: AppColors.cardColor,
          padding: EdgeInsets.fromLTRB(16, 2, 16, 15),
          child: CustomButton(
            textClr: AppColors.buttonTextColor,
            onTap: ()async{
              print('barber details');
              Get.to(()=> ReBookAppointment(index: widget.index, title: widget.titles[0], name: widget.name[0], isAddNew: true, image: '',));
            },
            buttonText: Languages.of(context)!.bookAppointment,
          ),
        ),
      ),
    );
  }
  _workingHours(int index, String startDuration, String endDuration){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(weekDays[index], style: bodySmall.copyWith(color: Colors.white),),
          Text(startDuration + " - " + endDuration, style: bodySmall.copyWith(color: Colors.white54),),
        ],
      ),
    );
  }
  _servicesList(String icon, String title, String time, String charges){
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.fromLTRB(2, 2, 2, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.cardColor,
          boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0.1, blurRadius: 2, offset: Offset(0, 0))]
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // CachedNetworkImage(imageUrl: icon, height: 25,width: 5,),
            // SizedBox(width: 5,),
            Container(
                width: 150,
                child: Text(title, style: headingSmall, )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(Languages.of(context)!.servicesTime, style: bodySmall.copyWith(color: Colors.white54, fontSize: 8),),
                Text(time, style: bodySmall.copyWith(),),
              ],
            ),
           VerticalDivider(
             // width: 20,
             thickness: 1,
             color: Colors.white54,
           ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Languages.of(context)!.servicesCharges, style: bodySmall.copyWith(color: Colors.white54,  fontSize: 8),),
                Text("\$" + charges, style: bodySmall.copyWith(),),
              ],
            ),
          ],
        ),
      ),
    );
  }
  // _reviews(String image, String name){
  //   return Container(
  //     width: 100.w,
  //     padding: EdgeInsets.all(10),
  //     margin: EdgeInsets.fromLTRB(2, 2, 2, 10),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(15),
  //         color: Colors.white,
  //         boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0.1, blurRadius: 3, offset: Offset(0, 0))]
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Expanded(
  //               child: Row(
  //                 children: [
  //                   CircleAvatar(
  //                     backgroundImage:
  //                     AssetImage(image),
  //                   ),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     child: Text(name, style: headingSmall, overflow: TextOverflow.ellipsis, maxLines: 1,),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Text("10 days ago", style: bodySmall.copyWith(color: Colors.black54),)
  //           ],
  //         ),
  //         SizedBox(height: 6,),
  //         Text("Lorem ipsum dolor sit amet consectetur. Proin faucibus imperdiet venenatis faucibus aliquet condimentum pretium.", style: bodySmall.copyWith(color: Colors.black54),),
  //         SizedBox(height: 5,),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             DelayedDisplay(
  //               delay: Duration(milliseconds: 550),
  //               slidingBeginOffset: Offset(0, 0),
  //               child: RatingBar.builder(
  //                 itemSize: 18,
  //                 initialRating: 4,
  //                 minRating: 1,
  //                 ignoreGestures: true,
  //                 direction: Axis.horizontal,
  //                 allowHalfRating: false,
  //                 itemCount: 5,
  //                 itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
  //                 itemBuilder: (context, _) => Icon(
  //                   Icons.star,
  //                   color: Colors.amber,
  //                 ),
  //                 onRatingUpdate: (rating) {
  //                   print(rating);
  //                 },
  //               ),
  //             ),
  //             SizedBox(width: 5,),
  //             Text(
  //               "4.5",
  //               style: headingSmall.copyWith(
  //                   fontSize: 11,),
  //               maxLines: 1,
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //           ],
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }
}
class PersistentHeaderProfile extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentHeaderProfile({required this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      color:  Colors.white,
      height: 58.0,
      child: Card(
        margin: EdgeInsets.all(0),
        color: Colors.white,
        elevation: 0,
        child: widget,
      ),
    );
  }

  @override
  double get maxExtent => 58.0;

  @override
  double get minExtent => 58.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
