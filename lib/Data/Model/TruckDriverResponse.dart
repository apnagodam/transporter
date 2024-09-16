// To parse this JSON data, do
//
//     final truckDriverResponse = truckDriverResponseFromMap(jsonString);

import 'dart:convert';

TruckDriverResponse truckDriverResponseFromMap(String str) => TruckDriverResponse.fromMap(json.decode(str));

String truckDriverResponseToMap(TruckDriverResponse data) => json.encode(data.toMap());

class TruckDriverResponse {
  String? status;
  String? message;
  List<TruckDatum>? truckData;
  List<DriverDatum>? driverData;

  TruckDriverResponse({
    this.status,
    this.message,
    this.truckData,
    this.driverData,
  });

  factory TruckDriverResponse.fromMap(Map<String, dynamic> json) => TruckDriverResponse(
    status: json["status"],
    message: json["message"],
    truckData: json["truck_data"] == null ? [] : List<TruckDatum>.from(json["truck_data"]!.map((x) => TruckDatum.fromMap(x))),
    driverData: json["driver_data"] == null ? [] : List<DriverDatum>.from(json["driver_data"]!.map((x) => DriverDatum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "truck_data": truckData == null ? [] : List<dynamic>.from(truckData!.map((x) => x.toMap())),
    "driver_data": driverData == null ? [] : List<dynamic>.from(driverData!.map((x) => x.toMap())),
  };
}

class DriverDatum {
  dynamic? id;
  String? driverName;

  DriverDatum({
    this.id,
    this.driverName,
  });

  factory DriverDatum.fromMap(Map<String, dynamic> json) => DriverDatum(
    id: json["id"],
    driverName: json["driver_name"],
  );
bool districtFilterByName(String filter) {
    return this.driverName.toString().toLowerCase().trim().contains(filter);
  }
  Map<String, dynamic> toMap() => {
    "id": id,
    "driver_name": driverName,
  };
}

class TruckDatum {
  dynamic? id;
  String? truckNumber;

  TruckDatum({
    this.id,
    this.truckNumber,
  });

  factory TruckDatum.fromMap(Map<String, dynamic> json) => TruckDatum(
    id: json["id"],
    truckNumber: json["truck_number"],
  );
bool districtFilterByName(String filter) {
    return this.truckNumber.toString().toLowerCase().trim().contains(filter);
  }
  Map<String, dynamic> toMap() => {
    "id": id,
    "truck_number": truckNumber,
  };
}
