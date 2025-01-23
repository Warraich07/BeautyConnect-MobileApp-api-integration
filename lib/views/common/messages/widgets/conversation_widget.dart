import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/global_variables.dart';
import '../chat_detail.dart';

class ConversationList extends StatefulWidget {
  final String name;
  final String messageText;
  final String imageUrl;
  final String time;
  final bool isMessageRead;
  ConversationList(
      {required this.name,
      required this.messageText,
      required this.imageUrl,
      required this.time,
      required this.isMessageRead});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ChatDetailScreen(),
            transition: Transition.rightToLeftWithFade);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
                color: widget.isMessageRead
                ? Colors.white : AppColors.primaryColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage(widget.imageUrl),
                        maxRadius: 30,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.name,
                                      style: headingSmall.copyWith(
                                          color: widget.isMessageRead
                                              ? Colors.black : Colors.white,),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  widget.isMessageRead
                                      ? SizedBox()
                                      : Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "1",
                                              style: bodySmall.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 11,
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                widget.messageText,
                                style: bodyNormal.copyWith(
                                    fontFamily: widget.isMessageRead
                                        ? "RegularText"
                                        : "SemiBoldText",
                                    fontSize: 12,
                                    color: widget.isMessageRead
                                        ? Colors.black54
                                        : Colors.white),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  widget.time,
                                  style: bodySmall.copyWith(
                                      fontSize: 10,
                                      fontFamily: widget.isMessageRead
                                          ? "RegularText"
                                          : "SemiBoldText",
                                      color: widget.isMessageRead
                                          ? Colors.black54
                                          : Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 0,
          ),
        ],
      ),
    );
  }
}
