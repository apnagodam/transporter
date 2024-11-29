import 'dart:convert';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:transporter/Data/Model/BaseApiResponse.dart';
import 'package:transporter/Domain/Authentication/AuthenticationService.dart';

import '../../Domain/Dio/DioProvider.dart';
import '../Routes/routes_strings.dart';
import '../Utils/Widgets/Widgets.dart';

class Loginscreen extends ConsumerStatefulWidget {
  const Loginscreen({super.key});

  @override
  ConsumerState<Loginscreen> createState() => _LoginscreenState();
}

final loginForm = GlobalKey<FormState>();
TextEditingController mobileNumberController = TextEditingController();
var isLoading = StateProvider((ref) => false);

class _LoginscreenState extends ConsumerState<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: SafeArea(
          child: defaultPadding(Form(
              key: loginForm,
              child: SizedBox(height:MediaQuery.of(context).size.height,child: Align(alignment: Alignment.center,child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png',fit: BoxFit.contain,),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Transporter Login',
                      style: largeTitleTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length != 10) {
                        return 'Please input valid number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: mobileNumberController,
                    maxLength: 10,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                        hintText: "Enter mobile number",
                        label: const Text("Enter mobile number"),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  //showLoader(context)
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (loginForm.currentState!.validate()) {
                          // context.goNamed(RoutesStrings.verifyOtp);
                          // context.goNamed(RoutesStrings.verifyOtp,
                          //     extra: {
                          //       'mobile': mobileNumberController.text
                          //           .toString()
                          //     });

                          ref.watch(isLoading.notifier).state = true;
                          ref.watch(sendOtpProvider(number: mobileNumberController.text
                              .toString() ).future).then((value){
                            ref.watch(isLoading.notifier).state = false;

                            if (value['status'].toString() == "1") {
                              context.goNamed(RoutesStrings.verifyOtp,
                                  extra: {
                                    'mobile': mobileNumberController.text
                                        .toString(),
                                    "app_type":"Transporter",
                                    "otp_type":"",
                                    "token":"hyu",
                                  });


                            }
                          });

                        } else {}
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            shadows: [
                              const Shadow(
                                  color: Colors.white, blurRadius: 0.3)
                            ],
                            fontWeight: FontWeight.w700,
                            fontSize: Adaptive.sp(16)),
                      ),
                      style: defaultButtonStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text.rich(
                      TextSpan(
                          text: 'Do not have an Account?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: " Register",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    context.goNamed(RoutesStrings.register),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                  )
                ],
              ),),)))),
    );
  }

  Future<BaseApiResponse> sendOtp(WidgetRef ref, {String? number}) async {
    var response = await ref
        .watch(dioProvider)
        .post(ApiClient.login, queryParameters: {'number': number});
    return baseApiResponseFromMap(jsonEncode(response.data));
  }
}
