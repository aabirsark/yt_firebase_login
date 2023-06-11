
import 'package:yt_firebase_login/stream_sb/stream_header.dart';

class StreamSBSource {
  int? statusCode;
  StreamData? streamData;
  StreamHeader? header; 

  StreamSBSource({this.statusCode, this.streamData,});

  StreamSBSource.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    streamData = json['stream_data'] != null
        ?  StreamData.fromJson(json['stream_data'])
        : null;
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status_code'] = statusCode;
    if (streamData != null) {
      data['stream_data'] = streamData!.toJson();
    }
  
    return data;
  }
}

class StreamData {
  String? hash;
  String? country;
  List<dynamic>? subs;
  int? length;
  String? file;
  String? backup;
  int? id;
  String? cdnImg;
  String? title;
  int? bitrate;

  StreamData(
      {this.hash,
      this.country,
      this.subs,
      this.length,
      this.file,
      this.backup,
      this.id,
      this.cdnImg,
      this.title,
      this.bitrate});

  StreamData.fromJson(Map<String, dynamic> json) {
    hash = json['hash'];
    country = json['country'];
    
    length = json['length'];
    file = json['file'];
    backup = json['backup'];
    id = json['id'];
    cdnImg = json['cdn_img'];
  
    title = json['title'];
    bitrate = json['bitrate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hash'] = hash;
    data['country'] = country;
    if (subs != null) {
      data['subs'] = subs!.map((v) => v.toJson()).toList();
    }
    data['length'] = length;
    data['file'] = file;
    data['backup'] = backup;
    data['id'] = id;
    data['cdn_img'] = cdnImg;
 
    data['bitrate'] = bitrate;
    return data;
  }
}