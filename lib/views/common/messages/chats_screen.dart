import 'package:delayed_display/delayed_display.dart';
import 'package:beauty_connect/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/chat_user_model.dart';
import '../../../widgets/custom_widgets.dart';
import '../../../widgets/text_form_fields.dart';
import 'widgets/conversation_widget.dart';

class ChatsScreen extends StatefulWidget {
  final bool isProfile;

  const ChatsScreen({super.key, this.isProfile= true});
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  bool isAppBarCollapsed = false;

  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Jane Russel",
        messageText: "Awesome Setup",
        imageURL: "assets/images/cameron.png",
        time: "1 min ago"),
    ChatUsers(
        name: "Glady's Murphy",
        messageText: "That's Great",
        imageURL: "assets/images/profile_image.png",
        time: "1 hr ago"),
    ChatUsers(
        name: "Jorge Henry",
        messageText: "Hey where are you?",
        imageURL: "assets/images/profile_image.png",
        time: "1 day ago"),
    ChatUsers(
        name: "Philip Fox",
        messageText: "Busy! Call me in 20 mins",
        imageURL: "assets/images/profile_image.png",
        time: "2 days ago"),
    ChatUsers(
        name: "Debra Hawkins",
        messageText: "Thankyou, It's awesome",
        imageURL: "assets/images/profile_image.png",
        time: "5 days ago"),
    ChatUsers(
        name: "Jacob Pena",
        messageText: "will update you in evening",
        imageURL: "assets/images/profile_image.png",
        time: "5 days ago"),
    ChatUsers(
        name: "Andrey Jones",
        messageText: "Can you please share the file?",
        imageURL: "assets/images/profile_image.png",
        time: "Last week"),
    ChatUsers(
        name: "John Wick",
        messageText: "How are you?",
        imageURL: "assets/images/profile_image.png",
        time: "Last week"),
    ChatUsers(
        name: "Janey Wilson",
        messageText: "How are you?",
        imageURL: "assets/images/profile_image.png",
        time: "Last week"),
    ChatUsers(
        name: "John Wick",
        messageText: "How are you?",
        imageURL: "assets/images/profile_image.png",
        time: "Last week"),
  ];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 60) {
        // Adjust this value as needed
        setState(() {
          isAppBarCollapsed = true;
        });
      } else {
        setState(() {
          isAppBarCollapsed = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: 20,
      ),
      body: CustomScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: false,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            collapsedHeight: 120,
            elevation: 0,
            expandedHeight: 120.0,
            // Set this to the desired height
            floating: true,
            // Whether the app bar should become visible as soon as the user scrolls up.
            pinned: false,
            // Whether the app bar should stay at the top.
            flexibleSpace: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Messages", style: headingLarge.copyWith(fontSize: 24),)),
                ),
                SizedBox(height: 15,),
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: DelayedDisplay(
                    delay: Duration(milliseconds: 300),
                    slidingBeginOffset: Offset(0, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: DelayedDisplay(
                            delay: Duration(milliseconds: 300),
                            slidingBeginOffset: Offset(0, 0),
                            child: SearchTextField(
                              hintText: "Search here...",
                              prefixIcon: "assets/icons/search.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return DelayedDisplay(
                  child: ConversationList(
                    name: chatUsers[index].name,
                    messageText: chatUsers[index].messageText,
                    imageUrl: chatUsers[index].imageURL,
                    time: chatUsers[index].time,
                    isMessageRead: (index == 0 || index == 3) ? false : true,
                  ),
                );
              },
              childCount: chatUsers.length,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 50,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
