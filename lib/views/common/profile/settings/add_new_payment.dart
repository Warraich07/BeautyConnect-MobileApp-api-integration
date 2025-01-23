import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/custom_validators.dart';
import '../../../../constants/global_variables.dart';
import '../../../../widgets/custom_widgets.dart';
import '../../../../widgets/text_form_fields.dart';

class AddNewPayment extends StatefulWidget {
  final String paymentTitle;
  const AddNewPayment({super.key, required this.paymentTitle});

  @override
  State<AddNewPayment> createState() => _AddNewPaymentState();
}

class _AddNewPaymentState extends State<AddNewPayment> {
  bool setDefault = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: widget.paymentTitle,
          onTapLeading: () {
            Get.back();
          },
          leadingButton: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              DelayedDisplay(
                slidingBeginOffset: Offset(0, -1),
                delay: Duration(milliseconds: 200),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Languages.of(context)!.enterFollowingDetailsToAddPaymentMethod,
                    style: headingSmall.copyWith(color: Colors.black38),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 500),
                slidingBeginOffset: Offset(0, -1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Languages.of(context)!.cardName, style: headingSmall),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      validator: (value) =>
                          CustomValidator.isEmptyUserName(value,context),
                      hintText: Languages.of(context)!.cardName,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              DelayedDisplay(
                delay: Duration(milliseconds: 500),
                slidingBeginOffset: Offset(0, -1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Languages.of(context)!.cardNumber, style: headingSmall),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      validator: (value) =>
                          CustomValidator.isEmptyUserName(value,context),
                      keyboardType: TextInputType.number,
                      hintText: "0000 0000 0000 0000",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              DelayedDisplay(
                delay: Duration(milliseconds: 500),
                slidingBeginOffset: Offset(0, -1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Languages.of(context)!.expiryDate, style: headingSmall),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      validator: (value) =>
                          CustomValidator.isEmptyUserName(value,context),
                      keyboardType: TextInputType.datetime,
                      hintText: "dd/mm/yyyy",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              DelayedDisplay(
                delay: Duration(milliseconds: 500),
                slidingBeginOffset: Offset(0, -1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("CVV:", style: headingSmall),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      validator: (value) =>
                          CustomValidator.isEmptyUserName(value,context),
                      keyboardType: TextInputType.number,
                      hintText: "000",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          setDefault = !setDefault;
                        });
                      },
                      child: Row(
                        children: [
                          DelayedDisplay(
                            child: Container(
                              height: 20,
                              width: 20,
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: setDefault == true
                                        ? AppColors.primaryColor
                                        : Colors.black,
                                    width: 1.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                  child: Icon(
                                    setDefault == true ? Icons.check : null,
                                    size: 14,
                                    color: AppColors.primaryColor,
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          DelayedDisplay(
                            delay: Duration(milliseconds: 500),
                            slidingBeginOffset: Offset(0, -1),
                            child: RichText(
                              text: TextSpan(
                                text: Languages.of(context)!.setAsDefault,
                                style: headingSmall.copyWith(
                                    color: AppColors.secondaryColor,
                                    fontSize: 13),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(onTap: (){},  buttonText: Languages.of(context)!.addNew,),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
