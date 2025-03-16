import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_app/pages/user.dart';
import 'package:flutter_insta_app/widgets/custom_text.dart';
import 'package:flutter_insta_app/widgets/snackbar_card.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  Map info = {};
  bool isLoading = false;

  // get Method
  Future<void> getInfo (String userName) async {
    setState(() {
      isLoading = true;
    });
    final uri = 'https://social-api4.p.rapidapi.com/v1/info?username_or_id_or_url=$userName';
    final url = Uri.parse(uri);
    final response = await http.get(
        url,
        headers: {
          'x-rapidapi-key': '6210b8867amsh5e79395f8e627ddp13475fjsn69b250bb58e9',
          'x-rapidapi-host': 'social-api4.p.rapidapi.com',
        },
    );

    final json = jsonDecode(response.body) as Map;
    final result = json['data'] as Map;
    setState(() {
      info = result;
      isLoading = false;
    });
    navigateToUserPage(info);

    if(response.statusCode == 200) {
      CustomSnackBar.success(context,"Data Fetched Successfully");
    } else {
      CustomSnackBar.error(context,"Something went wrong ${response.statusCode}");
    }

  }

  // navigate to user screen
  void navigateToUserPage (Map info) {
    final route = MaterialPageRoute(builder: (c) => User(info: info));
    Navigator.push(context, route);
  }

  @override
  void initState() {
    controller.text = "bmw";
    focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset(
              "assets/loading.json",
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.black45.withAlpha(900).withOpacity(0.7),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 170),
                  Center(child: Icon(Ionicons.logo_instagram,size: 60,color: Colors.pinkAccent)),
                  SizedBox(height: 50),
                  CustomText(
                      txt: 'Enter UserName :',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 48,
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        hintText: "username",
                        filled: true,
                        fillColor: Colors.grey.shade800.withOpacity(0.8),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black12,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pink.shade100,
                            ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  GestureDetector(
                    onTap: () {
                      if(controller.text.isEmpty || controller.text == "") {
                        return;
                      } else {
                        getInfo(controller.text);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 9),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.white70,
                          Colors.white,
                          Colors.white,
                          Colors.white70,
                        ]),
                      ),
                      child: Center(
                        child: isLoading
                          ? LottieBuilder.asset("assets/loading.json")
                          : CustomText(
                          txt: 'Enter',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: Column(
                      children: [
                        CustomText(
                          txt:
                          '© 1993-2025 License All rights reserved.',
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                        SizedBox(height: 4),
                        CustomText(
                          txt:
                          'contact us+971',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.blueAccent,
                        ),
                        Divider(color: Colors.blueAccent,endIndent: 147,indent: 147,height: 1),
                      ],
                    ),
                  ),
                  SizedBox(height: 38),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
