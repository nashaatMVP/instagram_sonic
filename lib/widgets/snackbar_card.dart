import 'package:flutter/material.dart';
import 'package:flutter_insta_app/widgets/custom_text.dart';

class CustomSnackBar {
  static void success(context,txt) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: CustomText(
            txt: txt,
            fontWeight: FontWeight.bold,
            fontSize: 15,
        ),
          backgroundColor: Color(0xea1a4f43),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          duration: Duration(seconds: 2),
        ),
    );
  }

  static void error(context,txt) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: CustomText(
        txt: txt,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xd7560b04),
      ),
    );
  }
}

