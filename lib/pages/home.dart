import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_app/pages/user.dart';
import 'package:flutter_insta_app/widgets/custom_text.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();
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

    if(response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success")));
      navigateToUserPage(info);
    } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wasted !")));
    }
  }

  // navigate to user screen
  void navigateToUserPage (Map info) {
    final route = MaterialPageRoute(builder: (c) => User(info: info));
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 200),
            Center(child: Icon(Ionicons.logo_instagram,size: 100,color: Colors.pinkAccent)),
            SizedBox(height: 40),
            CustomText(
                txt: 'Enter UserName :',
            ),
            SizedBox(height: 40),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "userName",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey
                  )
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey
                    ),
                ),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {

                    if(controller.text.isEmpty || controller.text == "") {
                      return;
                    } else {
                      getInfo(controller.text);
                    }

                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Center(
                    child: isLoading ? CupertinoActivityIndicator(color: Colors.black,) : CustomText(
                        txt: 'Enter',
                        color: Colors.black,
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
