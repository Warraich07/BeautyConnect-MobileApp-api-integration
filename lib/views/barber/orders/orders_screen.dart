import 'package:beauty_connect/constants/global_variables.dart';
import 'package:beauty_connect/views/barber/orders/availability.dart';
import 'package:beauty_connect/views/barber/orders/page_views/active_orders.dart';
import 'package:beauty_connect/views/barber/orders/page_views/completed_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';


class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int selectedIndex = 0;
  List<String> topTitle = ["Active", "Completed"];

  List<String> name = [
    "Cameron Williamson",
    "Robert Fox",
    "Michel",
  ];
  List<Widget> pages=[
    ActiveOrders(),
    CompletedOrders()
  ];
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black12,
        toolbarHeight: 120,
        backgroundColor: AppColors.cardColor,
        automaticallyImplyLeading:false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Orders",
                  style: headingLarge.copyWith(fontSize: 21),
                ),
                // GestureDetector(
                //     onTap: (){
                //       Get.to(()=> Availability());
                //     },
                //     child: Image.asset("assets/icons/calender_icon.png", scale: 4,)),

              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 100.w,
              child: ListView.builder(
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        height: 55,
                        width: 42.w,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: selectedIndex == index
                              ? AppColors.buttonColor
                              : AppColors.greyText,
                        ),
                        child: Center(
                            child: Text(
                              topTitle[index],
                              style: bodyMedium.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: selectedIndex == index
                                      ? Colors.black
                                      : Colors.white),
                            )),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      body: pages[selectedIndex],
    );
  }
}
