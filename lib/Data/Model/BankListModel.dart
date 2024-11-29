// To parse this JSON data, do
//
//     final bankListModel = bankListModelFromMap(jsonString);

import 'dart:convert';

BankListModel bankListModelFromMap(String str) => BankListModel.fromMap(json.decode(str));

String bankListModelToMap(BankListModel data) => json.encode(data.toMap());

class BankListModel {
  List<BankDatum>? data;
  String? status;
  String? message;

  BankListModel({
    this.data,
    this.status,
    this.message,
  });

  factory BankListModel.fromMap(Map<String, dynamic> json) => BankListModel(
    data: json["data"] == null ? [] : List<BankDatum>.from(json["data"]!.map((x) => BankDatum.fromMap(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "status": status,
    "message": message,
  };
}

class BankDatum {
  int? id;
  String? bankName;
  int? status;

  BankDatum({
    this.id,
    this.bankName,
    this.status,
  });

  factory BankDatum.fromMap(Map<String, dynamic> json) => BankDatum(
    id: json["id"],
    bankName: json["bank_name"],
    status: json["status"],
  );
  bool filterByName(String filter) {
    return this.bankName.toString().toLowerCase().trim().contains(filter);
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "bank_name": bankName,
    "status": status,
  };
}
