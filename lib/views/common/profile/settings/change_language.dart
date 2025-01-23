import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/global_variables.dart';
import '../../../../widgets/custom_widgets.dart';
import '../../../../widgets/switch_widget.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  bool switch1Active = true;
  bool switch2Active = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: CustomAppBar(
            pageTitle: "Change Language",
            onTapLeading: () {
              Get.back();
            },
            leadingButton: Icon(
              Icons.arrow_back_ios,
              size: 22,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Once you select either languages, not only the app will switch to that language, also all automatic emails shall be sent to you in that selected language.",
                style: authSubHeading.copyWith(height: 1.3),
              ),
              SizedBox(
                height: 30,
              ),
              _languageSwitch(
                "English",
                switch1Active,
              ),
              _languageSwitch("French", switch2Active),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  _languageSwitch(
    String title,
    bool isActive,
  ) {
    return Container(
      height: 50,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: headingLarge.copyWith(fontSize: 16),
              ),
            ),
            SwitchWidget(
              isActive: isActive,
              onToggle: (bool) {
                switch1Active = !switch1Active;
                switch2Active = !switch2Active;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
