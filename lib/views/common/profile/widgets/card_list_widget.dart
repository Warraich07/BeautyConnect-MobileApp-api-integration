import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../constants/global_variables.dart';

class CardListWidget extends StatefulWidget {
  final String cardText;
  final Function onTap;
  final Widget? leadingIcon;
  final String? suffixIcon;
  const CardListWidget({
    Key? key,
    required this.cardText,
    required this.onTap,
    this.leadingIcon = const SizedBox.shrink(),
    this.suffixIcon = "",
  }) : super(key: key);

  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds: 200),
      slidingBeginOffset: Offset(0, 0),
      child: Column(
        children: [
          ZoomTapAnimation(
            onTap: () {
              widget.onTap();
            },
            onLongTap: () {},
            enableLongTapRepeatEvent: false,
            longTapRepeatDuration: const Duration(milliseconds: 100),
            begin: 1.0,
            end: 0.93,
            beginDuration: const Duration(milliseconds: 20),
            endDuration: const Duration(milliseconds: 120),
            beginCurve: Curves.decelerate,
            endCurve: Curves.fastOutSlowIn,
            child: Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0,0), blurRadius: 3, spreadRadius: 0.2),],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: widget.suffixIcon != ""
                        ? EdgeInsets.symmetric(horizontal: 0)
                        : EdgeInsets.zero,
                    child: Container(
                      width: 40,
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.buttonColor.withOpacity(0.2)),
                      child: Image.asset(
                        widget.suffixIcon!,
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.cardText,
                            style: headingSmall.copyWith(
                                fontFamily: "MediumText",
                                fontSize: 14, height: 1, color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      child: widget.leadingIcon!,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12,),
        ],
      ),
    );
  }
}
