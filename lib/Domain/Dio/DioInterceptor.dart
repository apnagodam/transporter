import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:one_context/one_context.dart';
import 'package:transporter/Presentation/Utils/Widgets/Widgets.dart';

import '../../Presentation/Preferences/SharedPrefs/SharedUtility.dart';
import '../../Presentation/Routes/routes.dart';
import 'DioProvider.dart';

class DioInterceptor extends InterceptorsWrapper {
  DioInterceptor(this.ref);

  final DioRef ref;

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) {
    OneContext().popAllDialogs();
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorToast(
            OneContext().context!, "Please Check your internet connection!");
        debugPrint(" \x1B[31m${error.message}\x1B[0m");
      case DioExceptionType.sendTimeout:
        errorToast(
            OneContext().context!, "Please Check your internet connection!");
        debugPrint(" \x1B[31m${error.message}\x1B[0m");

      case DioExceptionType.receiveTimeout:
        errorToast(
            OneContext().context!, "Please Check your internet connection!");
        debugPrint(" \x1B[31m${error.message}\x1B[0m");

      case DioExceptionType.badCertificate:
        errorToast(OneContext().context!, "${error.message}");
        debugPrint(" \x1B[31m${error.message}\x1B[0m");

      case DioExceptionType.badResponse:
        errorToast(OneContext().context!, "${error.message}");
        debugPrint(" \x1B[31m${error.message}\x1B[0m");

      case DioExceptionType.cancel:
        errorToast(OneContext().context!, "${error.message}");
        debugPrint(" \x1B[31m${error.message}\x1B[0m");

      case DioExceptionType.connectionError:
        errorToast(OneContext().context!, "${error.message}");
        debugPrint(" \x1B[31m${error.message}\x1B[0m");

      case DioExceptionType.unknown:
        errorToast(OneContext().context!, "${error.message}");
        debugPrint(" \x1B[31m${error.message}\x1B[0m");
      default:
        errorToast(OneContext().context!, "${error.message}");
        debugPrint(" \x1B[31m${error.message}\x1B[0m");
    }

    super.onError(error, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(" \x1B[32m${options.baseUrl}${options.path}\x1B[0m");
    debugPrint(" \x1B[32m${options.headers}\x1B[0m");
    debugPrint(" \x1B[32m${options.queryParameters}\x1B[0m");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 500) {
      errorToast(
          OneContext().context!, "Please Check your internet connection!");
    }

    if (response.data['status'].toString() == "3") {
      ref.watch(sharedPreferencesProvider).clear();
      ref.watch(goRouterProvider).go("/login");
      debugPrint(" \x1B[31m${response.data}\x1B[0m");
    } else if (response.data['status'].toString() == "0") {
      errorToast(OneContext().context!, "${response.data['message']}");
      debugPrint(" \x1B[31m${response.data}\x1B[0m");
    } else if (response.data['status'].toString() == "1") {
      errorToast(OneContext().context!, "${response.data['message']}");
      debugPrint(" \x1B[32m${response.data}\x1B[0m");
    }

    super.onResponse(response, handler);
  }
}
