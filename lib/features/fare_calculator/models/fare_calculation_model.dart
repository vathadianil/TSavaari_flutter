class FareCalculationModel {
  String? s;
  String? e;
  String? em;
  List<R>? r;

  FareCalculationModel({this.s, this.e, this.em, this.r});

  FareCalculationModel.fromJson(Map<String, dynamic> json) {
    s = json['s'];
    e = json['e'];
    em = json['em'];
    if (json['r'] != null) {
      r = <R>[];
      json['r'].forEach((v) {
        r!.add(R.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s'] = s;
    data['e'] = e;
    data['em'] = em;
    if (r != null) {
      data['r'] = r!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class R {
  int? mcrId;
  int? mrmId;
  String? fromStationName;
  String? toStationName;
  double? distance;
  int? time;
  int? fare;

  R(
      {this.mcrId,
      this.mrmId,
      this.fromStationName,
      this.toStationName,
      this.distance,
      this.time,
      this.fare});

  R.fromJson(Map<String, dynamic> json) {
    mcrId = json['mcrId'];
    mrmId = json['mrmId'];
    fromStationName = json['fromStationName'];
    toStationName = json['toStationName'];
    distance = json['distance'];
    time = json['time'];
    fare = json['fare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mcrId'] = mcrId;
    data['mrmId'] = mrmId;
    data['fromStationName'] = fromStationName;
    data['toStationName'] = toStationName;
    data['distance'] = distance;
    data['time'] = time;
    data['fare'] = fare;
    return data;
  }
}
