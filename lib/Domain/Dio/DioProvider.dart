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
  static const baseUrl = "https://apnagodam.com/";
  static const testBaseUrl = "https://test.apnagodam.com/";

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
  static const getBanklist = "transport_api/banks-list";

  /*
Authentication api
*
*
*
*/
  static const registerUser = 'transport_api/transporter_store';
  static const verifyOtp = 'transport_api/transporter_verify_otp';
  static const login = 'transport_api/v1_transporter_send_otp';
  static const loginInfo = 'transport_api/login-info';

  /*
Trips api
*
*
*
*/
  static const getTrips = 'transport_api/transporter_trip_request';
  static const updateTruckDriver = 'transport_api/driver_truck_update';
  static const startTrip = 'transport_api/trip_start_update';
  static const biltyPdfData = 'transport_api/bilty_data';
  static const tripEnd = 'transport_api/transporter_trip_end';
  static const getTripsHistory = 'transport_api/trip_history';

/*
Truck Driver api
*
*
*
*/
  static const getTruckDriver = 'transport_api/truck_driver_list';
}

class ImageClient {
  static const assetsImageUrl = "resources/assets/upload/transporter/";

  static const secondKantaImage =
      'resources/assets/upload/second_kanta_parchi/';
}
