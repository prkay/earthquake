class EarthQuakeData {
  List<Features> features;

  EarthQuakeData({ this.features});

  EarthQuakeData.fromJson(Map<String, dynamic> json) {
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

  Features({this.type, this.properties, this.id});

  Features.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
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

  Properties(
      {this.place,
        this.time,
        this.updated,
        this.alert,
        this.status,
        this.magType,
        this.type,
        this.title});

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
