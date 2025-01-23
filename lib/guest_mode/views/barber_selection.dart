import 'package:beauty_connect/guest_mode/constants/global_variables.dart';
import 'package:beauty_connect/guest_mode/views/customer_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../localization/languages/languages.dart';
import '../controllers/guest_controller.dart';
import '../widgets/custom_widgets.dart';

class BarberSelection extends StatefulWidget {
  @override
  _BarberSelectionState createState() => _BarberSelectionState();
}

class _BarberSelectionState extends State<BarberSelection> {

  final GuestController guestController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    guestController.barberId.value = null;
    guestController.getAvailableBarbers();
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var containerWidth = isPortrait ? 100.w : 120.w;
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        elevation: 1.5,
        bottomOpacity: 0.1,
        automaticallyImplyLeading: false,
        shadowColor: Colors.black26,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            "assets/images/app_logo_black.png",
            scale: 16,
          ),
        ),
        // actions: [
        //   Container(
        //     margin: EdgeInsets.only(left: 16), // Adjust margin as needed
        //     child: Image.asset(
        //       "assets/images/app_logo_black.png",
        //       scale: 16,
        //     ),
        //   ),
        // ],

      ),
      body: Obx(
          ()=>guestController.isLoading.value?Center(
              child: CircularProgressIndicator(
                color: AppColors.buttonColor,

              )): Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                Languages.of(context)!.barberSelection,
                style: headingLarge,
              ),
              SizedBox(height: 20),
              Expanded(
                child:guestController.availableBarbers.isEmpty?Center(child: 
                  Text(Languages.of(context)!.norBarberAvailableForRequiredService,style: TextStyle(color: Colors.white),),): LayoutBuilder(
                  builder: (context, constraints) {
                    bool isPortrait = constraints.maxWidth < constraints.maxHeight;
                    double gridWidth = constraints.maxWidth / (isPortrait ? 2 : 3); // Column count
                    double cardHeight = constraints.maxHeight * 0.3 + 180; // Image height + text estimate

                    return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isPortrait ? 2 : 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: gridWidth / cardHeight, // Landscape aspect ratio
                      ),
                      itemCount: guestController.availableBarbers.length,
                      itemBuilder: (context, index) {
                        int timeInMinutes = guestController.availableBarbers[index].time ?? 2;
                        String formattedTime = (timeInMinutes > 60)
                            ? '${timeInMinutes ~/ 60} h ${timeInMinutes % 60} m'
                            : '$timeInMinutes m';

                        return BarberCard(
                          title: guestController.availableBarbers[index].name ?? '',
                          description: formattedTime,
                          imageUrl: guestController.availableBarbers[index].image ?? '',
                          isSelected: guestController.barberId.value ==
                              guestController.availableBarbers[index].id,
                          onTap: () {
                            if (guestController.barberId.value ==
                                guestController.availableBarbers[index].id) {
                              guestController.barberId.value = null;
                            } else {
                              guestController.barberId.value =
                                  guestController.availableBarbers[index].id ?? 1;
                            }
                            setState(() {});
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              // Expanded(
              //   child: GridView.count(
              //     shrinkWrap: true,
              //       physics: BouncingScrollPhysics(),
              //       crossAxisCount: isPortrait ? 2 : 3,
              //        crossAxisSpacing: 16,
              //       mainAxisSpacing: 16,
              //       // childAspectRatio:isPortrait? 0.47:1.15,
              //       children: List.generate(
              //           guestController.availableBarbers.length, (index) {
              //         int timeInMinutes = guestController.availableBarbers[index].time??2;
              //         String formattedTime = (timeInMinutes > 60)
              //             ? '${timeInMinutes ~/ 60} h${(timeInMinutes ~/ 60 > 1) ? '' : ''} ${timeInMinutes % 60} m${(timeInMinutes % 60 > 1) ? '' : ''}'
              //             : timeInMinutes.toString()+' m';
              //         return BarberCard(
              //           title: guestController.availableBarbers[index].name??'',
              //           description: formattedTime??'',
              //           imageUrl: guestController.availableBarbers[index].image??'',
              //           isSelected: guestController.barberId.value == guestController.availableBarbers[index].id,
              //           onTap: () {
              //            if(guestController.barberId.value==guestController.availableBarbers[index].id){
              //              guestController.barberId.value=null;
              //             }else{
              //              guestController.barberId.value = guestController.availableBarbers[index].id??1;
              //             }
              //            setState(() {
              //
              //            });
              //           },
              //         );
              //       })),
              // ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  // color: AppColors.cardColor,
                  width: containerWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: CustomButton(
                            textClr: AppColors.scaffoldColor,

                            buttonClr: AppColors.buttonColor,

                            onTap: () {
                          Get.back();
                        },
                        buttonText: Languages.of(context)!.back,
                      )),
                      SizedBox(
                        width: isPortrait ? 20 : 100,
                      ),
                      Expanded(
                          child: CustomButton(
                            textClr: AppColors.scaffoldColor,

                            buttonClr: AppColors.buttonColor,
                        onTap: () {
                          // Get.to(() => CustomerDetails( ),
                          //     transition: Transition.rightToLeft);
                          if(guestController.barberId.value==null){
                            guestController.barberId.value = guestController.availableBarbers[0].id;
                            guestController.createGuestAppointment();
                          }else{
                            guestController.createGuestAppointment();
                          }

                        },
                        buttonText: guestController.barberId.value==null?Languages.of(context)!.proceedWithAny:Languages.of(context)!.next,
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BarberCard extends StatelessWidget {
  final String title;
  final String? description;
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  BarberCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
            // padding: EdgeInsets.only(bottom: 2),
        // height: 65.h,
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 0.9, blurRadius: 1)
          ],
          border: Border.all(
              color: isSelected ? AppColors.buttonColor : Colors.black12,
              width: 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl:imageUrl,
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
                  height: 250,
                ),
              ),
            ),
            Container(
              // color: Colors.amber,
              child: Padding(
                padding: const EdgeInsets.only(top:5,left:5),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Tooltip(
                        message: title,
                        child: Text(
                          title,
                          style: headingSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        Languages.of(context)!.availableTime,
                        style: bodyNormal,
                      ),
                      Text(
                        description??'',
                        style: bodyNormal,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
