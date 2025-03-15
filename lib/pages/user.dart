import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_app/pages/video_page.dart';
import 'package:flutter_insta_app/widgets/custom_text.dart';
import 'package:flutter_insta_app/widgets/user_info.dart';
import '../widgets/button_card.dart';
import '../widgets/category_info.dart';
import 'package:http/http.dart' as http;

class User extends StatefulWidget {
  const User({super.key, required this.info});
  final Map info;

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  List img = [
    "https://picsum.photos/200/300",
    "https://picsum.photos/200/300",
    "https://picsum.photos/200/300",
  ];
  List followers = [];
  List posts = [];
  List reels = [];

  // getFollowers
  Future<void> getFollowers () async {
    final userName = widget.info['username'];
    final uri = "https://social-api4.p.rapidapi.com/v1/followers?username_or_id_or_url=$userName";
    final url = Uri.parse(uri);
    final response = await http.get(
        url,
        headers: {
          'x-rapidapi-key': '6210b8867amsh5e79395f8e627ddp13475fjsn69b250bb58e9',
          'x-rapidapi-host': 'social-api4.p.rapidapi.com'
        },
    );

    final json = jsonDecode(response.body) as Map;
    final result = json['data']['items'] as List;
    setState(() {
      followers = result;
    });
  }

  // getPosts
  Future<void> getPosts () async {
    final userName = widget.info['username'];
    final uri = "https://social-api4.p.rapidapi.com/v1/posts?username_or_id_or_url=$userName";
    final url = Uri.parse(uri);
    final response = await http.get(
      url,
      headers: {
        'x-rapidapi-key': '6210b8867amsh5e79395f8e627ddp13475fjsn69b250bb58e9',
        'x-rapidapi-host': 'social-api4.p.rapidapi.com'
      },
    );

    final json = jsonDecode(response.body) as Map;
    final result = json['data']['items'] as List;
    setState(() {
      posts = result;
    });
  }

  // getReels
  Future<void> getReels() async {
    final userName = widget.info['username'];
    final uri = "https://social-api4.p.rapidapi.com/v1/reels?username_or_id_or_url=$userName";
    final url = Uri.parse(uri);
    final response = await http.get(
      url,
      headers: {
        'x-rapidapi-key': '6210b8867amsh5e79395f8e627ddp13475fjsn69b250bb58e9',
        'x-rapidapi-host': 'social-api4.p.rapidapi.com'
      },
    );

    final json = jsonDecode(response.body) as Map;
    final result = json['data']['items'] as List;
    setState(() {
      reels = result;
    });
  }



  @override
  void initState() {
    getFollowers();
    getPosts();
    getReels();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final info = widget.info;
    final category = info['category'];
    final username = info['username'];
    final userPic = info['profile_pic_url_hd'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: 20,
        title: CustomText(
            txt: username,
            fontWeight: FontWeight.bold,
        ),
        actions: [
          Icon(Icons.notifications_none),
          SizedBox(width: 20,),
          Icon(Icons.more_horiz),
          SizedBox(width: 20,),

        ],
      ),

      body: Column(
        children: [

          // user details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                UserInfo(
                  userImg: userPic,
                  folowersNumber: followers.length.toString(),
                ),
                SizedBox(height: 8),
                CategoryInfo(
                  category: category,
                  img: [
                    followers[0]['profile_pic_url'] ?? "https://picsum.photos/200/300",
                    followers[1]['profile_pic_url'] ?? "https://picsum.photos/200/300",
                    followers[2]['profile_pic_url'] ?? "https://picsum.photos/200/300",
                  ],
                ),
                SizedBox(height: 20),
                ButtonCard(),

              ],
            ),
          ),
          SizedBox(height: 30),

          // Tab bar styling
          TabBar(
              controller: _tabController,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.white,
              padding: EdgeInsets.all(3),
              dividerColor: Colors.black,
              labelPadding: EdgeInsets.all(10),
              indicatorColor: Colors.white, // Change indicator color
              indicatorWeight: 1.0, // Adjust thickness
              indicatorSize: TabBarIndicatorSize.tab,
              dragStartBehavior: DragStartBehavior.down,
              tabs: [
                Icon(Icons.grid_on),
                Icon(Icons.video_library_outlined),
                Icon(Icons.person_add_alt),
              ],
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [

              // posts
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio:  1.1 / 2,
                  ),
                  itemCount: posts.length,
                  itemBuilder: (context , index) {
                    final post = posts[index];
                    return Image.network(
                      post['thumbnail_url'],
                    );
                  },
              ),

              // reels
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio:  0.9 / 1.6,
                  ),
                  itemCount: reels.length,
                  itemBuilder: (context , index) {
                    final reel = reels[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (c) => VideoPage(
                            videLink: reel['video_url'],
                            userImg: userPic,
                            userName: username,
                          ))),
                      child: Image.network(
                        reel['thumbnail_url'],
                      ),
                    );
                  },
                ),

              // mention
              Icon(Icons.person_add_alt),
            ]),
          ),


        ],
      ),


    );
  }
}
