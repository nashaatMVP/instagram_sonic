import 'package:flutter/material.dart';
import 'package:flutter_insta_app/widgets/custom_text.dart';

class CategoryInfo extends StatelessWidget {
  const CategoryInfo({super.key, required this.img, required this.category});
  final List img;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            txt: category,
             color: Colors.blue.shade200,
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Transform.rotate(
                angle: -10,
                child: Icon(Icons.link)),
            SizedBox(width: 9,),
            CustomText(
              txt: "https://jednvrnvirnv.com",
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 17),
        Row(
          children: [
            SizedBox(
              height: 40,
              width: (img.length * 27.0) + 18,
              child: Stack(
                children: [
                  for (int i = 0; i < img.length; i++)
                    Positioned(
                      left: i * 25.0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(img[i]),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 310,
              child: CustomText(
                maxLines: 2,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                txt: "Followed by vot444, a_ejfneef , frfrf and messi",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
