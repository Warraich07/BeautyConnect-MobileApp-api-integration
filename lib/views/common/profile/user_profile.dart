import 'package:delayed_display/delayed_display.dart';
import 'package:beauty_connect/views/common/messages/chat_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../constants/global_variables.dart';
import '../../../widgets/custom_widgets.dart';

class UserProfile extends StatefulWidget {
  final bool isUser;
  UserProfile({super.key, required this.isUser});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<String> filters = [
    "All",
    "Violin Online Performance",
    "Online Class",
    "Violin & Nature",
    "Others",
  ];
  int selectedFilterIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: "",
          onTapLeading: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(

              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                      AssetImage(widget.isUser == true ? "assets/images/profile_image.png" : "assets/images/cameron.png"),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.isUser == true ? "Cameron Williamson" : "Robert Dawn", style: headingSmall),
                        Text(widget.isUser == true ? "Teacher" : "Admin", style: headingSmall.copyWith(color: Colors.black54)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                CustomButton(onTap: (){
                  Get.to(()=> ChatDetailScreen());
                }, buttonText: "Send Message", ),
              ],
            ),
          ),
          Divider(
            color: Colors.black54,
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: 500),
            slidingBeginOffset: Offset(0, -1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                 widget.isUser== true? "Saved Videos" : "Uploaded Videos",
                  style: headingMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          widget.isUser == true ? SizedBox.shrink() : DelayedDisplay(
              child: SizedBox(
                height: 36,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: 10),
                    itemCount: filters.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedFilterIndex = index;
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            margin: EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all( color: index == selectedFilterIndex ? AppColors.secondaryColor : AppColors.primaryColor, width: 2),
                                color: index == selectedFilterIndex ? AppColors.primaryColor : Colors.transparent
                            ),
                            child: Center(child: Text(filters[index], style: headingSmall.copyWith(fontSize: 13, color: index == selectedFilterIndex ? Colors.white : Colors.black),))
                        ),
                      );
                    }),
              )
          ),
          widget.isUser == true ? SizedBox.shrink() : SizedBox(height: 10,),
          Expanded(
            child: MasonryGridView.count(
              crossAxisCount: 3,
              padding: EdgeInsets.only(bottom: 10),
              itemCount: 7,
              mainAxisSpacing:0,
              crossAxisSpacing: 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                  },
                  onLongPress: () {
                    setState(() {
                    });
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Image.asset(
                        "assets/images/image${index + 1}.png",
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Icon(Icons.play_circle,color: Colors.white, size: 18,),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
