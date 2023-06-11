import "dart:convert";
import "dart:math";

import "package:http/http.dart" as http;
import "package:yt_firebase_login/stream_sb/stream_header.dart";
import "package:yt_firebase_login/stream_sb/stream_sb_source.dart";
import "package:yt_firebase_login/util.dart";

/// For extracting the video from stream SB
extractStreamSB(String url) async {
  final id = findBetween("/e/", ".html", url) ?? url.split("/e/")[1];

  final jsonLink =
      "https://sbani.pro/375664356a494546326c4b797c7c6e756577776778623171737/${encode(id)}";

  // Getting the video info
  final uri = Uri.parse(jsonLink);

  // getting link
  final json = await http.get(uri, headers: {"watchsb": "sbstream"});

  print(json);

  final streamSource = StreamSBSource.fromJson(jsonDecode(json.body));
  streamSource.header = StreamHeader.fromJson(json.headers);

  if (streamSource.statusCode != 200) {
    throw Exception([
      'Bad url format',
      'possible things : bad url format , bad server response'
    ]);
  }

  // imp note !!!! use these headers when making video request to this url
  //   Map<String, String> defaultHeaders = {
  //   "User-Agent": "Mozilla/5.0 (Linux; Android ${Platform.operatingSystemVersion}; ${Platform.operatingSystem} ${Platform.version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Mobile Safari/537.36"
  // };

  print(streamSource.streamData?.file);

  return streamSource;
}

String encode(String id) {
  String code = '${makeId()}||$id||${makeId()}||streamsb';
  StringBuffer sb = StringBuffer();
  List<String> arr = code.split('');
  for (int j = 0; j < arr.length; j++) {
    sb.write(
        int.parse(arr[j].codeUnitAt(0).toRadixString(10)).toRadixString(16));
  }
  return sb.toString();
}

String makeId() {
  String alphabet =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  StringBuffer sb = StringBuffer();
  for (int j = 0; j < 12; j++) {
    sb.write(alphabet[Random().nextInt(alphabet.length)]);
  }
  return sb.toString();
}
