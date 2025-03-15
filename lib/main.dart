import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_app/pages/home.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return const Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: CupertinoActivityIndicator()));
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Home(),
    );
  }
}


