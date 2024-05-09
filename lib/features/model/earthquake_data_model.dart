class EarthQuakeData {
  List<Features> features;

  EarthQuakeData({
    required this.features,
  });

  factory EarthQuakeData.fromJson(Map<String, dynamic> json) {
    if (json['features'] != null) {
      features = new List<Features>();
      json['features'].forEach((v) {
        features.add(new Features.fromJson(v));
      });
    }
  }
}

class Features {
  String type;
  Properties properties;
  String id;

  Features({
    required this.type,
    required this.properties,
    required this.id,
  });

  Features.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    properties = (json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null)!;
    id = json['id'];
  }
}

class Properties {
  String place;
  int time;
  int updated;
  String alert;
  String status;
  String magType;
  String type;
  String title;

  Properties({
    required this.place,
    required this.time,
    required this.updated,
    required this.alert,
    required this.status,
    required this.magType,
    required this.type,
    required this.title,
  });

  Properties.fromJson(Map<String, dynamic> json) {
    place = json['place'];
    time = json['time'];
    updated = json['updated'];
    alert = json['alert'];
    status = json['status'];
    magType = json['magType'];
    type = json['type'];
    title = json['title'];
  }
}
