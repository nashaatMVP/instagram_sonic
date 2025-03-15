import 'package:flutter/material.dart';

import 'custom_text.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                CustomText(txt: "Following",fontWeight: FontWeight.bold,),
                Icon(Icons.keyboard_arrow_down_sharp),
              ],
            ),
          ),
          SizedBox(width: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 6.5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomText(txt: "Message",fontWeight: FontWeight.bold,),

          ),
          SizedBox(width: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7,vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),

            child: Icon(Icons.person_add_alt),

          ),
        ],
      ),
    );
  }
}
