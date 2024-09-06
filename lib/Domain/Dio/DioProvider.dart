import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Presentation/Preferences/SharedPrefs/SharedUtility.dart';

part 'DioProvider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  return Dio(BaseOptions(baseUrl: ApiClient.baseUrl, headers: {
    "Authorization": "${ref.watch(sharedUtilityProvider).getToken()}",
  }))
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
  static const baseUrl = "https://apnagodam.com/test/transport_api/";

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

/*
Truck Driver api
*
*
*
*/
  static const getTruckDriver = 'truck_driver_list';
}

class ImageClient {
  static const employeeImageUrl =
      "https://apnagodam.com/resources/assets/upload/employees/";
  static const frontEndAssetsUrl =
      "https://apnagodam.com/resources/frontend_asse-ts/uploads/";
  static const assetsImageUrl =
      "https://apnagodam.com/resources/assets/upload/";
  static const displegedImageUrl =
      "https://apnagodam.com/resources/assets/upload/displedge/";

  static const conveyanceImageUrl =
      'https://apnagodam.com/test/resources/assets/upload/conveyance/';
}
