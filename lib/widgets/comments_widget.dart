// import 'package:flutter/material.dart';
// import 'package:like_button/like_button.dart';
//
// import 'package:sizer/sizer.dart';
//
// import '../../constants/global_variables.dart';
//
// class CommentsScreen extends StatefulWidget {
//   const CommentsScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<CommentsScreen> createState() => _CommentsScreenState();
// }
//
// class _CommentsScreenState extends State<CommentsScreen> {
//   var commentController = TextEditingController();
//   bool loader = false;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   commentsView(int index) {
//     return GestureDetector(
//       onLongPress: () async {},
//       child: Column(
//         children: [
//           CommentsWidget(
//             name: "Lisa William",
//             commentText:
//                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do ksh kh😊😊😊😊🤗🤗❤️‍🔥❤️‍🔥🔥.",
//             imageUrl: "assets/images/profile_image.png",
//           ),
//         ],
//       ),
//     );
//   }
//
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   Widget build(BuildContext context) {
//     EdgeInsets pageMargin = const EdgeInsets.symmetric(horizontal: 16);
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//        backgroundColor:  Colors.white,
//
//         bottomNavigationBar: Container(
//           padding: EdgeInsets.fromLTRB(12, 4, 12, 8),
//           height: 64,
//           color: AppColors.textFieldColor,
//           width: double.infinity,
//           child: Row(
//             children: <Widget>[
//               Container(
//                 width: 45,
//                 height: 45,
//                 decoration: BoxDecoration(
//                     color: AppColors.textFieldColor,
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: AppColors.primaryColor.withOpacity(0.4),
//                     ),
//                     image: DecorationImage(
//                       image: AssetImage("assets/images/profile_image.png"),
//                       fit: BoxFit.cover,
//                     )),
//               ),
//               SizedBox(
//                 width: 6,
//               ),
//               Expanded(
//                 child: Container(
//                   width: 100.w,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color: Colors.white),
//                   child: TextFormField(
//                     cursorColor: AppColors.secondaryColor,
//                     style: bodyNormal,
//                     decoration: InputDecoration(
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 14, vertical: 6),
//                         focusedBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         hintText: "Leave your comment..",
//                         hintStyle: bodySmall.copyWith(color: Colors.grey),
//                         border: InputBorder.none),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 6,
//               ),
//               InkWell(
//                 onTap: () {},
//                 child: Container(
//                     width: 45,
//                     height: 45,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Icon(
//                         Icons.send,
//                         color: Colors.black,
//                         size: 20,
//                       ),
//                     )),
//               ),
//             ],
//           ),
//         ),
//         body: loader
//             ? const Center(
//                 child: CircularProgressIndicator(
//                 color: Colors.black,
//               ))
//             : Padding(
//                 padding: const EdgeInsets.only(top: 18.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 4,
//                         width: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: AppColors.hintColor,
//                         ),
//                       ),
//                       SizedBox(height: 10,),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Comments",
//                               style: headingLarge.copyWith(fontSize: 16),
//                             ),],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Scrollbar(
//                         controller: _scrollController,
//                         trackVisibility: true,
//                         thumbVisibility: true,
//                         child: ListView.builder(
//                           controller: _scrollController,
//                           padding: pageMargin,
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: 10,
//                           itemBuilder: (context, index) {
//                             return commentsView(index);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
//
// class CommentsWidget extends StatefulWidget {
//   final String name;
//   final String commentText;
//   final String imageUrl;
//
//   CommentsWidget({
//     required this.name,
//     required this.commentText,
//     required this.imageUrl,
//   });
//
//   @override
//   _CommentsWidgetState createState() => _CommentsWidgetState();
// }
//
// class _CommentsWidgetState extends State<CommentsWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: 58,
//       color: Colors.white,
//       padding: EdgeInsets.only(top: 2, bottom: 2),
//       margin: EdgeInsets.only(bottom: 2),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Expanded(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundImage: AssetImage(widget.imageUrl),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: Container(
//                     color: Colors.transparent,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Row(
//                           children: [
//                             Text(
//                               widget.name,
//                               style: headingSmall.copyWith(
//                                   fontSize: 14, height: 1.1),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           widget.commentText,
//                           style: bodySmall.copyWith(fontSize: 11, height: 1.3),
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 100,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 24.0),
//             child: Align(
//               alignment: Alignment.topRight,
//               child: Column(
//                 children: [
//                   LikeButton(
//                     countPostion: CountPostion.bottom,
//                     circleSize: 12,
//                     size: 14,
//                     circleColor: CircleColor(
//                         start: Color(0xff00ddff), end: Color(0xff0099cc)),
//                     bubblesColor: BubblesColor(
//                       dotPrimaryColor: AppColors.primaryColor,
//                       dotSecondaryColor: AppColors.secondaryColor,
//                     ),
//                     likeBuilder: (bool isLiked) {
//                       return Column(
//                         children: [
//                           isLiked
//                               ? Icon(
//                                   Icons.favorite,
//                                   size: 14,
//                                   color: Colors.red,
//                                 )
//                               : Icon(
//                                   Icons.favorite_border_outlined,
//                                   size: 14,
//                                   color: Colors.black54,
//
//                                 ),
//                         ],
//                       );
//                     },
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     likeCount: 199,
//                     countBuilder: (likeCount, isLiked, text) {
//                       var color =
//                           isLiked ? AppColors.primaryColor : Colors.black54;
//                       Widget result;
//                       if (likeCount == 0) {
//                         result = Text(
//                           "Like",
//                           style: bodySmall.copyWith(fontSize: 10),
//                         );
//                       } else
//                         result = Text(
//                           text,
//                           style: bodySmall.copyWith(color: color, fontSize: 10),
//                           textAlign: TextAlign.center,
//                         );
//                       return result;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
