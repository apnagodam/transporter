import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:transporter/Domain/Dio/DioProvider.dart';
import 'package:transporter/Presentation/Preferences/SharedPrefs/SharedUtility.dart';
import 'package:transporter/Presentation/Utils/Widgets/Widgets.dart';

import '../../Domain/Authentication/AuthenticationService.dart';
import '../Routes/routes_strings.dart';
import '../Utils/color_constants.dart';

class Verifyotp extends ConsumerStatefulWidget {
  const Verifyotp({super.key, required this.mobileNumber});

  final String mobileNumber;

  @override
  ConsumerState<Verifyotp> createState() => _VerifyotpState();
}

class _VerifyotpState extends ConsumerState<Verifyotp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: ListView(
          children: [
            SizedBox(
              height: Adaptive.h(25),
            ),
            Center(
                child: Icon(
              Icons.app_registration,
              color: ColorConstants.primaryColorDriver,
            )),
            Center(
              child: Text(
                "verification".tr(),
                style: TextStyle(
                    color: ColorConstants.primaryColorDriver,
                    fontWeight: FontWeight.bold,
                    fontSize: Adaptive.sp(22)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "enterTheCodeSend".tr(),
                style: TextStyle(
                    color: ColorConstants.primaryColorDriver,
                    fontWeight: FontWeight.w500,
                    fontSize: Adaptive.sp(18)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "${widget.mobileNumber}",
                style: TextStyle(
                    color: ColorConstants.primaryColorDriver,
                    fontWeight: FontWeight.bold,
                    fontSize: Adaptive.sp(16)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Pinput(
                  autofocus: true,
                  length: 6,
                  defaultPinTheme: PinTheme(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorConstants.primaryColorDriver
                              .withOpacity(0.1),
                          border: Border.all(
                              color: ColorConstants.primaryColorDriver
                                  .withOpacity(0.1)))),
                  focusedPinTheme: PinTheme(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorConstants.primaryColorDriver
                              .withOpacity(0.1),
                          border: Border.all(
                              color: ColorConstants.primaryColorDriver))),
                  onCompleted: (pin) {
                    if (pin.length == 6) {
                      // Debouncer(delay: const Duration(milliseconds: 500))
                      //     .call(() {
                      showLoader(context);
                      ref
                          .watch(verifyOtpProvider(
                                  number: widget.mobileNumber, otp: pin)
                              .future)
                          .then((value) {
                        if (value.status.toString() == "1") {
                          ref
                              .watch(sharedUtilityProvider)
                              .setToken(value.authorization ?? "");
                          ref
                              .watch(sharedUtilityProvider)
                              .setUser(value.userDetails);

                          ref.invalidate(dioProvider);

                          context.go(RoutesStrings.dashboard);
                        }
                      }).onError((e, s) {
                        errorToast(context, e.toString());
                      });
                      // });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         context.go(RoutesStrings.dashboard);
            //       },
            //       style: ElevatedButton.styleFrom(
            //           backgroundColor: ColorsConstant.secondColorDark,
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(8))),
            //       child: Text(
            //         "Verify Otp",
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold, fontSize: Adaptive.sp(16)),
            //       ),
            //     ),
            //   ),
            // ),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "otpNotReceived".tr(),
                  style: TextStyle(
                      color: ColorConstants.primaryColorDriver,
                      fontWeight: FontWeight.bold,
                      fontSize: Adaptive.sp(16)),
                ),
                TextButton(
                  onPressed: () {
                    // ref
                    //     .watch(loginProvider(panNumber: widget.panCard).future)
                    //     .then((value) {})
                    //     .onError((e, s) {});
                  },
                  child: Text(
                    "resendOtp".tr(),
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: ColorConstants.primaryColorDriver,
                        color: ColorConstants.primaryColorDriver,
                        fontWeight: FontWeight.bold,
                        fontSize: Adaptive.sp(16)),
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    ));
  }
}
