import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transporter/Data/Model/TripDataResponse.dart';
import 'package:transporter/Domain/Dio/DioProvider.dart';

part 'TripsService.g.dart';

@riverpod
Future<TripDataResponse> tripsList(TripsListRef ref) async {
  var response = await ref.watch(dioProvider).get(ApiClient.getTrips);
  return tripDataResponseFromMap(jsonEncode(response.data));
}
