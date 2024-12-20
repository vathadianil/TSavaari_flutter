class CardTrxDetailsModel {
  String? errorCode;
  String? errorDescription;
  List<CardTrxListModel>? response;

  CardTrxDetailsModel({this.response});

  CardTrxDetailsModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'] ?? '';
    errorDescription = json['ErrorDescription'] ?? '';
    if (json['response'] != null) {
      response = <CardTrxListModel>[];
      json['response'].forEach((v) {
        response!.add(CardTrxListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ErrorCode'] = errorCode;
    data['ErrorDescription'] = errorDescription;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardTrxListModel {
  String? ticketEngravedID;
  String? merchantTransactionID;
  String? addedValue;
  String? transactionStatus;
  String? bankCode;
  String? transactionDateTime;
  String? tckPhyExprDt;

  CardTrxListModel(
      {this.ticketEngravedID,
      this.merchantTransactionID,
      this.addedValue,
      this.transactionStatus,
      this.bankCode,
      this.transactionDateTime,
      this.tckPhyExprDt});

  CardTrxListModel.fromJson(Map<String, dynamic> json) {
    ticketEngravedID = json['TicketEngravedID'];
    merchantTransactionID = json['MerchantTransactionID'];
    addedValue = json['AddedValue'];
    transactionStatus = json['TransactionStatus'];
    bankCode = json['BankCode'];
    transactionDateTime = json['TransactionDateTime'];
    tckPhyExprDt = json['TckPhyExprDt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TicketEngravedID'] = ticketEngravedID;
    data['MerchantTransactionID'] = merchantTransactionID;
    data['AddedValue'] = addedValue;
    data['TransactionStatus'] = transactionStatus;
    data['BankCode'] = bankCode;
    data['TransactionDateTime'] = transactionDateTime;
    data['TckPhyExprDt'] = tckPhyExprDt;
    return data;
  }
}
