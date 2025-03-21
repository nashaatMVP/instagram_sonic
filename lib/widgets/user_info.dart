import 'package:flutter/material.dart';
import 'package:flutter_insta_app/widgets/custom_text.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.userImg, required this.followersNumber, required this.postsNumber,
  });
  final String userImg , followersNumber , postsNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                colors: [
                  Colors.pinkAccent,
                  Colors.pinkAccent,
                  Colors.orangeAccent,
                ]
            ),
          ),
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(userImg),

          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                txt: postsNumber,
                 fontWeight: FontWeight.bold,
                 fontSize: 18,
            ),
            CustomText(txt: "Posts"),
          ],
        ),
        SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                txt: followersNumber,
                 fontWeight: FontWeight.bold,
                 fontSize: 18,
            ),
            CustomText(txt: "followers"),
          ],
        ),
        SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                txt: "74",
                 fontWeight: FontWeight.bold,
                 fontSize: 18,
            ),
            CustomText(txt: "following"),
          ],
        ),
      ],
    );
  }
}
