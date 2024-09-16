import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transporter/Data/Model/BiltyResponseModel.dart';
import 'package:transporter/Data/Model/TripDataResponse.dart';
import 'package:transporter/Data/Model/TruckDriverResponse.dart';
import 'package:transporter/Domain/Dio/DioProvider.dart';

part 'TripsService.g.dart';

@riverpod
Future<TripDataResponse> tripsList(TripsListRef ref) async {
  var response = await ref.watch(dioProvider).get(ApiClient.getTrips);
  return tripDataResponseFromMap(jsonEncode(response.data));
}

@riverpod
Future<TruckDriverResponse> truckDriver(TruckDriverRef ref)async{
  var response = await ref.watch(dioProvider).get(ApiClient.getTruckDriver);
  return truckDriverResponseFromMap(jsonEncode(response.data));
}
@riverpod
Future<BiltyResponseData> tripData(TripDataRef ref,
    {required String? tripRequestid}) async {
  var response = await ref.watch(dioProvider).get(ApiClient.biltyPdfData,
      queryParameters: {'trip_request_id': tripRequestid});

  return biltyResponseDataFromMap(jsonEncode(response.data));
}


@riverpod 
Future<Map<String,dynamic>> updateTruckDriver(UpdateTruckDriverRef ref,{
  String? truckId,
  String? driverId,String? tripRequestId
})async{
  var response = await ref.watch(dioProvider).post(ApiClient.updateTruckDriver,queryParameters: {
    "truck_id":truckId,
	    "driver_id":driverId,
            "trip_request_id":tripRequestId
  });
  return response.data;
}


@riverpod 
Future<Map<String,dynamic>> startTrip(StartTripRef ref,{
  String? tripRequestId
})async{
  var response = await ref.watch(dioProvider).post(ApiClient.startTrip,queryParameters: {
            "trip_request_id":tripRequestId
  });
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> endTrip(EndTripRef ref,
    {String? tripRequestId,
    String? kantaWeight,
    String? bags,
    String? kantaImage,
    String? qualityImage}) async {
  var response =
      await ref.watch(dioProvider).post(ApiClient.tripEnd, data:{
    'trip_request_id': tripRequestId,
    'kanta_weight': kantaWeight,
    'bags': bags,
    'kanta_img': kantaImage,
    'quality_img': qualityImage
  } );
  return response.data;
}
