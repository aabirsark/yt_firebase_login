import "dart:convert";

import "package:http/http.dart" as http;
import "package:yt_firebase_login/stream_sb_source.dart";
import "package:yt_firebase_login/util.dart";

/// For extracting the video from stream SB
extractStreamSB(String url) async {
  final id = findBetween("/e/", ".html", url) ?? url.split("/e/")[1];

  // getting streamSB URL
  final source = await http.get(Uri.parse(
      "https://raw.githubusercontent.com/saikou-app/mal-id-filler-list/main/sb.txt"));
  final sourceURL = source.body.trim();

  final jsonLink = "${bytesToHex(('||$id||||streamsb').codeUnits)}/";

  // Getting the video info
  final uri = Uri.parse("$sourceURL/$jsonLink");

  // getting link
  final json = await http.get(uri, headers: {"watchsb": "sbstream"});

  final streamSource = StreamSBSource.fromJson(jsonDecode(json.body));

  if (streamSource.statusCode != 200){
    throw  Exception(['Bad url format' ,'possible things : bad url format , bad server response' ]);
  }

  print(streamSource.streamData?.file);

  // imp note !!!! use these headers when making video request to this url
  //   Map<String, String> defaultHeaders = {
  //   "User-Agent": "Mozilla/5.0 (Linux; Android ${Platform.operatingSystemVersion}; ${Platform.operatingSystem} ${Platform.version}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Mobile Safari/537.36"
  // };

  return streamSource;
}

// CAN ALSO USE package like converter --- this is hardcoded for being performant
String bytesToHex(List<int> bytes) {
  const hexDigits = '0123456789ABCDEF';
  final codeUnits = bytes.map((byte) => byte & 0xff);
  final hexChars = <String>[];
  for (final codeUnit in codeUnits) {
    hexChars.add(hexDigits[(codeUnit >> 4) & 0xf]);
    hexChars.add(hexDigits[codeUnit & 0xf]);
  }
  return hexChars.join();
}
