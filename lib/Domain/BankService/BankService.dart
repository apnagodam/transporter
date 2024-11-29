import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transporter/Data/Model/BankListModel.dart';
import 'package:transporter/Domain/Dio/DioProvider.dart';

part 'BankService.g.dart';

@riverpod
Future<BankListModel> bankList(BankListRef ref) async {
  var response = await ref.watch(dioStatesProvider).get(ApiClient.getBanklist);
  return bankListModelFromMap(jsonEncode(response.data));
}
