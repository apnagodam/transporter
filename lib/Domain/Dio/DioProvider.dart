import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transporter/Domain/Dio/DioInterceptor.dart';

import '../../Presentation/Preferences/SharedPrefs/SharedUtility.dart';

part 'DioProvider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  return Dio(BaseOptions(
      baseUrl: ApiClient.testBaseUrl,
      headers: {
        "Authorization": "${ref.watch(sharedUtilityProvider).getToken()}",
      },
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1)))
    ..interceptors.add(DioInterceptor(ref));
}

@riverpod
Dio dioStates(DioStatesRef ref) {
  return Dio(BaseOptions(
      baseUrl: ApiClient.statesUrl,
      headers: {
        "Authorization": "${ref.watch(sharedUtilityProvider).getToken()}",
      },
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1)));
}

class ApiClient {
  static const baseUrl = "https://apnagodam.com/transport_api/";
  static const testBaseUrl = "https://test.apnagodam.com/transport_api/";

/*
  sates url from api controller.php
*/
  static const statesUrl = 'https://test.apnagodam.com/api/';

/*
state and district api
*
*
*
*/

  static const getStates = "get_state_name_new";
  static const getDistricts = 'district-list-new';

/*
bank api
*
*
*
*/
  static const getBanklist = "banks-list";

  /*
Authentication api
*
*
*
*/
  static const registerUser = 'transporter_store';
  static const verifyOtp = 'transporter_verify_otp';
  static const login = 'v1_transporter_send_otp';
  static const loginInfo = 'login-info';

  /*
Trips api
*
*
*
*/
  static const getTrips = 'transporter_trip_request';
  static const updateTruckDriver = 'driver_truck_update';
  static const startTrip = 'trip_start_update';
  static const biltyPdfData = 'bilty_data';
  static const tripEnd = 'transporter_trip_end';
  static const getTripsHistory = 'trip_history';

/*
Truck Driver api
*
*
*
*/
  static const getTruckDriver = 'truck_driver_list';
}

class ImageClient {
  static const assetsImageUrl =
      "https://apnagodam.com/resources/assets/upload/transporter/";

  static const secondKantaImage =
      'https://apnagodam.com/resources/assets/upload/second_kanta_parchi/';
}
