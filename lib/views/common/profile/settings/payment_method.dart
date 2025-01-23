import 'package:beauty_connect/localization/languages/languages.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:beauty_connect/views/common/profile/settings/add_new_payment.dart';
import 'package:beauty_connect/widgets/custom_dialog.dart';
import 'package:beauty_connect/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/global_variables.dart';

class PaymentMethod extends StatelessWidget {
  final bool fromSetting;
  const PaymentMethod({super.key, this.fromSetting = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black12,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: Languages.of(context)!.paymentMethods,
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
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Credit & Debit Card", style: headingSmall,)),
            SizedBox(height: 10,),
            _addPayment(context, "assets/images/mastercard.png", "MasterCard", fromSetting == true? Languages.of(context)!.remove :Languages.of(context)!.add, fromSetting == true? true : false),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(Languages.of(context)!.otherWallets, style: headingSmall,)),
            SizedBox(height: 10,),
            _addPayment(context, "assets/icons/setting/paypal.png", "PayPal", Languages.of(context)!.remove, true),
            SizedBox(height: 10,),
            _addPayment(context, "assets/icons/setting/apple.png", "Apple Pay", Languages.of(context)!.add, false),
          ],
        ),
      ),
    );
  }

  _addPayment(
      context,
    String icon,
    String title,
    String status,
      bool isRemove,
  {Color statusColor= AppColors.buttonColor}
  ) {
    return DelayedDisplay(
      slidingBeginOffset: Offset(1, 0),
      delay: Duration(milliseconds: 200),
      child: Column(
        children: [
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 18),
            margin: EdgeInsets.only(bottom: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.textFieldColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        icon,
                        height: 34,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: headingSmall,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    if(isRemove == true && fromSetting ==true){
                      showCustomDialog(context, "assets/images/popup/ask.png", Languages.of(context)!.areYouSure, "${Languages.of(context)!.areYouSureYouWantTRemove} $title ${Languages.of(context)!.fromThisAccount}", Languages.of(context)!.yesRemove, (){}, null);
                    } else
                      {
                        Get.to(() => AddNewPayment(paymentTitle: Languages.of(context)!.addNewPayment,));
                      }
                  },
                  child: Text(
                    fromSetting == false ? Languages.of(context)!.add :
                    status,
                    style: headingSmall.copyWith(fontSize:12, color: statusColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
