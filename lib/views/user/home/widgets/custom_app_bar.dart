import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/global_variables.dart';
import '../../../../localization/languages/languages.dart';

class CustomAppBarForBarberDetailScreen extends StatelessWidget {
  final String imageUrl;
  final double averageRating;
  final int feedbackCount;

  const CustomAppBarForBarberDetailScreen({
    Key? key,
    required this.imageUrl,
    required this.averageRating,
    required this.feedbackCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Stack(
        // fit: StackFit.loose,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            child: Container(
              // color: Colors.yellow,
              height: 215,
              width: 100.w,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: AppColors.buttonColor,
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset("assets/img.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.buttonColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.black, size: 18),
                  Text(
                    averageRating.toString(),
                    style: headingSmall.copyWith(fontSize: 12, color: Colors.black),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "($feedbackCount ${Languages.of(context)!.reviews})",
                    style: headingSmall.copyWith(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          // Column(
          //
          // )
        ],
      ),
    );
  }
}
