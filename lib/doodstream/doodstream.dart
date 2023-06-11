import 'dart:math';
import 'package:http/http.dart' as http;

String _getRandomString({int length = 10}) {
  final allowedChars = List<String>.from([
    ...List.generate(26, (index) => String.fromCharCode(65 + index)), // A-Z
    ...List.generate(26, (index) => String.fromCharCode(97 + index)), // a-z
    ...List.generate(10, (index) => '$index'), // 0-9
  ]);

  final random = Random();
  return List.generate(
      length, (_) => allowedChars[random.nextInt(allowedChars.length)]).join();
}

class Video {
  final String url;
  final String quality;
  final String videoUrl;

  Video(this.url, this.quality, this.videoUrl);
}

extractDoodstream(
  String url, {
  String? quality,
  bool redirect = true,
}) async {
  final newQuality = quality ?? 'Doodstream${redirect ? ' mirror' : ''}';

  try {
    print("fetching...");
    final response = await http.get(Uri.parse(url));

    print(response.body);

    final newUrl = redirect ? response.request!.url.toString() : url;

    final doodTld =
        _substringBefore(_substringAfter(newUrl, 'https://dood.'), '/');
    final content = response.body;

    if (content.isEmpty || !content.contains("'/pass_md5/")) {
      return null;
    }
    
    final md5 = _substringBefore(_substringAfter(content, "'/pass_md5/"), "',");
    final token = _substringAfterLast(md5, '/');
    final randomString = _getRandomString();
    final expiry = DateTime.now().millisecondsSinceEpoch;

    final videoUrlCall = await http
        .get(Uri.parse('https://dood.$doodTld/pass_md5/$md5'), headers: {
      'referer': newUrl,
    });

    final videoUrlStart = videoUrlCall.body;

    final videoUrl = '$videoUrlStart$randomString?token=$token&expiry=$expiry';

    return videoUrl;
  } catch (e) {
    return null;
  }
}

String _substringAfter(String source, String delimiter) {
  final index = source.indexOf(delimiter);
  if (index == -1) {
    return "";
  }
  return source.substring(index + delimiter.length);
}

String _substringBefore(String original, String delimiter) {
  final delimiterIndex = original.indexOf(delimiter);
  return delimiterIndex != -1
      ? original.substring(0, delimiterIndex)
      : original;
}

String _substringAfterLast(String original, String delimiter) {
  final delimiterIndex = original.lastIndexOf(delimiter);
  return delimiterIndex != -1
      ? original.substring(delimiterIndex + delimiter.length)
      : '';
}
