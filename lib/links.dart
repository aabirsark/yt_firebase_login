import 'dart:convert';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/export.dart';
import 'package:yt_firebase_login/url_extractor.dart';

class Keys {
  String key;
  String iv;
  Keys({required this.key, required this.iv});
}

class Source {
  String file;
  String label;
  String type;
  String res;
  Source(
      {required this.file,
      required this.label,
      required this.type,
      required this.res});
}

class SourceResponse {
  List<Source> sources;
  SourceResponse({required this.sources});

  factory SourceResponse.fromJson(Map<String, dynamic> json) {
    var list = json['sources'] as List;
    List<Source> sourcesList = list
        .map((i) => Source(
            file: i['file'], label: i['label'], type: i['type'], res: i['res']))
        .toList();
    return SourceResponse(sources: sourcesList);
  }
}

class Video {
  String url;
  String quality;
  Video({required this.url, required this.quality});
}

Future<List<String>> extract(String serverUrl) async {
  // final serverUrl =
  //     'https://playtaku.net/streaming.php?id=MjAzNTM2&token=YyOdGjw4yU9chq6_4pqAXA&expires=1682721180';
  const referer = 'https://playtaku.net';
  final client = http.Client();
  final url = Uri.parse(serverUrl);

  if (serverUrl.contains('streaming.php')) {
    final response = await client.get(url, headers: {'referer': referer});
    final body = response.body;
    var document = parse(response.body);

    var it = document
        .querySelector("script[data-name=\"episode\"]")
        ?.attributes["data-value"];
    print(it);
    final keysAndIv = Keys(
        key: '37911490979715163134003223491201',
        iv: '3134003223491201');
    final videoUrl = cryptoHandler(it ?? "", keysAndIv.key, keysAndIv.iv);
    return [videoUrl];
  }

  if (serverUrl.contains('embedplus')) {
    final response = await client.get(url, headers: {'referer': referer});
    final body = response.body;
    final regex = RegExp(r'hd_src_no_ratelimit\\":\\"(.*?)\\"');
    final match = regex.firstMatch(body);
    if (match != null) {
      final videoUrl = json.decode('"${match.group(1)}"');
      return [videoUrl];
    }
    throw Exception('Video URL not found.');
  }

  throw Exception('Server URL not recognized.');
}