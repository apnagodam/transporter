import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Presentation/Preferences/SharedPrefs/SharedUtility.dart';

part 'DioProvider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  return Dio(BaseOptions(baseUrl: ApiClient.testBaseUrl, headers: {
    "Authorization": "${ref.watch(sharedUtilityProvider).getToken()}",
  },connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1)))
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
}

class ApiClient {
  static const baseUrl = "https://apnagodam.com/transport_api/";
    static const testBaseUrl = "https://apnagodam.com/test/transport_api/";


/*
state and district api
*
*
*
*/

  static const getStates = "states";
  static const getDistricts = 'district-list';
  /*
Authentication api
*
*
*
*/
  static const registerUser = 'register';
  static const verifyOtp = 'transporter_verify_otp';
  static const login = 'transporter_send_otp';
  static const loginInfo = 'login-info';

  /*
Trips api
*
*
*
*/
  static const getTrips = 'transporter_trip_request';
  static const updateTruckDriver='driver_truck_update';
  static const startTrip = 'trip_start_update';
  static const biltyPdfData = 'bilty_data';
  static const tripEnd ='transporter_trip_end';

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
      "https://apnagodam.com/test/resources/assets/upload/transporter/";


  static const secondKantaImage ='https://apnagodam.com/test/resources/assets/upload/second_kanta_parchi/';
}
