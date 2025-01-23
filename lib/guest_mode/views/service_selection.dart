import 'package:beauty_connect/guest_mode/constants/global_variables.dart';
import 'package:beauty_connect/guest_mode/controllers/guest_controller.dart';
import 'package:beauty_connect/guest_mode/models/services_model.dart';
import 'package:beauty_connect/guest_mode/utils/custom_dialogbox.dart';
import 'package:beauty_connect/guest_mode/views/barber_selection.dart';
import 'package:beauty_connect/guest_mode/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/booking_controller.dart';
import '../../localization/languages/languages.dart';

class ServiceSelection extends StatefulWidget {
  @override
  _ServiceSelectionState createState() => _ServiceSelectionState();
}

class _ServiceSelectionState extends State<ServiceSelection> {
  // Updated to keep track of selected services
  final GuestController guestController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 10),() {
      guestController.selectedServices.clear();
      guestController.getUserServices();
    },);
  }
  BookingController bookingController = Get.find();

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var containerWidth = isPortrait ? 100.w : 120.w;
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 1.5,
        bottomOpacity: 0.1,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cardColor,
        shadowColor: Colors.black26,
        title: Align(
          alignment: Alignment.centerLeft,

          child: Image.asset(
            "assets/images/app_logo_black.png",
            scale: 16,
          ),
        ),
      ),
      body: Obx(
            ()=> Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: guestController.isLoading.value?Center(child: CircularProgressIndicator(
            color: AppColors.buttonColor,

          )):
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                Languages.of(context)!.serviceSelection,
                style: headingLarge,
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height*.60,
                child: ListView.builder(
                  itemCount: guestController.serviceList.length,
                  itemBuilder: (context,index)=>
                      ServiceOption(
                        title:bookingController.languageCode=='en'? guestController.serviceList[index].name:bookingController.languageCode=='pt'?guestController.serviceList[index].portuguesName:guestController.serviceList[index].frenchName,
                        // return  bookingController.languageCode=='en'? e.userServices.first.name :bookingController.languageCode=='pt'? e.userServices.first.portugueseName :e.userServices.first.frenchName;

                        description: "\$ ${guestController.serviceList[index].price.toString()}",
                        isSelected: guestController.selectedServices.contains(guestController.serviceList[index]),
                        onTap: () => _toggleSelection(guestController.serviceList[index]),
                      ),
                ),
              ),
              // ServiceOption(
              //   title: 'Haircut',
              //   description: 'Professional hair cutting service',
              //   isSelected: selectedServices.contains('Haircut'),
              //   onTap: () => _toggleSelection('Haircut'),
              // ),

              Spacer(),
              Center(
                child: SizedBox(
                  width: containerWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomButton(
                          textClr: AppColors.scaffoldColor,
                          buttonClr:AppColors.buttonColor,
                          onTap: () {
                            Get.back();
                          },
                          buttonText: Languages.of(context)!.back,
                        ),
                      ),
                      SizedBox(width: isPortrait ? 20 : 100),
                      Expanded(
                        child: CustomButton(
                          textClr: AppColors.scaffoldColor,

                          buttonClr:AppColors.buttonColor,
                          onTap: () {
                            if(guestController.selectedServices.isEmpty){
                             CustomDialog.showErrorDialog(description: Languages.of(context)!.pleaseSelectAnyService);
                            }else{
                              Get.to(() => BarberSelection(),
                                  transition: Transition.rightToLeft);
                            }

                          },
                          buttonText: Languages.of(context)!.next,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleSelection(ServicesModel service) {
    setState(() {

      if (guestController.selectedServices.contains(service)) {

        guestController.selectedServices.remove(service);
      } else {
        guestController.selectedServices.add(service);
      }
    });
  }
}

class ServiceOption extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  ServiceOption({
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, spreadRadius: 1, blurRadius: 3)
          ],
          border: Border.all(
              color: isSelected ? Colors.black : Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title.capitalizeFirst!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2, // Adjust maxLines as needed
              ),
            ),
            Row(
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                      color: Colors.white54
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1, // Adjust maxLines as needed
                ),
                SizedBox(width: 10,),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      border: Border.all(color: isSelected ? AppColors.buttonColor:AppColors.buttonColor),
                      shape: BoxShape.circle
                  ),
                  child: Icon(Icons.circle, color: isSelected ?  AppColors.buttonColor:Colors.transparent, size: 20,),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
