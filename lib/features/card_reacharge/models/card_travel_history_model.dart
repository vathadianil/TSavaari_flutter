class CardTravelHistoryModel {
  String? fromStation;
  String? toStation;
  String? travelDateTime;
  String? dDCTAmount;
  String? reminingBalance;

  CardTravelHistoryModel(
      {this.fromStation,
      this.toStation,
      this.travelDateTime,
      this.dDCTAmount,
      this.reminingBalance});

  CardTravelHistoryModel.fromJson(Map<String, dynamic> json) {
    fromStation = json['FromStation'];
    toStation = json['ToStation'];
    travelDateTime = json['TravelDateTime'];
    dDCTAmount = json['DDCTAmount'];
    reminingBalance = json['ReminingBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FromStation'] = fromStation;
    data['ToStation'] = toStation;
    data['TravelDateTime'] = travelDateTime;
    data['DDCTAmount'] = dDCTAmount;
    data['ReminingBalance'] = reminingBalance;
    return data;
  }
}
