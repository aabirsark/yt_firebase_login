import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yt_firebase_login/stream_sb/stream_sb_source.dart';

import '../source.model.dart';

const String PREF_ENDPOINT_KEY = "streamsb_api_endpoint";
const String PREF_ENDPOINT_DEFAULT = "/sources16";
const String ENDPOINT_URL =
    "https://raw.githubusercontent.com/Claudemirovsky/streamsb-endpoint/master/endpoint.txt";

Future<List> videosData(
  String url,
  Map<String, String> headers, {
  String prefix = "",
  String suffix = "",
  bool common = true,
  bool manualData = false,
}) async {
  String trimmedUrl = url.trim(); // Prevents some crashes
  Map<String, String> newHeaders = manualData
      ? headers
      : {
          "referer": trimmedUrl,
          "watchsb": "sbstream",
          "authority": "embedsb.com"
        };

  try {
    String master = manualData ? trimmedUrl : await fixUrl(trimmedUrl, common);

    var request = await http.get(Uri.parse(master), headers: newHeaders);

    String responseBody = request.statusCode == 200
        ? request.body
        : (await http.get(Uri.parse(await fixUrl(trimmedUrl, common)),
                headers: newHeaders))
            .body;

    print(responseBody);

    Response json = Response.fromJson(jsonDecode(responseBody));

    String masterUrl = json.stream_data.file.trim();

    var masterPlaylistRequest =
        await http.get(Uri.parse(masterUrl), headers: newHeaders);
    String masterPlaylist = masterPlaylistRequest.body;

    List<Track> subtitleList = json.stream_data.subs
            ?.map((item) => Track(item.file, item.label))
            .toList() ??
        [];

    RegExp audioRegex =
        RegExp(r'#EXT-X-MEDIA:TYPE=AUDIO.*?NAME="(.*?)".*?URI="(.*?)"');
    List<Track> audioList = audioRegex
        .allMatches(masterPlaylist)
        .map((match) => Track(match.group(2)!, match.group(1)!))
        .toList();

    String separator = "#EXT-X-STREAM-INF";
    List<String> playlistParts =
        masterPlaylist.substringAfter(separator).split(separator);

    return playlistParts.map((part) {
      String resolution =
          "${part.substringAfter("RESOLUTION=").substringBefore("\n").substringAfter("x").substringBefore(",")}p";

      String quality = ("StreamSB:$resolution").let((String it) {
        return StringBuffer()
          ..write(prefix.isNotEmpty ? "$prefix " : "")
          ..write(it)
          ..write(prefix.isNotEmpty ? " $suffix" : "");
      }).toString();

      String videoUrl = part.substringAfter("\n").substringBefore("\n");

      return videoUrl;
    }).toList();
  } catch (e) {
    print(e);
    return [];
  }
}

fixUrl(String url, bool common) async {
  Uri uri = Uri.parse(url);
  String host = uri.host;
  String endpoint = await getEndpoint();
  String sbUrl = 'https://$host$endpoint';
  String id = url
      .substringAfter(host)
      .substringAfter("/e/")
      .substringAfter("/embed-")
      .substringBefore("?")
      .substringBefore(".html")
      .substringAfter("/");

  String result = sbUrl;
  if (common) {
    List<int> idBytes = id.codeUnits;
    String hexBytes = bytesToHex(idBytes);
    result +=
        '/625a364258615242766475327c7c${hexBytes}7c7c4761574550654f7461566d347c7c73747265616d7362';
  } else {
    String encodedId = Uri.encodeComponent('||$id||||streamsb');
    List<int> idBytes = utf8.encode(encodedId);
    String hexBytes = bytesToHex(idBytes);
    result += '/$hexBytes/';
  }
  return result;
}

Future<String> getEndpoint() async {
  var response = await http.get(Uri.parse(ENDPOINT_URL));
  return response.body;
}

String substringAfter(String string, String separator) {
  int index = string.indexOf(separator);
  return index != -1 ? string.substring(index + separator.length) : '';
}

String substringBefore(String string, String separator) {
  int index = string.indexOf(separator);
  return index != -1 ? string.substring(0, index) : '';
}

extension StringExtensions on String {
  String substringAfter(String pattern) {
    final startIndex = indexOf(pattern);
    if (startIndex == -1) return '';

    final start = startIndex + pattern.length;
    return substring(start);
  }

  String substringBefore(String pattern) {
    final endIndex = indexOf(pattern);
    if (endIndex == -1) return '';

    return substring(0, endIndex);
  }
}

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

extension LetExtension<T> on T {
  R let<R>(R Function(T) block) {
    return block(this);
  }
}
