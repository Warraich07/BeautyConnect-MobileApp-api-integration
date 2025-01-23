import 'package:beauty_connect/controllers/auth_controller.dart';
import 'package:beauty_connect/controllers/general_controller.dart';
import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:beauty_connect/constants/global_variables.dart';

import '../constants/custom_validators.dart';

class CountryCodePicker extends StatefulWidget {

  TextEditingController? phoneController;
  String? Function(String?)? validator;
  CountryCodePicker({super.key, this.phoneController,this.validator});

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {

   AuthController authController= Get.find();
   GeneralController generalController= Get.find();
   late PhoneNumber number;
   late String initialCountry;
   late String dialCode;
   String _countryCode='';
  @override
  void initState() {
    super.initState();
    // Initialize variables here in initState
    initialCountry=generalController.initialCountry.value;
    dialCode=generalController.dialCode.value;
    print(initialCountry);
    print(dialCode);
    number = PhoneNumber(isoCode: initialCountry,dialCode: dialCode);

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.textFieldColor,
              border: Border.all(color: AppColors.textFieldColor.withOpacity(0.0), width: 0.7),
            ),
            child: Theme(
              // brightness: Brightness.dark,
              data: ThemeData(
                brightness: Brightness.dark,
                bottomSheetTheme: BottomSheetThemeData(
                  backgroundColor: Colors.black, // Set bottom sheet background to black
                  modalBackgroundColor: Colors.black, // Set modal background to black
                ),
              ),
              child: InternationalPhoneNumberInput(

                onInputChanged: (PhoneNumber number) {

                  // print(number);

                  if(widget.phoneController!=null){
                    if (widget.phoneController!.text.isNotEmpty &&
                        widget.phoneController!.text.startsWith('0')) {
                      print('_PHONECONTROLLER: ${widget.phoneController!.text}');
                      widget.phoneController!.clear();
                      setState(() {});
                      return;
                    }
                  }

                  setState(() {

                    _countryCode = number.dialCode.toString();
                    // print(_countryCode+'country code');
                    // generalController.updateCountryCode(_countryCode);
                    print(number.isoCode);
                    print(_countryCode);
                    generalController.updateIsoAndDialCode(number.isoCode.toString(), _countryCode.toString());
                    // authController.countryCode.value=_countryCode;
                    // generalController.updateCountryCode(number.isoCode??'');
                    // print(generalController.countryCode.value);
                  });
                },
                onInputValidated: (bool value) {},
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  setSelectorButtonAsPrefixIcon: true,
                  showFlags: false, // Set this to false to hide the flag
                ),
                ignoreBlank: true,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: headingSmall,
                initialValue: number,
                inputDecoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintText: Languages.of(context)!.enterMobileNumber,
                    hintStyle: headingSmall.copyWith(color: Color(0xff9f9f9f), fontFamily: "MediumText")),
                textStyle: headingSmall.copyWith(color: Colors.white),
                cursorColor: Colors.white,
                spaceBetweenSelectorAndTextField: 0,
                validator: widget.validator,
                textFieldController: widget.phoneController,
                formatInput: true,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                inputBorder: InputBorder.none,
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
            ),
          ),
          // Positioned(
          //   left: 10,
          //   child: VerticalDivider(
          //     color: Colors.white, // Adjust the color of the divider
          //     thickness: 10, // Adjust the thickness of the divider
          //     width: 20, // Adjust the width of the space around the divider
          //   ),
          // ),
          // Positioned(
          //   top: 15,
          //   bottom: 15,
          //   left: MediaQuery.of(context).size.width*.21,
          //   child: Container(
          //     height: 40,
          //     // color: Colors.black,
          //     child: VerticalDivider(
          //           color: Colors.white54,
          //           thickness: 1,
          //           width: 2,
          //         ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

