import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
      body: SafeArea(
          child: defaultPadding(Form(
              key: loginForm,
              child: ColumnSuper(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Login',
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
                  ref.watch(isLoading)
                      ? showLoader(context)
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              if (loginForm.currentState!.validate()) {
                                context.goNamed(RoutesStrings.verifyOtp);
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
                  SizedBox(
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
              )))),
    );
  }
}
