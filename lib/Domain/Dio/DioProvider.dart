import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Presentation/Utils/Preferences/SharedPrefs/SharedUtility.dart';

part 'DioProvider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  return Dio(BaseOptions(baseUrl: ApiClient.baseUrl, headers: {
    "Authorization": "Bearer ${ref.watch(sharedUtilityProvider).getToken()}",
  }))
    ..interceptors.add(LogInterceptor(
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
      responseBody: true,
    ));
}

class ApiClient {
  static const baseUrl = "https://apnagodamfinance.com/finance/api/";

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
Loan api
*
*
*
*/
  static const getSchemes = 'scheme-list';
  static const applyForLoan = 'sanction_limit_store';
  static const appliedList = 'sanction_limit';
}
