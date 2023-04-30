class Sources {
  List<Source>? source; 
  Track? track;
  List<String>? advertising;
  String? linkiframe;

  Sources(
      {this.source,
      this.track,
      this.advertising,
      this.linkiframe});

  Sources.fromJson(Map<String, dynamic> json) {
    if (json['source'] != null) {
      source = <Source>[];
      json['source'].forEach((v) {
        source!.add( Source.fromJson(v));
      });
    }
   
    track = json['track'] != null ?  Track.fromJson(json['track']) : null;
    if (json['advertising'] != null) {
      advertising = <String>[];
      json['advertising'].forEach((v) {
        advertising!.add(v);
      });
    }
    linkiframe = json['linkiframe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (source != null) {
      data['source'] = source!.map((v) => v.toJson()).toList();
    }
    
    if (track != null) {
      data['track'] = track!.toJson();
    }
    if (advertising != null) {
      data['advertising'] = advertising!.map((v) => v).toList();
    }
    data['linkiframe'] = linkiframe;
    return data;
  }
}

class Source {
  String? file;
  String? label;
  String? type;

  Source({this.file, this.label, this.type});

  Source.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    label = json['label'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['file'] = file;
    data['label'] = label;
    data['type'] = type;
    return data;
  }
}

class Track {
  List<Tracks>? tracks;

  Track({this.tracks});

  Track.fromJson(Map<String, dynamic> json) {
    if (json['tracks'] != null) {
      tracks = <Tracks>[];
      json['tracks'].forEach((v) {
        tracks!.add( Tracks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (tracks != null) {
      data['tracks'] = tracks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tracks {
  String? file;
  String? kind;

  Tracks({this.file, this.kind});

  Tracks.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    kind = json['kind'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['file'] = file;
    data['kind'] = kind;
    return data;
  }
}
