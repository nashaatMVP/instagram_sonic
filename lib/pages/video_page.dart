import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:video_player/video_player.dart';
import '../widgets/custom_text.dart';


class VideoPage extends StatefulWidget {
  const VideoPage({super.key, required this.videLink, required this.userName, required this.userImg});
  final String videLink , userName , userImg;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller =
    VideoPlayerController.networkUrl(
      Uri.parse(widget.videLink),
    )..initialize().then((v) {
      setState(() {
        _controller.play();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleVideo () {
    setState(() {
      if(_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
          _controller.value.isInitialized
              ? GestureDetector(
               onTap: toggleVideo,
               child: Expanded(child: Stack(
                 children: [
                   VideoPlayer(_controller),
                   Positioned(
                     top: 80,
                     left: 20,
                     right: 20,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         GestureDetector(
                           child: Icon(Icons.arrow_back_ios),
                           onTap: () => Navigator.pop(context),
                         ),
                         CustomText(txt: 'Your Reels', fontSize: 19),
                         Icon(Icons.camera_alt_outlined),
                       ],
                     ),
                   ),
                   Positioned(
                     bottom: 190,
                     right: 10,
                     child: Column(
                       children: [
                         Icon(Icons.favorite_border,size: 32),
                         SizedBox(height: 3),
                         Text("345",style: TextStyle(color: Colors.white)),
                         SizedBox(height: 30),
                         Icon(Ionicons.chatbubble_ellipses_outline,size: 32),
                         SizedBox(height: 3),
                         Text("14",style: TextStyle(color: Colors.white)),
                         SizedBox(height: 30),
                         Icon(Icons.send,size: 32),
                         SizedBox(height: 3),
                         Text("1K",style: TextStyle(color: Colors.white)),
                         SizedBox(height: 30),
                         Icon(Icons.more_horiz,size: 32),
                         SizedBox(height: 3),
                       ],
                     ),
                   ),
                   Positioned(
                     bottom: 40,
                     left: 0,
                     right: 0,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           children: [
                             SizedBox(width: 20),
                             CircleAvatar(radius: 20,backgroundImage: NetworkImage(widget.userImg)),
                             SizedBox(width: 15),
                             Text(widget.userName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),
                           ],
                         ),
                         SizedBox(height: 10),
                         Row(
                           children: [
                             SizedBox(width: 25),
                             Text("...  How to clean your car 🚗😳"),
                           ],
                         ),
                         SizedBox(height: 16),
                         Divider(
                           color: Colors.white,
                           endIndent: 20,
                           indent: 20,
                           height: 1,
                         ),
                         SizedBox(height: 18),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 50.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Row(
                                 children: [
                                   Icon(Icons.remove_red_eye_outlined),
                                   SizedBox(width: 10),
                                   Text("310K . View insights"),
                                 ],
                               ),
                               Row(
                                 children: [
                                   Icon(Icons.trending_up_outlined),
                                   SizedBox(width: 10,),
                                   Text("Boost reel"),
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
                 ],
               )))
              : Center(child: CupertinoActivityIndicator()),
    );
  }
}
