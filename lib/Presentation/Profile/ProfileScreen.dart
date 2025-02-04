import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:transporter/Domain/Dio/DioProvider.dart';
import 'package:transporter/Presentation/Preferences/SharedPrefs/SharedUtility.dart';
import 'package:transporter/Presentation/Utils/color_constants.dart';
import 'package:transporter/Presentation/Utils/height_wi.dart';
import 'package:transporter/Presentation/Utils/style_constants.dart';

class Profilescreen extends ConsumerStatefulWidget {
  const Profilescreen({super.key});

  @override
  ConsumerState<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends ConsumerState<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.secondaryColor,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                  color: ColorConstants.secondaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: BackButton(
                color: ColorConstants.primaryColorVendor,
              ),
            ),
          ),
          title: Row(
            children: [
              width10,
              Text(
                "Profile".tr(),
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Height70,
                    Image.network(
                      "${ImageClient.assetsImageUrl}/${ref.watch(sharedUtilityProvider).getUser()?.aadharImage}",
                      errorBuilder: (context, error, stackTrace) {
                        return CircleAvatar(
                          radius: 60,
                          backgroundColor: ColorConstants.secondaryColor,
                          child: Center(
                              child: Icon(
                            Icons.person,
                            size: 50,
                          )),
                        );
                      },
                    ),
                    // CircleAvatar(
                    //   foregroundImage: NetworkImage(
                    //       "${ImageClient.assetsImageUrl}/${ref.watch(sharedUtilityProvider).getUser()?.aadharImage}",
                    //       scale: 0.5),
                    //   radius: Adaptive.sh(10),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoButton(
                        onPressed: null,
                        child: Text('-: ' + 'Personal Details'.tr() + ' :-',
                            style: GoogleFonts.aBeeZee(
                                decoration: TextDecoration.underline,
                                color: ColorConstants.secondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(17)))),
                    Text(
                      'Firm Name'.tr() +
                          '${ref.watch(sharedUtilityProvider).getUser()?.firmName ?? ""},',
                      style: StyleConstants.Googleprofile(),
                    ),
                    Text(
                      'Mobile Number'.tr() +
                          "" +
                          '${ref.watch(sharedUtilityProvider).getUser()?.phone ?? ""}',
                      style: StyleConstants.Googleprofile(),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: ColorConstants.primaryColorDriver,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: ColorConstants.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 1,
                              color: ColorConstants.primaryColorVendor)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CupertinoButton(
                            onPressed: null,
                            child: Text('-: Details :-',
                                style: GoogleFonts.aBeeZee(
                                    decoration: TextDecoration.underline,
                                    color: ColorConstants.primaryColorVendor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adaptive.sp(17)))),
                        Height20,
                        Text(
                          'प्रथम नाम और अंतिम नाम*',
                          style: StyleConstants.GoogleprofileTextFeild(),
                        ),
                        Height10,
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText:
                                  '${ref.watch(sharedUtilityProvider).getUser()?.name ?? ""},',
                              hintStyle:
                                  StyleConstants.GoogleprofileTextFeild(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        Height10,
                        Text(
                          'मोबाइल नंबर*',
                          style: StyleConstants.GoogleprofileTextFeild(),
                        ),
                        Height10,
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText:
                                  '${ref.watch(sharedUtilityProvider).getUser()?.phone ?? ""}',
                              hintStyle:
                                  StyleConstants.GoogleprofileTextFeild(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        Height10,
                        Text(
                          'पैन कार्ड नंबर*',
                          style: StyleConstants.GoogleprofileTextFeild(),
                        ),
                        Height10,
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText:
                                  ' ${ref.watch(sharedUtilityProvider).getUser()?.pancardNo ?? ""}',
                              hintStyle:
                                  StyleConstants.GoogleprofileTextFeild(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        Height10,
                        Text(
                          'आधार कार्ड नंबर.*',
                          style: StyleConstants.GoogleprofileTextFeild(),
                        ),
                        Height10,
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText:
                                  ' ${ref.watch(sharedUtilityProvider).getUser()?.aadharNo ?? ""}',
                              hintStyle:
                                  StyleConstants.GoogleprofileTextFeild(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        Height10,
                        Text(
                          'पता*',
                          style: StyleConstants.GoogleprofileTextFeild(),
                        ),
                        Height10,
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText:
                                  '${ref.watch(sharedUtilityProvider).getUser()?.address ?? ""}',
                              hintStyle:
                                  StyleConstants.GoogleprofileTextFeild(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        Height10,
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'राज्य का नाम*',
                              style: StyleConstants.GoogleprofileTextFeild(),
                            )),
                            Expanded(
                                child: Text(
                              '   शहर का नाम*',
                              style: StyleConstants.GoogleprofileTextFeild(),
                            )),
                          ],
                        ),
                        Height10,
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText:
                                        ' ${ref.watch(sharedUtilityProvider).getUser()?.state ?? ""}',
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                            width20,
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText:
                                        '${ref.watch(sharedUtilityProvider).getUser()?.district ?? ""}',
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                          ],
                        ),
                        Height10,
                        Text(
                          'बैंक का नाम*',
                          style: StyleConstants.GoogleprofileTextFeild(),
                        ),
                        Height10,
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText:
                                  '${ref.watch(sharedUtilityProvider).getUser()?.bankName ?? ""}',
                              hintStyle:
                                  StyleConstants.GoogleprofileTextFeild(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        Height10,
                        Text(
                          'बैंक शाखा का पता*',
                          style: StyleConstants.GoogleprofileTextFeild(),
                        ),
                        Height10,
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText:
                                  '${ref.watch(sharedUtilityProvider).getUser()?.bankBranch ?? ""}',
                              hintStyle:
                                  StyleConstants.GoogleprofileTextFeild(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        Height10,
                        Text(
                          'बैंक खाता संख्या*',
                          style: StyleConstants.GoogleprofileTextFeild(),
                        ),
                        Height10,
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText:
                                  '${ref.watch(sharedUtilityProvider).getUser()?.bankAccNo ?? ""}',
                              hintStyle:
                                  StyleConstants.GoogleprofileTextFeild(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        Height10,
                        Text(
                          'बैंक IFSC कोड*',
                          style: StyleConstants.GoogleprofileTextFeild(),
                        ),
                        Height10,
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText:
                                  '${ref.watch(sharedUtilityProvider).getUser()?.bankIfscCode ?? ""}',
                              hintStyle:
                                  StyleConstants.GoogleprofileTextFeild(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
