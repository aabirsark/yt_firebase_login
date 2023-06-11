// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Track {
  final String resolution;
  final TrackCode code;

  Track({
    required this.resolution,
    required this.code,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resolution': resolution,
      'code': code.toMap(),
    };
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      resolution: map['resolution'] as String,
      code: TrackCode.fromMap(map['code'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Track.fromJson(String source) => Track.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TrackCode {
  final String file;

  TrackCode({
    required this.file,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': file,
    };
  }

  factory TrackCode.fromMap(Map<String, dynamic> map) {
    return TrackCode(
      file: map['file'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrackCode.fromJson(String source) => TrackCode.fromMap(json.decode(source) as Map<String, dynamic>);
}
