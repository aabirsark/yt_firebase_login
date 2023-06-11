// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

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



class Response {
  final ResponseObject stream_data;

  Response({required this.stream_data});

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stream_data': stream_data.toMap(),
    };
  }

  factory Response.fromMap(Map<String, dynamic> map) {
    return Response(
      stream_data: ResponseObject.fromMap(map['stream_data'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Response.fromJson(String source) => Response.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ResponseObject {
  final String file;
  final List<Subtitle>? subs;

  ResponseObject({required this.file, this.subs});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': file,
      'subs': subs?.map((x) => x.toMap()).toList(),
    };
  }

  factory ResponseObject.fromMap(Map<String, dynamic> map) {
    return ResponseObject(
      file: map['file'] as String,
      subs: map['subs'] != null ? List<Subtitle>.from((map['subs'] as List<int>).map<Subtitle?>((x) => Subtitle.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseObject.fromJson(String source) => ResponseObject.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Subtitle {
  final String label;
  final String file;

  Subtitle({required this.label, required this.file});

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'file': file,
    };
  }

  factory Subtitle.fromMap(Map<String, dynamic> map) {
    return Subtitle(
      label: map['label'] as String,
      file: map['file'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Subtitle.fromJson(String source) => Subtitle.fromMap(json.decode(source) as Map<String, dynamic>);
}
