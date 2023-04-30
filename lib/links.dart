import 'dart:convert';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/export.dart';
import 'package:yt_firebase_login/source.model.dart';
import 'package:yt_firebase_login/url_extractor.dart';
import 'package:yt_firebase_login/util.dart';

class Keys {
  String key;
  String iv;
  Keys({required this.key, required this.iv});
}

Future extract(String serverUrl) async {
  // HOST OF THE FETCHING SERVER
  const referer = 'https://playtaku.net';
  final client = http.Client();
  final url = Uri.parse(serverUrl);

  // FETCH THE BODY OF THE URL
  final response = await client.get(url, headers: {'referer': referer});
  var document = parse(response.body);

  if (serverUrl.contains('streaming.php')) {
    // GET THE MAIN BODY OF THE DOCUMENT
    var it = document
        .querySelector("script[data-name=\"episode\"]")
        ?.attributes["data-value"];

    // DESTRUCTURING KEYS
    final keysAndIv =
        Keys(key: '37911490979715163134003223491201', iv: '3134003223491201');

    final decrypted = cryptoHandler(it ?? "", keysAndIv.key, keysAndIv.iv)
        .replaceAll("\t", "");


    final id = findBetween("", "&", decrypted)!;
    final end = substringAfter(decrypted, id);

    // MAKING A ENCRYPTED URL FOR GETTING VIDEOS
    final encryptedId =
        cryptoHandler(id, keysAndIv.key, keysAndIv.iv, encrypt: true);

    final encryptedUrl =
        "https://${url.host}/encrypt-ajax.php?id=$encryptedId$end&refer=none&alias=$id";

    final encrypted = await client.get(
      Uri.parse(encryptedUrl),
      headers: {"X-Requested-With": "XMLHttpRequest", "referer": referer},
    );

    final data = jsonDecode(encrypted.body);

    // FINAL JSON FOR THE VIDEO SOURCES
    final jumbledJson = cryptoHandler(data['data'] ?? "",
            "54674138327930866480207815084989", keysAndIv.iv,
            encrypt: false)
        .replaceAll("""o"<P{#meme":""", """e":[{"file":""");

    // CONVERT IT INTO DART CODE
    final source = Sources.fromJson(jsonDecode(jumbledJson));

    print(source.source?[0].file);

    return jumbledJson;
  }

  if (serverUrl.contains('embedplus')) {
    print(document.attributes); // IT RETURNS AN EMPTY BODY BY DEFAULT (FROM SERVER) => No use
    return;
  }

  throw Exception('Server URL not recognized.');
}
