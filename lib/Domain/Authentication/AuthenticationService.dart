import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transporter/Data/Model/LoginResponseModel.dart';

import '../Dio/DioProvider.dart';

part 'AuthenticationService.g.dart';

@riverpod
Future<LoginResponseModel> verifyOtp(VerifyOtpRef ref,
    {required String? number, required String? otp}) async {
  var response = await ref.watch(dioProvider).post(ApiClient.verifyOtp,
      queryParameters: {'number': number, 'otp': otp, 'token': ''});
  return loginResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> sendOtp(SendOtpRef ref, {String? number}) async {
  var response = await ref.watch(dioProvider).post(ApiClient.login,
      queryParameters: {'number': number, 'token': 'abcdes'});
  return response.data; //9568777786
}

@riverpod
Future<Map<String, dynamic>> registerUser(RegisterUserRef ref,
    {Map<String, dynamic>? data}) async {
  var response =
      await ref.watch(dioProvider).post(ApiClient.registerUser, data: data);

  return response.data;
}
