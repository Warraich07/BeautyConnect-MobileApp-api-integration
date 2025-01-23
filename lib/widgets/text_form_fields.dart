import 'package:beauty_connect/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../constants/global_variables.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
/// Text Field Auth Screens Only
class AuthTextField extends StatefulWidget {
  final String hintText;
  final double hintTextSize;
  final double horizontalPadding;
  final double prefixLeftPadding;
  final Widget? suffixIcon;
  final String? prefixIcon;
  final TextAlign textAlign;
  final bool? isObscure;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const AuthTextField({
    Key? key,
    this.controller,
    required this.hintText,
    this.suffixIcon,
    this.isObscure,
    this.readOnly,
    this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.hintTextSize = 15,
    this.horizontalPadding = 20,
    this.prefixLeftPadding = 26,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextFormField(
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          obscureText: widget.isObscure ?? false,
          readOnly: widget.readOnly ?? false,
          controller: widget.controller,
          cursorColor: Colors.white,
          textAlign: widget.textAlign,
          style: headingSmall.copyWith(fontSize: 15),
          decoration: InputDecoration(
              fillColor: AppColors.textFieldColor,
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: widget.horizontalPadding, vertical: 18),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                    color: AppColors.textFieldColor,
                    width: 0.7),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                    color: AppColors.textFieldColor,
                    width: 0.7),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                    color: AppColors.textFieldColor,
                    width: 0.7),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(
                    color: AppColors.textFieldColor, width: 0.7),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                    color: AppColors.textFieldColor,
                    width: 0.7),
              ),
              hintText: widget.hintText,
              hintStyle: bodyNormal.copyWith(
                  color: Colors.white54, fontSize: widget.hintTextSize),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: widget.suffixIcon,
              ),
              suffixIconColor: Colors.black54,
              prefixIcon: widget.prefixIcon == null
                  ? Padding(
                padding: EdgeInsets.only(left: widget.prefixLeftPadding),
                child: SizedBox(),
              )
                  : Padding(
                padding: EdgeInsets.only(left: 26.0, right: 10),
                child: SizedBox(

                  width: 16,
                  child: Image.asset(
                    widget.prefixIcon!,
                    color: Colors.white54,
                  ),
                ),
              ),
              prefixIconColor: Color(0xffa2a2a2),
              errorStyle: TextStyle(color: Colors.white54),
              prefixIconConstraints: const BoxConstraints(
                maxHeight: 30,
                minHeight: 30,
              )),
        ),
      ),
    );
  }
}

/// Text Field
class CustomTextField extends StatefulWidget {
  final String hintText;
  final Widget? suffixIcon;
  final String? prefixIcon;
  final bool? isObscure;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final onChanged;
  final String? suffixText;
  final String? prefixText;
  const CustomTextField(
      {Key? key,
      required this.hintText,
      this.suffixIcon,
      this.isObscure,
      this.prefixIcon,
      this.validator,
      this.keyboardType,
      this.suffixText,
      this.prefixText,
      this.onChanged,
      this.controller})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextFormField(
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          obscureText: widget.isObscure ?? false,
          controller: widget.controller ?? null,
          cursorColor: Colors.white,
          onChanged: widget.onChanged ?? null,
          style: headingSmall.copyWith(fontSize: 15),
          decoration: InputDecoration(
              fillColor: AppColors.textFieldColor,
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 18),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                    color: AppColors.textFieldColor.withOpacity(0.0),
                    width: 0.7),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                    color: AppColors.textFieldColor.withOpacity(0.0),
                    width: 0.7),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                    color: AppColors.textFieldColor,
                    width: 0.7),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(
                    color: AppColors.textFieldColor, width: 0.7),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                    color: AppColors.textFieldColor.withOpacity(0.0),
                    width: 0.7),
              ),
              hintText: widget.hintText,
              hintStyle: bodyNormal.copyWith(
                  color: Colors.white54, fontSize: 15),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: widget.suffixIcon,
              ),
              suffixIconColor: Colors.white54,
              prefixIcon: widget.prefixIcon == null
                  ? Padding(
                padding: EdgeInsets.only(left: 26),
                child: SizedBox(),
              )
                  : Padding(
                padding: EdgeInsets.only(left: 26.0, right: 10),
                child: SizedBox(

                  width: 16,
                  child: Image.asset(
                    widget.prefixIcon!,
                  ),
                ),
              ),
              prefixIconColor: Color(0xffa2a2a2),
              prefixIconConstraints: const BoxConstraints(
                maxHeight: 30,
                minHeight: 30,
              )),
        ),
      ),
    );
  }
}

