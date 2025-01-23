import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import 'custom_widgets.dart';
import 'dropDown.dart';

class LanguageChangeAlertBox extends StatefulWidget {
  const LanguageChangeAlertBox({super.key});

  @override
  State<LanguageChangeAlertBox> createState() => _LanguageChangeAlertBoxState();
}

class _LanguageChangeAlertBoxState extends State<LanguageChangeAlertBox> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        elevation: 0,
        child: Container(
          height: 350,
          width: 100.w,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.transparent,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                      child: const Icon(
                        Icons.close,
                        size: 25,
                      ))),
              SizedBox(height: 20,),
              SizedBox(
                width: 80.w,
                child: Text(
                  "Change Language Of Translation",
                  textAlign: TextAlign.center,
                  // style: CustomTextStyle.monsBold.copyWith(fontSize: 25),
                ),
              ),
              SizedBox(height: 20,),
              const LanguageOption(),
              Spacer(),
              CustomButton(buttonText: "Done", onTap: () {
                Navigator.pop(context);

              },),
            ],
          ),
        ),
      ),
    );
  }
}
