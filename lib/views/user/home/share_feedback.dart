import 'package:beauty_connect/controllers/booking_controller.dart';
import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../constants/custom_validators.dart';
import '../../../constants/global_variables.dart';
import '../../../widgets/card_widget.dart';
import '../../../widgets/custom_widgets.dart';

class ShareFeedback extends StatefulWidget {
  final String image;
  final String title;
  final String name;
  final String barberId;
  final String bookingID;
  final String notificationId;
  final String barberName;
  final String barberImagePath;
  const ShareFeedback({super.key, required this.image, required this.title, required this.name,required this.barberId,required this.notificationId,required this.bookingID,required this.barberName,required this.barberImagePath});

  @override
  State<ShareFeedback> createState() => _ShareFeedbackState();
}

class _ShareFeedbackState extends State<ShareFeedback> {
  int selectedIndex=0;
  List<int> selectedServices =[];
  List<String> reasons = [
    "Schedule change",
    "Schedule change",
    "Parking  availability",
    "Lack of amenities",
    "I have alternative option",
    "Other"
  ];
  final List<String> tags = [
    'Clean Environment',
    'Very Professional',
    'best service and polite behavior',
    'Nice Salon'
  ];

  // List to keep track of selected states
  late List<bool> selectedTags;

  String cleanEnvironment='';
  String veryProfessional='';
  String bestServices='';
  String niceSaloon='';

  @override
  void initState() {
    super.initState();
    selectedTags = List<bool>.filled(tags.length, false); // Initialize all tags as unselected
  }
  BookingController bookingController=BookingController();
TextEditingController feedBackController=TextEditingController();
  String reason='';
  int ratingStars=4;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cardColor,
        title: CustomAppBar(pageTitle: Languages.of(context)!.shareFeedback, onTapLeading: (){Get.back();},),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 15,),
              CardWidget(locationImage: Container(),image: widget.barberImagePath, title: widget.title, name: widget.barberName,location: '',),
              SizedBox(height: 15,),
              RatingBar.builder(
                unratedColor: Colors.white,
                itemSize: 35,
                initialRating: 4,
                minRating: 1,
                ignoreGestures: false,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding:
                EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  // print(rating.toInt());
                      ratingStars=rating.toInt();
                      print(ratingStars);
                },
              ),
              SizedBox(height: 20,),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(tags.length, (index) {
                  return buildTag(tags[index], index);
                }),
              ),
              Divider(
                height: 30,
                color: Colors.black12,
              ),
              SizedBox(height: 10,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(Languages.of(context)!.yourFeedBack, style: headingMedium,)),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.black12,
                      width: 1.2
                  ),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ConstrainedBox(
                    
                      constraints: BoxConstraints(minHeight: 180, maxHeight: 180,),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          validator: (value) => CustomValidator.isEmpty(value),
                          controller: feedBackController,
                          cursorColor: Colors.white,
                          style: headingSmall.copyWith(
                              fontSize: 15, overflow: TextOverflow.ellipsis),
                          maxLines: 10,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: Languages.of(context)!.enterYourFeedBack,
                            hintStyle: bodyMedium.copyWith(
                                color: Colors.white54, fontSize: 15),
                            fillColor: AppColors.cardColor,
                            filled: true
                          ),
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
          child: Row(
          children: [
            Expanded(
              child: ZoomTapAnimation(
                onTap: () {
                  Get.back();
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColors.buttonColor)),
                    child: Center(
                      child: Text(Languages.of(context)!.cancel, style: headingSmall.copyWith(fontSize: 14)),
                    )),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                height: 65,
                child: CustomButton(
                  textClr: Colors.black,
                  fontSize: 14,
                  onTap: () {
                    if(formKey.currentState!.validate()){
                      bookingController.shareFeedBack(widget.barberId, ratingStars, reason, feedBackController.text,widget.bookingID,widget.notificationId);
                    }
                    // showCustomDialog(context, "assets/images/popup/success.png", "Feedback sent Successfully", "Your feedback has been sent to barber successfully.", "Continue", (){Get.offAll(()=> UserBottomNavBar());}, null);

                  },
                  buttonText: Languages.of(context)!.submit,
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
  Widget buildTag(String text, int index) {
    // List<String> selectedReasons=[];

    return GestureDetector(

      onTap: () {
        setState(() {
          selectedTags[index] = !selectedTags[index];
         if(selectedTags[0]==true){
           cleanEnvironment=tags[0];
         }
          if(selectedTags[0]==false){
            cleanEnvironment="";
          }
          if(selectedTags[1]==true){
            veryProfessional=tags[1];
          }
          if(selectedTags[1]==false){
            veryProfessional="";
          }
          if(selectedTags[2]==true){
            bestServices=tags[2];
          }
          if(selectedTags[2]==false){
            bestServices="";
          }
          if(selectedTags[3]==true){
            niceSaloon=tags[3];
          }
          if(selectedTags[3]==false){
            niceSaloon="";
          }
          reason=cleanEnvironment + veryProfessional +bestServices + niceSaloon;
          if(reason.isEmpty){
            print("empty");
          }
          print(reason);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: selectedTags[index] ? AppColors.buttonColor : Colors.black12,
          ),
          color: AppColors.cardColor,
        ),
        child: Text(
          text,
          style: bodyMedium.copyWith(fontSize: 12),
        ),
      ),
    );
  }
}
