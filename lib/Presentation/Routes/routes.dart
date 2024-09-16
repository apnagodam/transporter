
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transporter/Presentation/Profile/ProfileScreen.dart';
import 'package:transporter/Presentation/Routes/routes_strings.dart';

import '../Authentication/LoginScreen.dart';
import '../Authentication/RegistrationScreen.dart';
import '../Authentication/VerifyOtp.dart';
import '../Dashboard/Dashboard.dart';
import '../Preferences/SharedPrefs/SharedUtility.dart';


part 'routes.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
      debugLogDiagnostics: kDebugMode,
      redirect: (context, state) {
        if (ref.watch(sharedUtilityProvider).getToken().isEmpty) {
          if (state.fullPath == RoutesStrings.dashboard)
            return RoutesStrings.login;
          return null;
        }
      },
      routes: [
        GoRoute(
          path: RoutesStrings.dashboard,
          name: RoutesStrings.dashboard,
          builder: (context, state) => const Dashboard(),
          routes: [
             GoRoute(
                  path: RoutesStrings.profile,
                  name: RoutesStrings.profile,
                  builder: (context, state) =>const Profilescreen()),
          ]
        ),
        GoRoute(
            path: RoutesStrings.login,
            name: RoutesStrings.login,
            builder: (context, state) => const Loginscreen(),
            routes: [
              GoRoute(
                  path: RoutesStrings.verifyOtp,
                  name: RoutesStrings.verifyOtp,
                  builder: (context, state) {
                    final data = state.extra! as Map<String, dynamic>;
                    return Verifyotp(
                      mobileNumber: data['mobile'],
                    );
                  }),
              GoRoute(
                  path: RoutesStrings.register,
                  name: RoutesStrings.register,
                  builder: (context, state) => const Registrationscreen())
            ]),

      ]);
}