///Search Text Field
class SearchTextField extends StatefulWidget {
  final String hintText;
  final Widget? suffixIcon;
  final String? prefixIcon;
  final bool? isObscure;
  final FormFieldValidator<String>? validator;
  const SearchTextField(
      {Key? key,
      required this.hintText,
      this.suffixIcon,
      this.isObscure,
      this.prefixIcon,
      this.validator})
      : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100.w,
      // height: 54,
      child: Center(
        child: TextFormField(
          maxLines: 1,
          expands: false,
          validator: widget.validator,
          obscureText: widget.isObscure ?? false,
          controller: _textEditingController,
          cursorColor: Colors.black,
          style: headingSmall.copyWith(fontSize: 13),
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: AppColors.textFieldColor.withOpacity(0.5),
                    width: 0.7),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: AppColors.textFieldColor.withOpacity(0.5),
                    width: 0.7),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: AppColors.textFieldColor,
                    width: 0.7),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: AppColors.textFieldColor,
                    width: 0.7),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: AppColors.textFieldColor,
                    width: 0.7),
              ),
              hintText: widget.hintText,
              hintStyle: headingSmall.copyWith(color: Colors.black38),
              suffixIcon: widget.suffixIcon,
              suffixIconColor: Colors.black,
              prefixIcon: widget.prefixIcon == null
                  ? Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: SizedBox(),
              )
                  : Padding(
                padding: EdgeInsets.only(left: 20.0, right: 10),
                child: SizedBox(
                  width: 16,
                  child: Image.asset(
                    widget.prefixIcon!,
                  ),
                ),
              ),
              prefixIconColor: Colors.white,
              prefixIconConstraints: const BoxConstraints(
                maxHeight: 30,
                minHeight: 30,
              )),
        ),
      ),
    );
  }
}


class OtpField extends StatefulWidget {
  const OtpField({
    Key? key,
  }) : super(key: key);

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  final controller = Get.put(AuthController());
  String currentText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: PinCodeTextField(

        appContext: context,
        length: 4,
        obscureText: false,
        animationType: AnimationType.fade,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
        pinTheme: PinTheme(

          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(15),
          borderWidth: 5,
          fieldHeight: 64,
          fieldWidth: 56,
          inactiveFillColor: AppColors.cardColor,
          activeFillColor: AppColors.cardColor,
          selectedFillColor: AppColors.cardColor,
          inactiveColor: AppColors.cardColor,
          activeColor: AppColors.whiteColor,
          selectedColor: AppColors.whiteColor,
            // disabledColor:AppColors.whiteColor
        ),
        enableActiveFill: true,
        cursorColor: Colors.white,
        textStyle: headingSmall.copyWith(fontSize: 25),
        // Called when a code is typed in
        onChanged: (value) {
          setState(() {
            currentText =value;
            controller.verifyOtp.value = currentText;
          });
        },
        // Called when every textField is filled
        onCompleted: (verificationCode) {
          setState(() {
            controller.verifyOtp.value = verificationCode;
            print(controller.verifyOtp.value);
          });
          // Show custom dialog or navigate as needed
          // showCustomDialog(context, 'OTP Verified!', 'Continue', '');
          // Get.to(() => ResetPassword(controller: TextEditingController()));
        },
      ),
    );
  }
}



///Otp Fields
// class OtpField extends StatefulWidget {
//   const OtpField({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<OtpField> createState() => _OtpFieldState();
// }
//
// class _OtpFieldState extends State<OtpField> {
//   final controller = Get.put(AuthController());
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       child: OtpTextField(
//
//         numberOfFields: 4,
//         fieldWidth: 60,
//         borderWidth: 1.2,
//         margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         keyboardType: TextInputType.number,
//         borderRadius: BorderRadius.circular(15),
//         fillColor: AppColors.textFieldColor,
//         filled: true,
//         borderColor: AppColors.primaryColor.withOpacity(0.4),
//         focusedBorderColor: AppColors.primaryColor.withOpacity(0.9),
//         enabledBorderColor: AppColors.textFieldColor,
//         disabledBorderColor: AppColors.textFieldColor,
//         cursorColor: Colors.white,
//         showFieldAsBox: true,
//         textStyle: headingSmall.copyWith(fontSize: 25),
//         //runs when a code is typed in
//         onCodeChanged: (String code) {
//           setState(() {
//             controller.verifyOtp.value=code;
//           });
//           //handle validation or checks here
//         },
//         //runs when every textField is filled
//         onSubmit: (String verificationCode) {
//
//                 // print(authController.verifyOtp.value);
//                 setState(() {
//                   controller.verifyOtp.value=verificationCode;
//                   print(controller.verifyOtp.value);
//                 });
//           // showCustomDialog(context, 'OTP Verified!', 'Continue', '');
//           // Get.to(() => ResetPassword(controller: TextEditingController()));
//         }, // end onSubmit
//       ),
//     );
//   }
// }
