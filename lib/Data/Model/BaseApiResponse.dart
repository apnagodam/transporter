// To parse this JSON data, do
//
//     final baseApiResponse = baseApiResponseFromMap(jsonString);

import 'dart:convert';

BaseApiResponse baseApiResponseFromMap(String str) =>
    BaseApiResponse.fromMap(json.decode(str));

String baseApiResponseToMap(BaseApiResponse data) => json.encode(data.toMap());

class BaseApiResponse {
  String? status;
  String? message;

  BaseApiResponse({
    this.status,
    this.message,
  });

  factory BaseApiResponse.fromMap(Map<String, dynamic> json) => BaseApiResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
      };
}
