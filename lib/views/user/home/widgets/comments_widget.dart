import 'package:flutter/material.dart';
import '../../../../constants/global_variables.dart';

class CommentsWidget extends StatefulWidget {
  final String name;
  final String commentText;
  final String imageUrl;
  final String likes;
  CommentsWidget({
    required this.name,
    required this.commentText,
    required this.imageUrl,
    required this.likes,
  });
  @override
  _CommentsWidgetState createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(widget.imageUrl),
                  maxRadius: 28,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              widget.name,
                              style: headingSmall.copyWith(fontSize: 12),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "2d",
                              style: bodySmall,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(widget.commentText, style: bodySmall),
                        SizedBox(
                          height: 4,
                        ),
                        Text(widget.likes, style: bodySmall),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              height: 18,
              width: 18,
              child: Center(child: Image.asset("assets/icons/home/like.png")),
            ),
          ),
        ],
      ),
    );
  }
}
