import 'dart:convert';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Data/Model/LoginResponseModel.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedUtilityProvider = Provider<SharedUtility>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(sharedPreferences: sharedPrefs);
});

class SharedUtility {
  SharedUtility({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  Locale getLocale()=>Locale(sharedPreferences.getString('language_code')??"hi","IN");
  setLocale(String languageCode)=>sharedPreferences.setString('language_code',languageCode);

      String getToken() {
    return sharedPreferences.getString('token') ?? "";
  }

  void setToken(String token) {
    sharedPreferences.setString('token', token);
  }

  UserDetails? getUser() {
    return sharedPreferences.get('user') != null
        ? UserDetails.fromMap(
        jsonDecode(sharedPreferences.getString('user') ?? ""))
        : null;
  }

  void setUser(UserDetails? userMap) {
    sharedPreferences.setString('user', jsonEncode(userMap!.toMap()));
  }
}
