import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import '../../../../constants/global_variables.dart';

class NewMessageWidget extends StatefulWidget {
  final String title;
  final String desc;
  final String suffixIcon;
  final Widget? leadingIcon;
  NewMessageWidget({
    Key? key,
    required this.suffixIcon,
    required this.title,
    required this.desc,
    this.leadingIcon = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  State<NewMessageWidget> createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds: 400),
      slidingBeginOffset: Offset(0, 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 0.7),
                    shape: BoxShape.circle,
                    image:
                        DecorationImage(image: AssetImage(widget.suffixIcon))),
              ),
              SizedBox(
                width: 6,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: bodyNormal.copyWith(fontFamily: "InterSemiBold"),
                    ),
                    Text(
                      widget.desc,
                      style: bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
