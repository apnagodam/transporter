import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transporter/Data/Model/LoginResponseModel.dart';
part 'AuthenticationService.g.dart';

@riverpod
Future<LoginResponseModel> verifyOtp(VerifyOtpRef ref,{
  required String? number,required String? otp
}) async {
  return loginResponseModelFromMap(jsonEncode(''));
}
