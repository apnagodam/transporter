// To parse this JSON data, do
//
//     final tripDataResponse = tripDataResponseFromMap(jsonString);

import 'dart:convert';

TripDataResponse tripDataResponseFromMap(String str) => TripDataResponse.fromMap(json.decode(str));

String tripDataResponseToMap(TripDataResponse data) => json.encode(data.toMap());

class TripDataResponse {
  dynamic status;
  dynamic message;
  List<Datum>? data;

  TripDataResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TripDataResponse.fromMap(Map<String, dynamic> json) => TripDataResponse(
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
  dynamic? tripDate;
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
  dynamic inOutTypes;
  dynamic status;
  dynamic tripStart;
  dynamic tripEnd;
  dynamic driverName;
  dynamic driverPhone;
  dynamic truckNumber;
  dynamic poId;
  dynamic paymentTo;
  dynamic paymentToStatus;
  dynamic kantaImage;
  dynamic recevingKantaImage;
  dynamic qualityReport;
  dynamic recevingQualityImg;
  dynamic paotiImage;
  dynamic invoiceImg;
  dynamic eWayBill;
  dynamic mandiTaxImg;
  dynamic goodsInvoiceImage;
  dynamic frightInvoiceImage;
  dynamic biltyImage;
  dynamic kantaImageUrl;

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
    this.inOutTypes,
    this.status,
    this.tripStart,
    this.tripEnd,
    this.driverName,
    this.driverPhone,
    this.truckNumber,
    this.poId,
    this.paymentTo,
    this.paymentToStatus,
    this.kantaImage,
    this.recevingKantaImage,
    this.qualityReport,
    this.recevingQualityImg,
    this.paotiImage,
    this.invoiceImg,
    this.eWayBill,
    this.mandiTaxImg,
    this.goodsInvoiceImage,
    this.frightInvoiceImage,
    this.biltyImage,
    this.kantaImageUrl,
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
    inOutTypes: json["in_out_types"],
    status: json["status"],
    tripStart: json["trip_start"],
    tripEnd: json["trip_end"],
    driverName: json["driver_name"],
    driverPhone: json["driver_phone"],
    truckNumber: json["truck_number"],
    poId: json["po_id"],
    paymentTo: json["payment_to"],
    paymentToStatus: json["payment_to_status"],
    kantaImage: json["kanta_image"],
    recevingKantaImage: json["receving_kanta_image"],
    qualityReport: json["quality_report"],
    recevingQualityImg: json["receving_quality_img"],
    paotiImage: json["paoti_image"],
    invoiceImg: json["invoice_img"],
    eWayBill: json["e_way_bill"],
    mandiTaxImg: json["mandi_tax_img"],
    goodsInvoiceImage: json["goods_invoice_image"],
    frightInvoiceImage: json["fright_invoice_image"],
    biltyImage: json["bilty_image"],
    kantaImageUrl: json["kanta_image_url"],
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
    "in_out_types": inOutTypes,
    "status": status,
    "trip_start": tripStart,
    "trip_end": tripEnd,
    "driver_name": driverName,
    "driver_phone": driverPhone,
    "truck_number": truckNumber,
    "po_id": poId,
    "payment_to": paymentTo,
    "payment_to_status": paymentToStatus,
    "kanta_image": kantaImage,
    "receving_kanta_image": recevingKantaImage,
    "quality_report": qualityReport,
    "receving_quality_img": recevingQualityImg,
    "paoti_image": paotiImage,
    "invoice_img": invoiceImg,
    "e_way_bill": eWayBill,
    "mandi_tax_img": mandiTaxImg,
    "goods_invoice_image": goodsInvoiceImage,
    "fright_invoice_image": frightInvoiceImage,
    "bilty_image": biltyImage,
    "kanta_image_url": kantaImageUrl,
  };
}
