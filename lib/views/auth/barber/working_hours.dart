import 'package:beauty_connect/views/auth/barber/add_payment.dart';
import 'package:beauty_connect/widgets/switch_widget.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/global_variables.dart';
import '../../../localization/languages/languages.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/custom_widgets.dart';

class WorkingHours extends StatefulWidget {
  final bool isSignUp;
  const WorkingHours({Key? key, this.isSignUp= true}) : super(key: key);

  @override
  State<WorkingHours> createState() => _WorkingHoursState();
}

class _WorkingHoursState extends State<WorkingHours> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  int selectedIndex=0;
  List<int> selectedServices =[];
  bool isTapped = false;
  bool switchActive = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black12,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: Languages.of(context)!.workingHours,
          onTapLeading: () {
            Get.back();
          },
          actionButton: Text(widget.isSignUp == false? "":"3/4", style: bodyNormal.copyWith(color: Colors.grey),),
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
                      widget.isSignUp == false? Languages.of(context)!.editYourWorkingHours:Languages.of(context)!.addYourWorkingAvailability,
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
                    // _sundaySwitch("Available on Sunday", switchActive),
                    _hoursWidget("Monday", "00", "00"),
                    _hoursWidget("Tuesday", "00", "00"),
                    _hoursWidget("Wednesday", "00", "00"),
                    _hoursWidget("Thursday", "00", "00"),
                    _hoursWidget("Friday", "00", "00"),
                    _hoursWidget("Saturday", "00", "00"),
                    SizedBox(height: 45,),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: CustomButton(
                  buttonText: widget.isSignUp == false? Languages.of(context)!.saveChanges: Languages.of(context)!.next,
                  onTap: () {
                    if(widget.isSignUp == false){
                      Get.back();
                    } else {
                      Get.to(()=> AddPayment());
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
  _hoursWidget(String day, String startTime, String endTime){
    return GestureDetector(
      onTap: (){
        addHours(context, day+" Schedule", "", "Add", (){
          setState(() {
            isTapped = true;
            Get.back();
          });
        });
      },
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.textFieldColor.withOpacity(0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(day, style: headingSmall,),
            Row(children: [
              Text(startTime + " am/pm", style: bodySmall.copyWith(color: Colors.black54, fontSize: 13),),
              Text(" - ", style: bodySmall,),
              Text(endTime + " am/pm", style: bodySmall.copyWith(color: Colors.black54, fontSize: 13),),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Icon(Icons.arrow_forward_ios, size: 18,),
              )
            ],),
          ],
        ),
      ),
    );
  }
  _sundaySwitch(
      String title,
      bool isActive,
      ) {
    return Container(
      height: 50,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.textFieldColor.withOpacity(0.2),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: headingSmall
              ),
            ),
            SwitchWidget(
              isActive: isActive,
              onToggle: (bool) {
                switchActive = !switchActive;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
