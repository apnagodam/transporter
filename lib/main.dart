import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:one_context/one_context.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

import 'Presentation/Preferences/SharedPrefs/SharedUtility.dart';
import 'Presentation/Routes/routes.dart';
import 'Presentation/Utils/color_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  await EasyLocalization.ensureInitialized();

  if (Platform.isAndroid) {
    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
            }
          });
        } else if (updateInfo.flexibleUpdateAllowed) {
          //Perform flexible update
          InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
              InAppUpdate.completeFlexibleUpdate();
            }
          });
        }
      }
    });
  }

  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return ToastificationWrapper(
            child: EasyLocalization(
                fallbackLocale: Locale('hi', 'IN'),
                startLocale: Locale('hi', 'IN'),
                supportedLocales: [Locale('hi', 'IN'), Locale('en', 'US')],
                path: 'assets/translations',
                child: MaterialApp(
                  builder: OneContext().builder,
                  navigatorKey: OneContext().key,
                  home: const MyApp(),
                )));
      },
    ),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(goRouterProvider),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'transporter'.tr(),
      theme: ThemeData(
          fontFamily: GoogleFonts.quicksand().fontFamily,
          colorScheme: ColorScheme.fromSeed(
              seedColor: ColorConstants.primaryColorDriver),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              color: Colors.white,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Adaptive.sp(16),
                  color: ColorConstants.primaryColorDriver))),
    );
  }
}
