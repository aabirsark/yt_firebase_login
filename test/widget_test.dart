// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yt_firebase_login/links.dart';

import 'package:yt_firebase_login/main.dart';

void main() {
  group("testing api", () {
    // FOR CHECKING THE CODE
    test("extraction", () async {
      const String url = "https://playtaku.net/streaming.php?id=MjAyNjg5&title=Yuusha+ga+Shinda%21+Episode+2";
      final res = await extract(url);
      print(res);

    });
  });
}
