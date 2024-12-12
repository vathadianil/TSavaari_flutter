class FareCalculationModel {
  String? mCRID;
  String? mRMID;
  String? fromStationName;
  String? toStationName;
  String? distance;
  String? time;
  String? fare;

  FareCalculationModel(
      {this.mCRID,
      this.mRMID,
      this.fromStationName,
      this.toStationName,
      this.distance,
      this.time,
      this.fare});

  FareCalculationModel.fromJson(Map<String, dynamic> json) {
    mCRID = json['MCRID'].toString();
    mRMID = json['MRMID'].toString();
    fromStationName = json['from_station_name'];
    toStationName = json['to_station_name'];
    distance = json['distance'].toString();
    time = json['time'].toString();
    fare = json['fare'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MCRID'] = mCRID;
    data['MRMID'] = mRMID;
    data['from_station_name'] = fromStationName;
    data['to_station_name'] = toStationName;
    data['distance'] = distance;
    data['time'] = time;
    data['fare'] = fare;
    return data;
  }
}
