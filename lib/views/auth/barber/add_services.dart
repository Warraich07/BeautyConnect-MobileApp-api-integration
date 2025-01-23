import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:beauty_connect/views/auth/barber/working_hours.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/global_variables.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/custom_widgets.dart';

class AddServices extends StatefulWidget {
  final bool isSignUp;
  const AddServices({Key? key, this.isSignUp= true}) : super(key: key);

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  int selectedIndex=0;
  List<int> selectedServices =[];
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black12,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: Languages.of(context)!.services,
          onTapLeading: () {
            Get.back();
            },
          actionButton: Text(widget.isSignUp == false ? "" : "2/4", style: bodyNormal.copyWith(color: Colors.grey),),
        ),
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 300),
                  slidingBeginOffset: Offset(0, -1),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.isSignUp == false? Languages.of(context)!.editYourServiceAndCharges:Languages.of(context)!.chooseTheServicesAndAddCharges,
                      style: authSubHeading,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    _servicesList("assets/icons/haircut.png", "Haircut", "20 mins", "20.00", 1),
                    _servicesList("assets/icons/shaving.png", "Shaving", "20 mins", "25.00", 2),
                    _servicesList("assets/icons/facial.png", "Facial", "20 mins", "30.00", 3),
                    _servicesList("assets/icons/massage.png", "Massage", "10 mins", "10.00", 4),
                    SizedBox(height: 45,),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: CustomButton(
                  buttonText: widget.isSignUp == false? "SAVE CHANGES" : "Next",
                  onTap: () {
                    if(widget.isSignUp == false){
                      Get.back();
                    } else {
                      Get.to(()=> WorkingHours());
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
  _servicesList(String icon, String title, String time, String charges, int index){
    return GestureDetector(
      onTap: (){

        setState(() {
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
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0.1, blurRadius: 3, offset: Offset(0, 0))]
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Image.asset(icon, scale: 4,),
              SizedBox(width: 10,),
              Expanded(child: Text(title, style: headingSmall, overflow: TextOverflow.ellipsis, maxLines: 1,)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(Languages.of(context)!.servicesTime, style: bodySmall.copyWith(color: Colors.black54, fontSize: 8),),
                  Text(time, style: bodySmall.copyWith(),),
                ],
              ),
              VerticalDivider(
                width: 20,
                thickness: 1,
                color: Colors.black12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Languages.of(context)!.servicesCharges, style: bodySmall.copyWith(color: Colors.black54,  fontSize: 8),),
                  GestureDetector(
                      onTap: (){
                        addCharges(context, Languages.of(context)!.addServicesCharges, "", Languages.of(context)!.add, (){
                          setState(() {
                            isTapped = true;
                            Get.back();
                          });
                        });
                      },
                      child: Text(isTapped == false ?Languages.of(context)!.add :"\$" + charges, style: bodySmall.copyWith(color: AppColors.buttonColor),)),
                ],
              ),
              Container(
                height: 15,
                width: 15,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.buttonColor),
                ),
                child: Icon(Icons.circle, color: selectedServices.contains(index)? AppColors.buttonColor.withOpacity(0.5) : Colors.transparent, size: 10,),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
