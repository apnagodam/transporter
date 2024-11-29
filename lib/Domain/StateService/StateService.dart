import 'dart:convert';


import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Data/Model/DistrictsResponseModel.dart';
import '../../Data/Model/StatesResponseModel.dart';
import '../Dio/DioProvider.dart';

part 'StateService.g.dart';

@riverpod
Future<StatesResponseModel> stateList(StateListRef ref) async {
  var response = await ref.watch(dioStatesProvider).post(ApiClient.getStates);
  return statesResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<DistrictsResponseModel> districtList(DistrictListRef ref,{String? code}) async {
  var response = await ref.watch(dioStatesProvider).post(ApiClient.getDistricts,queryParameters: {"code":code});
  return districtsResponseModelFromMap(jsonEncode(response.data));
}
