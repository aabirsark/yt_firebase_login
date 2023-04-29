import 'package:flutter/material.dart';
import 'package:yt_firebase_login/home.page.dart';


void main(List<String> args) {
runApp(const MyApp());  
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Yt tutorial",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}