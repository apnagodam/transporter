// To parse this JSON data, do
//
//     final transporterTripHistoryModel = transporterTripHistoryModelFromMap(jsonString);

import 'dart:convert';

TransporterTripHistoryModel transporterTripHistoryModelFromMap(String str) => TransporterTripHistoryModel.fromMap(json.decode(str));

String transporterTripHistoryModelToMap(TransporterTripHistoryModel data) => json.encode(data.toMap());

class TransporterTripHistoryModel {
  dynamic status;
  dynamic message;
  List<Datum>? data;

  TransporterTripHistoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory TransporterTripHistoryModel.fromMap(Map<String, dynamic> json) => TransporterTripHistoryModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  dynamic id;
  dynamic requestDate;
  dynamic tripDate;
  dynamic tripId;
  dynamic transporterName;
  dynamic transporterPhone;
  dynamic userName;
  dynamic userPhone;
  dynamic fromAddress;
  dynamic toAddress;
  dynamic rate;
  dynamic commodity;
  dynamic weight;
  dynamic noOfBags;
  dynamic recevingWeight;
  dynamic recevingBags;
  dynamic biltyImage;
  dynamic kantaImage;
  dynamic goodsInvoiceImage;
  dynamic recevingKantaImage;
  dynamic frightInvoiceImage;
  dynamic inOutTypes;
  dynamic status;
  dynamic tripStart;
  dynamic tripEnd;
  dynamic driverName;
  dynamic driverPhone;
  dynamic truckNumber;
  dynamic poId;

  Datum({
    this.id,
    this.requestDate,
    this.tripDate,
    this.tripId,
    this.transporterName,
    this.transporterPhone,
    this.userName,
    this.userPhone,
    this.fromAddress,
    this.toAddress,
    this.rate,
    this.commodity,
    this.weight,
    this.noOfBags,
    this.recevingWeight,
    this.recevingBags,
    this.biltyImage,
    this.kantaImage,
    this.goodsInvoiceImage,
    this.recevingKantaImage,
    this.frightInvoiceImage,
    this.inOutTypes,
    this.status,
    this.tripStart,
    this.tripEnd,
    this.driverName,
    this.driverPhone,
    this.truckNumber,
    this.poId,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    requestDate: json["request_date"],
    tripDate: json["trip_date"],
    tripId: json["trip_id"],
    transporterName: json["transporter_name"],
    transporterPhone: json["transporter_phone"],
    userName: json["user_name"],
    userPhone: json["user_phone"],
    fromAddress: json["from_address"],
    toAddress: json["to_address"],
    rate: json["rate"],
    commodity: json["commodity"],
    weight: json["weight"],
    noOfBags: json["no_of_bags"],
    recevingWeight: json["receving_weight"],
    recevingBags: json["receving_bags"],
    biltyImage: json["bilty_image"],
    kantaImage: json["kanta_image"],
    goodsInvoiceImage: json["goods_invoice_image"],
    recevingKantaImage: json["receving_kanta_image"],
    frightInvoiceImage: json["fright_invoice_image"],
    inOutTypes: json["in_out_types"],
    status: json["status"],
    tripStart: json["trip_start"],
    tripEnd: json["trip_end"],
    driverName: json["driver_name"],
    driverPhone: json["driver_phone"],
    truckNumber: json["truck_number"],
    poId: json["po_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "request_date": requestDate,
    "trip_date": tripDate,
    "trip_id": tripId,
    "transporter_name": transporterName,
    "transporter_phone": transporterPhone,
    "user_name": userName,
    "user_phone": userPhone,
    "from_address": fromAddress,
    "to_address": toAddress,
    "rate": rate,
    "commodity": commodity,
    "weight": weight,
    "no_of_bags": noOfBags,
    "receving_weight": recevingWeight,
    "receving_bags": recevingBags,
    "bilty_image": biltyImage,
    "kanta_image": kantaImage,
    "goods_invoice_image": goodsInvoiceImage,
    "receving_kanta_image": recevingKantaImage,
    "fright_invoice_image": frightInvoiceImage,
    "in_out_types": inOutTypes,
    "status": status,
    "trip_start": tripStart,
    "trip_end": tripEnd,
    "driver_name": driverName,
    "driver_phone": driverPhone,
    "truck_number": truckNumber,
    "po_id": poId,
  };
}
