import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transporter/Data/Model/BiltyResponseModel.dart';
import 'package:transporter/Data/Model/TransporterTripHistoryModel.dart';
import 'package:transporter/Data/Model/TripDataResponse.dart';
import 'package:transporter/Data/Model/TruckDriverResponse.dart';
import 'package:transporter/Domain/Dio/DioProvider.dart';
import 'package:transporter/Presentation/Preferences/SharedPrefs/SharedUtility.dart';
import 'package:transporter/Presentation/Routes/routes.dart';
import 'package:transporter/Presentation/Routes/routes_strings.dart';

part 'TripsService.g.dart';

@riverpod
Future<TripDataResponse> tripsList(TripsListRef ref) async {
  var response = await ref.watch(dioProvider).get(ApiClient.getTrips);

  var body = tripDataResponseFromMap(jsonEncode(response.data));
  if (body.message!.toLowerCase().contains("user not found")) {
    ref.watch(sharedPreferencesProvider).clear();
    ref.watch(goRouterProvider).go(RoutesStrings.login);
  }
  return body;
}

@riverpod
Future<TruckDriverResponse> truckDriver(TruckDriverRef ref) async {
  var response = await ref.watch(dioProvider).get(ApiClient.getTruckDriver);
  var body = truckDriverResponseFromMap(jsonEncode(response.data));
  if (body.message!.toLowerCase().contains("user not found")) {
    ref.watch(sharedPreferencesProvider).clear();
    ref.watch(goRouterProvider).go(RoutesStrings.login);
  }
  return body;
}

@riverpod
Future<BiltyResponseData> tripData(TripDataRef ref,
    {required String? tripRequestid}) async {
  var response = await ref.watch(dioProvider).get(ApiClient.biltyPdfData,
      queryParameters: {'trip_request_id': tripRequestid});
  var body = biltyResponseDataFromMap(jsonEncode(response.data));
  if (body.message!.toLowerCase().contains("user not found")) {
    ref.watch(sharedPreferencesProvider).clear();
    ref.watch(goRouterProvider).go(RoutesStrings.login);
  }
  return body;
}

@riverpod
Stream<TransporterTripHistoryModel> tripsHistory(TripsHistoryRef ref) async* {
  var response = await ref.watch(dioProvider).post(ApiClient.getTripsHistory);
  yield transporterTripHistoryModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> updateTruckDriver(UpdateTruckDriverRef ref,
    {String? truckId, String? driverId, String? tripRequestId}) async {
  var response = await ref.watch(dioProvider).post(ApiClient.updateTruckDriver,
      queryParameters: {
        "truck_id": truckId,
        "driver_id": driverId,
        "trip_request_id": tripRequestId
      });
  if (response.data['message']
      .toString()
      .toLowerCase()
      .contains("user not found")) {
    ref.watch(sharedPreferencesProvider).clear();
    ref.watch(goRouterProvider).go(RoutesStrings.login);
  }
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> startTrip(StartTripRef ref,
    {String? tripRequestId}) async {
  var response = await ref.watch(dioProvider).post(ApiClient.startTrip,
      queryParameters: {"trip_request_id": tripRequestId});

  if (response.data['message']
      .toString()
      .toLowerCase()
      .contains("user not found")) {
    ref.watch(sharedPreferencesProvider).clear();
    ref.watch(goRouterProvider).go(RoutesStrings.login);
  }
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> endTrip(EndTripRef ref,
    {String? tripRequestId,
    String? kantaWeight,
    String? bags,
    String? kantaImage,
    String? qualityImage,
    String? paotiImage,
    String? paotiNumber,
    int? tripStatus}) async {
  var response = await ref.watch(dioProvider).post(ApiClient.tripEnd, data: {
    'trip_request_id': tripRequestId,
    'kanta_weight': kantaWeight,
    'bags': bags,
    'kanta_img': kantaImage,
    'quality_img': qualityImage,
    "paoti_image": paotiImage,
    "paoti_number": paotiNumber,
    "trip_status": tripStatus
  });
  if (response.data['message']
      .toString()
      .toLowerCase()
      .contains("user not found")) {
    ref.watch(sharedPreferencesProvider).clear();
    ref.watch(goRouterProvider).go(RoutesStrings.login);
  }
  return response.data;
}
