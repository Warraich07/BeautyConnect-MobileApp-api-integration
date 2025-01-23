import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/global_variables.dart';
import '../../../models/chat_detail_model.dart';
import '../../../utils/time_date_functions.dart';

class ChatDetailScreen extends StatefulWidget {
  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          flexibleSpace: SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 5, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      height: 30, width: 30,
                      padding: EdgeInsets.only(left: 5),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),),
                  ),
                  SizedBox(width: 5,),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        AssetImage("assets/images/cameron.png"),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      "Cameron Williamson",
                      style: headingSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Divider(
              height: 0,
              color: Colors.black38,
            ),
            ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              reverse: true,
              padding: EdgeInsets.only(top: 10, bottom: 80),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 4),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: messages[index].messageType == "receiver"
                              ? Radius.zero
                              : Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: messages[index].messageType == "receiver"
                              ? Radius.circular(12)
                              : Radius.zero,
                        ),
                        color: (messages[index].messageType == "receiver"
                            ? Colors.black12
                            : AppColors.primaryColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            messages[index].messageContent,
                            style: bodyNormal.copyWith(
                              color: (messages[index].messageType == "receiver"
                                  ? Colors.black
                                  : Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                TimeDateFunctions.timeInDigits(
                                    TimeDateFunctions.timestamp),
                                style: bodySmall.copyWith(
                                  fontSize: 11,
                                    color: (messages[index].messageType ==
                                            "receiver"
                                        ? Colors.black54
                                        : Colors.white)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                padding: EdgeInsets.only(bottom: 10),
                height: 70,
                color: Colors.white,
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primaryColor.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _messageController,
                                cursorColor: AppColors.primaryColor,
                                style: bodyNormal,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: "Write something nice...",
                                    hintStyle:
                                        bodySmall.copyWith(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            InkWell(
                              onTap:  () {
                                    },
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.only(right: 5),
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset(
                                    "assets/icons/attach_icon.png",
                                  )),
                            ),
                            InkWell(
                              onTap: _messageController.text.isEmpty
                                  ? null
                                  : () {
                                      ChatMessage message = ChatMessage(
                                          messageContent:
                                              _messageController.text,
                                          messageType: "sender");
                                      messages.add(message);
                                      _messageController.clear();
                                      setState(() {});
                                    },
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.primaryColor),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
