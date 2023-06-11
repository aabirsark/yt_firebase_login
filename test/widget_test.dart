// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yt_firebase_login/doodstream/doodstream.dart';
import 'package:yt_firebase_login/links.dart';

import 'package:yt_firebase_login/main.dart';
import 'package:yt_firebase_login/stream_sb/stream_sb.dart';
import 'package:yt_firebase_login/stream_sb_source16/stream_sb_source_link.dart';

void main() {
  group("testing api", () {
    // FOR CHECKING THE CODE
    test("extraction vidstream", () async {
      const String url =
          "https://playtaku.net/streaming.php?id=MzUzOA==&title=Naruto+Shippuden+Episode+290";
      final res = await extract(url);
    });

    test("extraction streamSB", () async {
      const String url = "https://sbani.pro/e/qoiyrfuui0w5";

      final res = await videosData(url, {}, manualData: true, common: true);
      print(res);
    });

    test("extraction doodstream", () async {
      const String url = "https://dood.wf/e/8jtwsa1wpwhh";
      final res = await extractDoodstream(url);
    });
  });
}
