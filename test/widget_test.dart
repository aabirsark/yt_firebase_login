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
      const String url = "https://playtaku.net/embedplus?id=MjAyNDM3&amp;token=aTChrOzs1WfzteQxreSINg&amp;expires=1682843478";
      final res = await extract(url);

    });
  });
}
