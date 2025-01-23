import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/custom_validators.dart';
import '../../../constants/global_variables.dart';
import '../../../utils/shared_preference.dart';
import '../../../widgets/custom_widgets.dart';

class CancelAppointment extends StatefulWidget {
  const CancelAppointment({super.key,this.bookingId,this.bookingIndex,this.appointmentId});
final String? bookingId;
final int? bookingIndex;
final int? appointmentId;
  @override
  State<CancelAppointment> createState() => _CancelAppointmentState();
}

class _CancelAppointmentState extends State<CancelAppointment> {
  int selectedIndex=0;

  BookingController bookingController=Get.find();
  TextEditingController reasonController=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<String> reasons = [
      Languages.of(context)!.scheduleChange,
      Languages.of(context)!.emergency,
      Languages.of(context)!.parkingAvailability,
      Languages.of(context)!.lackOfAmenities,
      Languages.of(context)!.iHaveAlternativeOption,
      Languages.of(context)!.other
    ];
    return Scaffold(
      appBar: AppBar(

        elevation: 0.5,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cardColor,
        title: CustomAppBar(
          pageTitle: Languages.of(context)!.cancelAppointment, onTapLeading: (){Get.back();},),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 15,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(Languages.of(context)!.chooseReasonForCancellation, style: headingMedium,)),
              SizedBox(height: 10,),
              SizedBox(
                height: double.parse((33 * reasons.length).toString()),
                child: ListView.builder(
                  itemCount: reasons.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedIndex = index;
                          print(selectedIndex);
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.buttonColor),
                            ),
                            child: Icon(Icons.circle, color: selectedIndex == index ? AppColors.buttonColor.withOpacity(0.5) : Colors.transparent, size: 14,),
                          ),
                          SizedBox(width: 10,),
                          Text(reasons[index], style: headingSmall,),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              Divider(
                color: Colors.black12,
                height: 20,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(Languages.of(context)!.other, style: headingMedium,)),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.cardColor,
                  border: Border.all(
                      color: Colors.black12,
                      width: 1.2
                  ),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 180, maxHeight: 180),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: (value) => CustomValidator.isEmpty(value),
                        controller: reasonController,
                        cursorColor: Colors.black,
                        style: headingSmall.copyWith(
                            fontSize: 15, overflow: TextOverflow.ellipsis),
                        maxLines: 10,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: Languages.of(context)!.enterYourReason,
                          hintStyle: bodyMedium.copyWith(
                              color: Colors.white54, fontSize: 15),
                          errorStyle: TextStyle(
                            color: AppColors.greyText
                          )
                        ),

                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100,),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: AppColors.cardColor,
        padding: EdgeInsets.fromLTRB(16, 2, 16, 15),
        child: CustomButton(
          textClr: AppColors.buttonTextColor,
          onTap: ()async{
            Map<String, dynamic> userStatus = await AuthPreference.instance.getUserLoggedIn();
            String userType = userStatus["userType"];
            // print(userType);
              if(userType!='barber'){
                if(selectedIndex==reasons.length-1){
                  if(_formKey.currentState!.validate()){
                    bookingController.cancelBooking(widget.bookingId.toString(),reasonController.text.toString(),widget.bookingIndex??1,'user' ,context);
                  }
                }else{
                  reasonController.text=reasons[selectedIndex];
                  setState(() {
                  });
                  bookingController.cancelBooking(widget.bookingId.toString(),reasonController.text.toString(),widget.bookingIndex??1,'user' ,context);
                }
              }else if(userType=='barber'){
                if(selectedIndex==reasons.length-1){
                  if(_formKey.currentState!.validate()){
                    bookingController.cancelBooking(widget.bookingId.toString(),reasonController.text.toString(),widget.bookingIndex??1 ,'barber',context);
                    // bookingController.startAppointment(widget.appointmentId.toString(), 'cancel',);
                  }
                }else{
                  reasonController.text=reasons[selectedIndex];
                  setState(() {
                  });
                  bookingController.cancelBooking(widget.bookingId.toString(),reasonController.text.toString(),widget.bookingIndex??1,'barber',context );

                  // bookingController.startAppointment(widget.appointmentId.toString(), 'cancel',);
                }
                // if(_formKey.currentState!.validate()){
                //   bookingController.startAppointment(widget.appointmentId.toString(), 'cancel',);
                //   Get.back();
                // }
              }
            // showCustomDialog(context, "assets/images/popup/success.png", "Appointment Cancelled Successfully", "Your appointment has been cancelled successfully.", "Done", (){
            //   Get.back();
            // }, null);
          },
          buttonText: Languages.of(context)!.cancelAppointment,
        ),
      ),
    );
  }
}
