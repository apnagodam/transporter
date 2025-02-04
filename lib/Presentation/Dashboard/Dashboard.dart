import 'dart:io';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:button_animations/button_animations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:one_context/one_context.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:restart_app/restart_app.dart';
import 'package:transporter/Data/Model/TruckDriverResponse.dart';
import 'package:transporter/Domain/Trips/TripsService.dart';
import 'package:transporter/Presentation/Routes/routes.dart';
import 'package:transporter/Presentation/Utils/Widgets/Widgets.dart';
import 'package:transporter/Presentation/Utils/height_wi.dart';
import 'package:transporter/Presentation/Utils/style_constants.dart';
import '../../Data/Model/TripDataResponse.dart';
import '../Preferences/SharedPrefs/SharedUtility.dart';
import '../Routes/routes_strings.dart';
import '../Utils/color_constants.dart';
import '../Utils/pdf/BiltyPdf.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  var truckProvider = StateProvider<TruckDatum?>((ref) => null);
  var driverProvider = StateProvider<DriverDatum?>((ref) => null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: Drawer(
        child: Scaffold(
          backgroundColor: ColorConstants.secondaryColor,
          body: Column(
            children: [
              InkWell(
                onTap: () {
                  // context.goNamed(RoutesStrings.profile);
                  ref.watch(goRouterProvider).goNamed(RoutesStrings.profile);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: Icon(
                          Icons.person,
                          size: 40,
                        ),
                      ),
                      Height10,
                      RichText(
                          text: TextSpan(
                              text: 'नाम:- ',
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              children: [
                            TextSpan(
                                text:
                                    '${ref.watch(sharedUtilityProvider).getUser()?.name ?? ""}',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 14, fontWeight: FontWeight.w600))
                          ])),
                      RichText(
                          text: TextSpan(
                              text: 'नंबर :- ',
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                              children: [
                            TextSpan(
                                text:
                                    '${ref.watch(sharedUtilityProvider).getUser()?.phone ?? ""}',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 13, fontWeight: FontWeight.w600))
                          ])),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                      ),
                      color: ColorConstants.primaryColorVendor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'प्रोफ़ाइल'.tr(),
                        style: GoogleFonts.aBeeZee(
                            color: ColorConstants.primaryColorDriver,
                            fontWeight: FontWeight.w600,
                            fontSize: Adaptive.sp(14)),
                      ),
                      leading: Icon(
                        Icons.account_circle_outlined,
                        color: ColorConstants.primaryColorDriver,
                      ),
                      onTap: () {
                        context.goNamed(RoutesStrings.profile);
                        // ref
                        //     .watch(goRouterProvider)
                        //     .goNamed(RoutesStrings.tripsHistory);
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'tripsHistory'.tr(),
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.primaryColorDriver,
                            fontSize: Adaptive.sp(14)),
                      ),
                      leading: Image.asset(
                        'assets/trip-history.png',
                        width: 30,
                        height: 30,
                        // color: ColorConstants.primaryColorVendor,
                      ),
                      onTap: () {
                        ref
                            .watch(goRouterProvider)
                            .goNamed(RoutesStrings.tripsHistory);
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Image.asset(
                        'assets/trip-request-one.png',
                        width: 30,
                        height: 30,
                      ),
                      title: Text(
                        'tripsInProcess'.tr(),
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.primaryColorDriver,
                            fontSize: Adaptive.sp(14)),
                      ),
                      onTap: () {
                        ref
                            .watch(goRouterProvider)
                            .goNamed(RoutesStrings.tripsInProcess);
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.language,
                        color: ColorConstants.primaryColorDriver,
                      ),
                      title: Text(
                        'changeLanguage'.tr(),
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.primaryColorDriver,
                            fontSize: Adaptive.sp(14)),
                      ),
                      onTap: () {
                        if (ref.watch(sharedUtilityProvider).getLocale() ==
                            Locale('hi', 'IN')) {
                          ref.watch(sharedUtilityProvider).setLocale("en");
                        } else {
                          ref.watch(sharedUtilityProvider).setLocale("hi");
                        }
                        Restart.restartApp().then((value) {
                          setState(() {});
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
          bottomSheet: InkWell(
            onTap: () async {
              ref.watch(sharedPreferencesProvider).clear();
              context.go(RoutesStrings.login);
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                  ),
                  color: ColorConstants.primaryColorVendor
                  // gradient: LinearGradient(colors: [
                  //   ColorConstation.secondaryColorWSP,
                  //   Colors.green,
                  // ])
                  ),
              child: Center(
                child: Text(
                  'Logout',
                  style: GoogleFonts.aBeeZee(
                      color: ColorConstants.secondaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: RefreshIndicator.adaptive(
              child: ref.watch(tripsListProvider).when(
                  data: (data) {
                    var dataList = data.data
                        ?.where((datum) =>
                            datum.weight == null ||
                            datum.tripStart == null ||
                            datum.tripEnd == null)
                        .toList();
                    return ListView(
                      children: [
                        tripsTypesLayout(data.data),
                        Padding(
                          padding: Pad(all: 10),
                          child: Text(
                            "Running Trip ID" + " :-",
                            style: TextStyle(
                                fontSize: Adaptive.sp(15),
                                color: ColorConstants.primaryColorVendor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              color: ColorConstants.primaryColorWSP,
                              padding: const Pad(all: 10),
                              child: IntrinsicHeight(
                                child: Row(children: [
                                  Expanded(
                                      child: Text(
                                    'Date'.tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: Adaptive.sp(14)),
                                  )),
                                  const VerticalDivider(),
                                  Expanded(
                                      child: Text(
                                    'Trip ID'.tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: Adaptive.sp(14)),
                                  )),
                                  const VerticalDivider(),
                                  Expanded(
                                      child: Text(
                                    'from'.tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: Adaptive.sp(14)),
                                  )),
                                  const VerticalDivider(),
                                  Expanded(
                                      child: Text(
                                    'to'.tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: Adaptive.sp(14)),
                                  )),
                                  const VerticalDivider(),
                                  Expanded(
                                      child: Text(
                                    "commodity".tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: Adaptive.sp(14)),
                                  )),
                                  const VerticalDivider(),
                                  Expanded(
                                      child: Text(
                                    'action'.tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: Adaptive.sp(14)),
                                  )),
                                ]),
                              ),
                            ),
                            ListView.builder(
                              itemCount: dataList?.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Container(
                                color: index % 2 == 0
                                    ? Colors.grey.withOpacity(0.2)
                                    : Colors.white,
                                padding: const Pad(all: 10),
                                child: IntrinsicHeight(
                                  child: Row(children: [
                                    Expanded(
                                        child: Text.rich(
                                      TextSpan(
                                        text:
                                            "${dataList![index].tripDate ?? "--"}",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            showDialog(
                                              // barrierColor: ColorConstants
                                              //     .primaryColorDriver,
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  backgroundColor:
                                                      ColorConstants
                                                          .secondaryColor,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "-: " +
                                                              "tripDetails"
                                                                  .tr() +
                                                              " :-",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      18),
                                                              color: ColorConstants
                                                                  .primaryColorDriver),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        RowSuper(
                                                            fill: true,
                                                            children: [
                                                              Text(
                                                                'tripId'.tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Text(
                                                                '${dataList?[index].tripId ?? "--"}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ]),
                                                        Height10,
                                                        RowSuper(
                                                            fill: true,
                                                            children: [
                                                              Text(
                                                                'Truck Number'
                                                                    .tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Text(
                                                                '${dataList?[index].truckNumber ?? "--"}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ]),
                                                        Height10,
                                                        RowSuper(
                                                            fill: true,
                                                            children: [
                                                              Text(
                                                                'transporterName'
                                                                    .tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Text(
                                                                '${dataList?[index].transporterName ?? "--"}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        RowSuper(
                                                            fill: true,
                                                            children: [
                                                              Text(
                                                                'transporterPhone'
                                                                    .tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Text(
                                                                '${dataList?[index].transporterPhone ?? "--"}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        RowSuper(
                                                            fill: true,
                                                            children: [
                                                              Text(
                                                                'customer'.tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Text.rich(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  TextSpan(
                                                                    text:
                                                                        '${dataList?[index].userName}',
                                                                    style: TextStyle(
                                                                        color: ColorConstants
                                                                            .primaryColorDriver,
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                                14),
                                                                        fontWeight:
                                                                            FontWeight.w800),
                                                                  )),
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        RowSuper(
                                                            fill: true,
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                'customerPhone'
                                                                    .tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Text(
                                                                '${dataList?[index].userPhone}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        RowSuper(
                                                            fill: true,
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                'ratePerQtl'
                                                                    .tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Text(
                                                                '${currencyFormat.format(num.parse("${dataList?[index].rate ?? 0}"))} / perQtl'
                                                                    .tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        RowSuper(
                                                            fill: true,
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                'finalWeight'
                                                                    .tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Text(
                                                                '${dataList?[index].weight ?? "pending".tr()}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        RowSuper(
                                                            fill: true,
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                'finalNoOfBags'
                                                                    .tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Text(
                                                                '${dataList?[index].noOfBags ?? "pending".tr()}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        RowSuper(
                                                            fill: true,
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                'receivingWeight'
                                                                    .tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Text(
                                                                '${dataList?[index].recevingWeight ?? "pending".tr()}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        RowSuper(
                                                            fill: true,
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                'receivingBags'
                                                                    .tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Text(
                                                                '${dataList?[index].recevingBags ?? "pending".tr()}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        RowSuper(
                                                            fill: true,
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                '${dataList?[index].weight == null ? 'provBilty'.tr() : "provBilty".tr()}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    ref
                                                                        .watch(tripDataProvider(tripRequestid: "${dataList?[index].id}")
                                                                            .future)
                                                                        .then(
                                                                            (value) {
                                                                      ref
                                                                          .watch(createBiltyPdfProvider(context: context, model: value)
                                                                              .future)
                                                                          .then(
                                                                              (value) async {
                                                                        if (value !=
                                                                            null) {
                                                                          PDFDocument
                                                                              doc =
                                                                              await PDFDocument.fromFile(value ?? File(''));
                                                                          showBarModalBottomSheet(
                                                                              context: context,
                                                                              builder: (context) => PDFViewer(document: doc));
                                                                        }
                                                                      });
                                                                    });
                                                                  },
                                                                  child: Icon(
                                                                    CupertinoIcons
                                                                        .eye,
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                  ),
                                                                ),
                                                              )
                                                            ]),
                                                        Height10,
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'KantaImage'
                                                                    .tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Container(
                                                                // height: 60,
                                                                // width: 60,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return Dialog(
                                                                          backgroundColor:
                                                                              ColorConstants.secondaryColor,
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                200,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            child:
                                                                                Image.network(
                                                                              dataList?[index].kantaImage ?? "",
                                                                              errorBuilder: (context, error, stackTrace) {
                                                                                return Center(
                                                                                    child: Text(
                                                                                  "Image Not Found !",
                                                                                  textAlign: TextAlign.center,
                                                                                ));
                                                                              },
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child: Icon(
                                                                    CupertinoIcons
                                                                        .eye,
                                                                    color: ColorConstants
                                                                        .primaryColorVendor,
                                                                  ),
                                                                ),
                                                              )
                                                            ]),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'biltyImage'
                                                                    .tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return Dialog(
                                                                          backgroundColor:
                                                                              ColorConstants.secondaryColor,
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                200,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            child:
                                                                                Image.network(
                                                                              dataList?[index].biltyImage ?? "",
                                                                              errorBuilder: (context, error, stackTrace) {
                                                                                return Center(child: Text('Image Not Found!'));
                                                                              },
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child: Icon(
                                                                    CupertinoIcons
                                                                        .eye,
                                                                    color: ColorConstants
                                                                        .primaryColorVendor,
                                                                  ),
                                                                ),
                                                              )
                                                            ]),

                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'PaotiImage'
                                                                    .tr(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .primaryColorDriver,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            14),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return Dialog(
                                                                          backgroundColor:
                                                                              ColorConstants.secondaryColor,
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                200,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            child:
                                                                                Image.network(
                                                                              dataList?[index].paotiImage ?? "",
                                                                              errorBuilder: (context, error, stackTrace) {
                                                                                return Center(child: Text('Image Not Found!'));
                                                                              },
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child: Icon(
                                                                    CupertinoIcons
                                                                        .eye,
                                                                    color: ColorConstants
                                                                        .primaryColorVendor,
                                                                  ),
                                                                ),
                                                              )
                                                            ]),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            MaterialButton(
                                                                color: ColorConstants
                                                                    .primaryColorVendor,
                                                                child: Text(
                                                                    'Cancel',
                                                                    style: GoogleFonts
                                                                        .aBeeZee(
                                                                            color:
                                                                                ColorConstants.secondaryColor)),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                }),
                                                            MaterialButton(
                                                                color: ColorConstants
                                                                    .secondaryColorWSP,
                                                                child: Text(
                                                                    'ok',
                                                                    style: GoogleFonts
                                                                        .aBeeZee(
                                                                            color:
                                                                                ColorConstants.secondaryColor)),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                }),
                                                          ],
                                                        )
                                                        // const SizedBox(
                                                        //   height: 10,
                                                        // ),
                                                        // //imageLayout(dataList),
                                                        // Divider(
                                                        //   height: 2,
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                      ),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color:
                                              ColorConstants.secondaryColorWSP,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Adaptive.sp(14)),
                                    )),
                                    const VerticalDivider(),
                                    Expanded(
                                        child: Text(
                                      "${dataList?[index].tripId ?? ""}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: Adaptive.sp(14)),
                                    )),
                                    const VerticalDivider(),
                                    Expanded(
                                        child: Text(
                                      "${dataList?[index].fromAddress}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: Adaptive.sp(14)),
                                    )),
                                    const VerticalDivider(),
                                    Expanded(
                                        child: Text.rich(
                                      TextSpan(
                                        text: "${dataList?[index].toAddress}",
                                      ),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Adaptive.sp(14)),
                                    )),
                                    const VerticalDivider(),
                                    Expanded(
                                        child: Text.rich(
                                      TextSpan(
                                        text: "${dataList?[index].commodity}",
                                      ),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Adaptive.sp(14)),
                                    )),
                                    const VerticalDivider(),
                                    Expanded(
                                      child: actionLayout(dataList![index]),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                            Divider()
                          ],
                        )
                      ],
                    );
                  },
                  error: (e, s) => Container(),
                  loading: () => CupertinoActivityIndicator()),
              onRefresh: () {
                return Future(() {
                  ref.invalidate(tripsListProvider);
                });
              })),
    );
  }

  tripsTypesLayout(List<Datum>? data) => Padding(
        padding: Pad(all: 10),
        child: Row(children: [
          Expanded(
              child: InkWell(
            child: Card(
              color: ColorConstants.primaryColorDriver,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: ColorConstants.primaryColorDriver)),
              child: Padding(
                padding: Pad(all: 15),
                child: Row(
                  children: [
                    Card(
                      child: Padding(
                        padding: Pad(all: 5),
                        child: Icon(Icons.fire_truck_outlined),
                      ),
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextOneLine(
                          "Start Trips",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: Adaptive.sp(16)),
                        ),
                        Text(
                          "${data?.where((datum) => datum.weight != null && datum.tripStart == null).toList().length}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(18)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              ref.watch(goRouterProvider).goNamed(RoutesStrings.startTrips);
            },
          )),
          Expanded(
              child: InkWell(
            child: Card(
              color: ColorConstants.primaryColorDriver,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: ColorConstants.primaryColorDriver)),
              child: Padding(
                  padding: Pad(all: 15),
                  child: Row(
                    children: [
                      Card(
                        child: Padding(
                          padding: Pad(all: 5),
                          child: Icon(Icons.history),
                        ),
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextOneLine("End Trips",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16))),
                          Text(
                            "${data?.where((datum) => datum.weight != null && datum.tripStart != null && datum.tripEnd == null).toList().length}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(18)),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
            onTap: () {
              ref.watch(goRouterProvider).goNamed(RoutesStrings.endTrips);
            },
          ))
        ]),
      );

  tripRequestLayout(Datum dataList) => Container(
        margin: Pad(all: 10),
        decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.primaryColorWSP),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const Pad(all: 10),
          child: ColumnSuper(alignment: Alignment.center, children: [
            RowSuper(fill: true, alignment: Alignment.centerRight, children: [
              Padding(
                padding: Pad(all: 10),
                child: Text(
                  dataList.tripId == null
                      ? "--"
                      : '${'tripId'.tr()}: ${dataList?.tripId.toString()}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Adaptive.sp(16),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
              ),
              TextButton(
                  onPressed: () {
                    showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context) => Material(
                              color: Colors.white,
                              child: Padding(
                                padding: Pad(all: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Trip Details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Adaptive.sp(18),
                                          color: ColorConstants
                                              .primaryColorDriver),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RowSuper(fill: true, children: [
                                      Text(
                                        'driverName'.tr(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color:
                                                ColorConstants.primaryColorWSP,
                                            fontSize: Adaptive.sp(14),
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        '${dataList.driverName ?? "--"}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color:
                                                ColorConstants.primaryColorWSP,
                                            fontSize: Adaptive.sp(14),
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RowSuper(fill: true, children: [
                                      Text(
                                        'driverPhone'.tr(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color:
                                                ColorConstants.primaryColorWSP,
                                            fontSize: Adaptive.sp(14),
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        '${dataList.driverPhone ?? "--"}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color:
                                                ColorConstants.primaryColorWSP,
                                            fontSize: Adaptive.sp(14),
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RowSuper(fill: true, children: [
                                      Text(
                                        'customer'.tr(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color:
                                                ColorConstants.primaryColorWSP,
                                            fontSize: Adaptive.sp(14),
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text.rich(
                                          textAlign: TextAlign.end,
                                          TextSpan(
                                            text: '${dataList.userName}',
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          )),
                                    ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RowSuper(
                                        fill: true,
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            'customerPhone'.tr(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${dataList.userPhone}',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RowSuper(
                                        fill: true,
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            'ratePerQtl'.tr(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${currencyFormat.format(num.parse("${dataList.rate ?? 0}"))} / perQtl'
                                                .tr(),
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RowSuper(
                                        fill: true,
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            'finalWeight'.tr(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${dataList.weight ?? "pending".tr()}',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RowSuper(
                                        fill: true,
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            'finalNoOfBags'.tr(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${dataList.noOfBags ?? "pending".tr()}',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RowSuper(
                                        fill: true,
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            'receivingWeight'.tr(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${dataList.recevingWeight ?? "pending".tr()}',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RowSuper(
                                        fill: true,
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            'receivingBags'.tr(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${dataList.recevingBags ?? "pending".tr()}',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RowSuper(
                                        fill: true,
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            '${dataList?.weight == null ? 'provBilty'.tr() : "provBilty".tr()}',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () async {
                                                ref
                                                    .watch(tripDataProvider(
                                                            tripRequestid:
                                                                "${dataList.id}")
                                                        .future)
                                                    .then((value) {
                                                  ref
                                                      .watch(
                                                          createBiltyPdfProvider(
                                                                  context:
                                                                      context,
                                                                  model: value)
                                                              .future)
                                                      .then((value) async {
                                                    if (value != null) {
                                                      PDFDocument doc =
                                                          await PDFDocument
                                                              .fromFile(value ??
                                                                  File(''));
                                                      showBarModalBottomSheet(
                                                          context: context,
                                                          builder: (context) =>
                                                              PDFViewer(
                                                                  document:
                                                                      doc));
                                                    }
                                                  });
                                                });
                                              },
                                              child: Icon(
                                                CupertinoIcons.eye,
                                                color: ColorConstants
                                                    .primaryColorWSP,
                                              ),
                                            ),
                                          )
                                        ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    imageLayout(dataList),
                                    Divider(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: Text(
                    'View Details',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontSize: Adaptive.sp(13)),
                  ))
            ]),
            const SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Row(children: [
              Expanded(
                  child: Text(
                'Date'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              )),
              Expanded(
                  child: Text(
                '${dataList.tripDate ?? ""}',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              )),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(children: [
              Expanded(
                  child: Text(
                'from'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              )),
              Expanded(
                  child: Text(
                ' ${dataList?.fromAddress}',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              )),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(children: [
              Expanded(
                  child: Text(
                'to'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              )),
              Expanded(
                  child: Text(
                ' ${dataList?.toAddress}',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              )),
            ]),
            SizedBox(
              height: 10,
            ),
            RowSuper(fill: true, alignment: Alignment.center, children: [
              Text(
                'commodity'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              ),
              Text(
                '${dataList?.commodity}',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            RowSuper(fill: true, children: [
              Text(
                'vehicleNumber'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              ),
              Text(
                '${dataList.truckNumber ?? "--"}',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              ),
            ]),
            Divider(),
            const SizedBox(
              height: 10,
            ),
            actionLayout(dataList),
            const SizedBox(
              height: 10,
            ),
          ]),
        ),
      );

  imageLayout(Datum data) => data.inOutTypes.toString().toLowerCase() == "in"
      ? Column(
          children: [
            data.poId == null
                ? SizedBox()
                : RowSuper(fill: true, alignment: Alignment.center, children: [
                    Text(
                      'goodsInvoiceImage'.tr(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: ColorConstants.primaryColorDriver,
                          fontSize: Adaptive.sp(14),
                          fontWeight: FontWeight.w800),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: InstaImageViewer(
                          imageUrl: "${data.goodsInvoiceImage}",
                          child: Icon(
                            CupertinoIcons.eye,
                            color: ColorConstants.primaryColorDriver,
                          ),
                        ),
                      ),
                    ),
                  ]),
            const SizedBox(
              height: 10,
            ),
            RowSuper(fill: true, alignment: Alignment.center, children: [
              Text(
                'Kanta Parchi Image'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: InstaImageViewer(
                    imageUrl: "${data.kantaImage}",
                    child: Icon(
                      CupertinoIcons.eye,
                      color: ColorConstants.primaryColorWSP,
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            RowSuper(fill: true, alignment: Alignment.center, children: [
              Text(
                'Quality Report Image'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: InstaImageViewer(
                    imageUrl: "${data.qualityReport}",
                    child: Icon(
                      CupertinoIcons.eye,
                      color: ColorConstants.primaryColorWSP,
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            RowSuper(fill: true, alignment: Alignment.center, children: [
              Text(
                'Invoice Image'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: InstaImageViewer(
                    imageUrl: "${data.invoiceImg}",
                    child: Icon(
                      CupertinoIcons.eye,
                      color: ColorConstants.primaryColorWSP,
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            RowSuper(fill: true, alignment: Alignment.center, children: [
              Text(
                'E-way bill  Image'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: InstaImageViewer(
                    imageUrl: "${data.eWayBill}",
                    child: Icon(
                      CupertinoIcons.eye,
                      color: ColorConstants.primaryColorWSP,
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            RowSuper(fill: true, alignment: Alignment.center, children: [
              Text(
                'Mandi Tax Image'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: InstaImageViewer(
                    imageUrl: "${data.mandiTaxImg}",
                    child: Icon(
                      CupertinoIcons.eye,
                      color: ColorConstants.primaryColorWSP,
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
          ],
        )
      : Column(
          children: [
            data.poId == null
                ? SizedBox()
                : RowSuper(fill: true, alignment: Alignment.center, children: [
                    Text(
                      'goodsInvoiceImage'.tr(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: ColorConstants.primaryColorDriver,
                          fontSize: Adaptive.sp(14),
                          fontWeight: FontWeight.w800),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: InstaImageViewer(
                          imageUrl: "${data.goodsInvoiceImage}",
                          child: Icon(
                            CupertinoIcons.eye,
                            color: ColorConstants.primaryColorDriver,
                          ),
                        ),
                      ),
                    ),
                  ]),
            const SizedBox(
              height: 10,
            ),
            RowSuper(fill: true, alignment: Alignment.center, children: [
              Text(
                'receivingKanta'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: InstaImageViewer(
                    imageUrl: "${data.recevingKantaImage}",
                    child: Icon(
                      CupertinoIcons.eye,
                      color: ColorConstants.primaryColorWSP,
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            RowSuper(fill: true, alignment: Alignment.center, children: [
              Text(
                'Paoti Image'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: InstaImageViewer(
                    imageUrl: "${data.paotiImage}",
                    child: Icon(
                      CupertinoIcons.eye,
                      color: ColorConstants.primaryColorWSP,
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            RowSuper(fill: true, alignment: Alignment.center, children: [
              Text(
                'Receiving Quality Image'.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: InstaImageViewer(
                    imageUrl: "${data.recevingQualityImg}",
                    child: Icon(
                      CupertinoIcons.eye,
                      color: ColorConstants.primaryColorWSP,
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
          ],
        );

  truckSelection(WidgetRef ref, BuildContext context, List<TruckDatum?> data) =>
      DropdownSearch<TruckDatum?>(
          popupProps: PopupProps.menu(
              searchFieldProps: const TextFieldProps(
                  autofocus: true,
                  cursorColor: ColorConstants.primaryColorWSP,
                  padding: Pad(left: 10, right: 10),
                  decoration: InputDecoration(
                    contentPadding: Pad(left: 10, right: 10),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstants.primaryColorWSP)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstants.primaryColorWSP)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstants.primaryColorWSP)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstants.primaryColorWSP)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstants.primaryColorWSP)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstants.primaryColorWSP)),
                  )),
              menuProps: MenuProps(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: ColorConstants.primaryColorWSP),
                      borderRadius: BorderRadius.circular(8))),
              itemBuilder: (context, terminal, isVisible) =>
                  ColumnSuper(alignment: Alignment.centerLeft, children: [
                    Padding(
                      padding: const Pad(all: 10),
                      child: Text(
                        "${terminal?.truckNumber ?? "--"}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Adaptive.sp(16)),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ]),
              isFilterOnline: true,
              title: Padding(
                padding: const Pad(all: 10),
                child: Text(
                  'selectTruck'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Adaptive.sp(16), fontWeight: FontWeight.bold),
                ),
              ),
              showSearchBox: true,
              searchDelay: const Duration(microseconds: 500)),
          filterFn: (user, filter) =>
              user?.districtFilterByName(filter) ?? false,
          // asyncItems: (String filter) => getData(filter),

          items: data ?? [],
          itemAsString: (TruckDatum? u) => "${u?.truckNumber ?? "--"}",
          onChanged: (TruckDatum? data) =>
              ref.watch(truckProvider.notifier).state = data,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                contentPadding: Pad(left: 10, bottom: 5, top: 5),
                hintText: 'selectTruck'.tr(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide:
                        BorderSide(color: ColorConstants.primaryColorWSP))),
          ));

  driverSelection(
          WidgetRef ref, BuildContext context, List<DriverDatum?> data) =>
      DropdownSearch<DriverDatum?>(
          popupProps: PopupProps.menu(
              searchFieldProps: const TextFieldProps(
                  autofocus: true,
                  cursorColor: ColorConstants.primaryColorWSP,
                  padding: Pad(left: 10, right: 10),
                  decoration: InputDecoration(
                    contentPadding: Pad(left: 10, right: 10),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstants.primaryColorWSP)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstants.primaryColorWSP)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstants.primaryColorWSP)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstants.primaryColorWSP)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstants.primaryColorWSP)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstants.primaryColorWSP)),
                  )),
              menuProps: MenuProps(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: ColorConstants.primaryColorWSP),
                      borderRadius: BorderRadius.circular(8))),
              itemBuilder: (context, terminal, isVisible) =>
                  ColumnSuper(alignment: Alignment.centerLeft, children: [
                    Padding(
                      padding: const Pad(all: 10),
                      child: Text(
                        "${terminal?.driverName ?? "--"}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Adaptive.sp(16)),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ]),
              isFilterOnline: true,
              title: Padding(
                padding: const Pad(all: 10),
                child: Text(
                  'selectDriver'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Adaptive.sp(16), fontWeight: FontWeight.bold),
                ),
              ),
              showSearchBox: true,
              searchDelay: const Duration(microseconds: 500)),
          filterFn: (user, filter) =>
              user?.districtFilterByName(filter) ?? false,
          // asyncItems: (String filter) => getData(filter),

          items: data ?? [],
          itemAsString: (DriverDatum? u) => "${u?.driverName ?? "--"}",
          onChanged: (DriverDatum? data) =>
              ref.watch(driverProvider.notifier).state = data,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                contentPadding: Pad(left: 10, bottom: 5, top: 5),
                hintText: 'selectDriver'.tr(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide:
                        BorderSide(color: ColorConstants.primaryColorWSP))),
          ));

  actionLayout(Datum dataList) {
    return dataList.truckNumber == null && dataList.driverName == null
        ? InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Center(
                child: Text(
                  "${"selectTruck".tr()} / ${'selectDriver'.tr()}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Adaptive.sp(14),
                      fontWeight: FontWeight.w800),
                ),
              ),
              height: 35,
              decoration: BoxDecoration(
                  color: ColorConstants.primaryColorDriver,
                  borderRadius: BorderRadius.circular(4)),
            ),
            onTap: () async {
              ref
                  .watch(truckDriverProvider.future)
                  .then((truckData) => showBarModalBottomSheet(
                      context: context,
                      builder: (modalContext) => SafeArea(
                              child: Padding(
                            padding: Pad(all: 10),
                            child: ColumnSuper(children: [
                              truckSelection(
                                  ref, context, truckData.truckData ?? []),
                              SizedBox(
                                height: 10,
                              ),
                              driverSelection(
                                  ref, context, truckData.driverData ?? []),
                              SizedBox(
                                height: 10,
                              ),
                              AnimatedButton(
                                height: 35,
                                color: ColorConstants.primaryColorWSP,
                                width: MediaQuery.of(context).size.width / 1.2,
                                isOutline: true,
                                isMultiColor: true,
                                colors: [
                                  ColorConstants.primaryColorWSP,
                                  ColorConstants.primaryColorWSP,
                                ],
                                borderWidth: 1,
                                onTap: () async {
                                  if (ref.watch(truckProvider) == null) {
                                    errorToast(context, 'selectTruck'.tr());
                                  }
                                  if (ref.watch(driverProvider) == null) {
                                    errorToast(context, 'selectDriver'.tr());
                                  } else {
                                    ref
                                        .watch(updateTruckDriverProvider(
                                                driverId:
                                                    "${ref.watch(driverProvider)?.id ?? 0}",
                                                truckId:
                                                    "${ref.watch(truckProvider)?.id ?? 0}",
                                                tripRequestId: "${dataList.id}")
                                            .future)
                                        .then((value) {
                                      if (value['status'].toString() == "1") {
                                        successToast(OneContext().context!,
                                            "${value['message'] ?? value['Message']}");

                                        ref.invalidate(tripsListProvider);
                                        ref
                                            .watch(goRouterProvider)
                                            .pop(modalContext);
                                      }
                                    });
                                  }
                                },
                                child: Text(
                                  "submit".tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Adaptive.sp(14),
                                      fontWeight: FontWeight.w800),
                                ),
                              )
                            ]),
                          ))));
            },
          )
        //  ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //         backgroundColor: ColorConstants.primaryColorDriver),
        //     onPressed: () {
        //       ref
        //           .watch(truckDriverProvider.future)
        //           .then((truckData) => showBarModalBottomSheet(
        //               context: context,
        //               builder: (modalContext) => SafeArea(
        //                       child: Padding(
        //                     padding: Pad(all: 10),
        //                     child: ColumnSuper(children: [
        //                       truckSelection(
        //                           ref, context, truckData.truckData ?? []),
        //                       SizedBox(
        //                         height: 10,
        //                       ),
        //                       driverSelection(
        //                           ref, context, truckData.driverData ?? []),
        //                       SizedBox(
        //                         height: 10,
        //                       ),
        //                       AnimatedButton(
        //                         height: 35,
        //                         color: ColorConstants.primaryColorWSP,
        //                         width: MediaQuery.of(context).size.width / 1.2,
        //                         isOutline: true,
        //                         isMultiColor: true,
        //                         colors: [
        //                           ColorConstants.primaryColorWSP,
        //                           ColorConstants.primaryColorWSP,
        //                         ],
        //                         borderWidth: 1,
        //                         onTap: () async {
        //                           if (ref.watch(truckProvider) == null) {
        //                             errorToast(context, 'selectTruck'.tr());
        //                           }
        //                           if (ref.watch(driverProvider) == null) {
        //                             errorToast(context, 'selectDriver'.tr());
        //                           } else {
        //                             ref
        //                                 .watch(updateTruckDriverProvider(
        //                                         driverId:
        //                                             "${ref.watch(driverProvider)?.id ?? 0}",
        //                                         truckId:
        //                                             "${ref.watch(truckProvider)?.id ?? 0}",
        //                                         tripRequestId: "${dataList.id}")
        //                                     .future)
        //                                 .then((value) {
        //                               if (value['status'].toString() == "1") {
        //                                 successToast(OneContext().context!,
        //                                     "${value['message'] ?? value['Message']}");

        //                                 ref.invalidate(tripsListProvider);
        //                                 ref
        //                                     .watch(goRouterProvider)
        //                                     .pop(modalContext);
        //                               }
        //                             });
        //                           }
        //                         },
        //                         child: Text(
        //                           "submit".tr(),
        //                           textAlign: TextAlign.center,
        //                           style: TextStyle(
        //                               color: Colors.white,
        //                               fontSize: Adaptive.sp(14),
        //                               fontWeight: FontWeight.w800),
        //                         ),
        //                       )
        //                     ]),
        //                   ))));
        //     },
        // child: Text(
        //   "${"selectTruck".tr()} / ${'selectDriver'.tr()}",
        //   maxLines: 1,
        //   overflow: TextOverflow.ellipsis,
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //       color: Colors.white,
        //       fontSize: Adaptive.sp(14),
        //       fontWeight: FontWeight.w800),
        // ),
        //   )
        //  AnimatedButton(
        //     height: 35,
        //     color: ColorConstants.primaryColorWSP,
        //     width: MediaQuery.of(context).size.width / 1.2,
        //     isOutline: true,
        //     isMultiColor: true,
        //     colors: [
        //       ColorConstants.primaryColorWSP,
        //       ColorConstants.primaryColorWSP,
        //     ],
        //     borderWidth: 1,
        //     onTap: () async {
        //       ref
        //           .watch(truckDriverProvider.future)
        //           .then((truckData) => showBarModalBottomSheet(
        //               context: context,
        //               builder: (modalContext) => SafeArea(
        //                       child: Padding(
        //                     padding: Pad(all: 10),
        //                     child: ColumnSuper(children: [
        //                       truckSelection(
        //                           ref, context, truckData.truckData ?? []),
        //                       SizedBox(
        //                         height: 10,
        //                       ),
        //                       driverSelection(
        //                           ref, context, truckData.driverData ?? []),
        //                       SizedBox(
        //                         height: 10,
        //                       ),
        //                       AnimatedButton(
        //                         height: 35,
        //                         color: ColorConstants.primaryColorWSP,
        //                         width: MediaQuery.of(context).size.width / 1.2,
        //                         isOutline: true,
        //                         isMultiColor: true,
        //                         colors: [
        //                           ColorConstants.primaryColorWSP,
        //                           ColorConstants.primaryColorWSP,
        //                         ],
        //                         borderWidth: 1,
        //                         onTap: () async {
        //                           if (ref.watch(truckProvider) == null) {
        //                             errorToast(context, 'selectTruck'.tr());
        //                           }
        //                           if (ref.watch(driverProvider) == null) {
        //                             errorToast(context, 'selectDriver'.tr());
        //                           } else {
        //                             ref
        //                                 .watch(updateTruckDriverProvider(
        //                                         driverId:
        //                                             "${ref.watch(driverProvider)?.id ?? 0}",
        //                                         truckId:
        //                                             "${ref.watch(truckProvider)?.id ?? 0}",
        //                                         tripRequestId: "${dataList.id}")
        //                                     .future)
        //                                 .then((value) {
        //                               if (value['status'].toString() == "1") {
        //                                 successToast(OneContext().context!,
        //                                     "${value['message'] ?? value['Message']}");

        //                                 ref.invalidate(tripsListProvider);
        //                                 ref
        //                                     .watch(goRouterProvider)
        //                                     .pop(modalContext);
        //                               }
        //                             });
        //                           }
        //                         },
        //                         child: Text(
        //                           "submit".tr(),
        //                           textAlign: TextAlign.center,
        //                           style: TextStyle(
        //                               color: Colors.white,
        //                               fontSize: Adaptive.sp(14),
        //                               fontWeight: FontWeight.w800),
        //                         ),
        //                       )
        //                     ]),
        //                   ))));
        //     },
        // child: Text(
        //   "${"selectTruck".tr()} / ${'selectDriver'.tr()}",
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //       color: Colors.white,
        //       fontSize: Adaptive.sp(14),
        //       fontWeight: FontWeight.w800),
        // ),
        //   )
        : dataList.weight != null && dataList.tripStart == null
            ? InkWell(
                onTap: () async {
                  ref
                      .watch(startTripProvider(tripRequestId: "${dataList.id}")
                          .future)
                      .then((value) {
                    if (value['status'].toString() == "1") {
                      ref.invalidate(tripsListProvider);
                    }
                  });
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "startTrip".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Adaptive.sp(14),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  height: 35,
                  decoration: BoxDecoration(
                      color: ColorConstants.secondaryColorWSP,
                      borderRadius: BorderRadius.circular(5)),
                ),
              )
            //  ElevatedButton(
            // onPressed: () async {
            //   ref
            //       .watch(startTripProvider(tripRequestId: "${dataList.id}")
            //           .future)
            //       .then((value) {
            //     if (value['status'].toString() == "1") {
            //       ref.invalidate(tripsListProvider);
            //     }
            //   });
            // },
            // child: Text(
            //   "startTrip".tr(),
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //       color: Colors.white,
            //       fontSize: Adaptive.sp(14),
            //       fontWeight: FontWeight.w800),
            // ),
            //     style: StyleConstants.submitButtonStyle(),
            //   )
            // ? AnimatedButton(
            //     height: 35,
            //     color: ColorConstants.primaryColorWSP,
            //     width: MediaQuery.of(context).size.width / 1.2,
            //     isOutline: true,
            //     isMultiColor: true,
            //     colors: [
            //       ColorConstants.secondaryColorWSP,
            //       ColorConstants.secondaryColorWSP,
            //     ],
            //     borderWidth: 1,
            // onTap: () async {
            //   ref
            //       .watch(startTripProvider(tripRequestId: "${dataList.id}")
            //           .future)
            //       .then((value) {
            //     if (value['status'].toString() == "1") {
            //       ref.invalidate(tripsListProvider);
            //     }
            //   });
            // },
            // child: Text(
            //   "startTrip".tr(),
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //       color: Colors.white,
            //       fontSize: Adaptive.sp(14),
            //       fontWeight: FontWeight.w800),
            // ),
            //   )
            : dataList.paymentTo.toString() == "1" &&
                    dataList.tripStart != null &&
                    dataList.tripEnd == null
                ? Text(
                    "End Trip pending from driver".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ColorConstants.primaryColorDriver,
                        fontSize: Adaptive.sp(14),
                        fontWeight: FontWeight.w800),
                  )
                : dataList.weight != null &&
                        dataList.tripStart != null &&
                        dataList.tripEnd == null
                    ? InkWell(
                        onTap: () async {
                          ref.watch(goRouterProvider).goNamed(
                              RoutesStrings.paotiEndTrip,
                              extra: dataList);
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              "endTrip".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Adaptive.sp(14),
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          height: 35,
                          decoration: BoxDecoration(
                              color: ColorConstants.primaryColorDriver,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      )
                    // ElevatedButton(
                    // onPressed: () async {
                    //   ref.watch(goRouterProvider).goNamed(
                    //       RoutesStrings.paotiEndTrip,
                    //       extra: dataList);
                    // },
                    //     child: Text(
                    //       "endTrip".tr(),
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: Adaptive.sp(14),
                    //           fontWeight: FontWeight.w800),
                    //     ),
                    //     style: ElevatedButton.styleFrom(
                    //         backgroundColor: ColorConstants.primaryColorDriver),
                    //   )
                    //  AnimatedButton(
                    //     height: 35,
                    //     color: ColorConstants.primaryColorWSP,
                    //     width: MediaQuery.of(context).size.width / 1.2,
                    //     isOutline: true,
                    //     isMultiColor: true,
                    //     colors: [
                    //       ColorConstants.primaryColorDriver,
                    //       ColorConstants.primaryColorDriver,
                    //     ],
                    //     borderWidth: 1,
                    //     onTap: () async {
                    //       ref.watch(goRouterProvider).goNamed(
                    //           RoutesStrings.paotiEndTrip,
                    //           extra: dataList);
                    //     },
                    // child: Text(
                    //   "endTrip".tr(),
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: Adaptive.sp(14),
                    //       fontWeight: FontWeight.w800),
                    // ),
                    //   )
                    : dataList.tripEnd != null && dataList.tripStart != null
                        ? Text(
                            "completed".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorConstants.primaryColorDriver,
                                fontSize: Adaptive.sp(14),
                                fontWeight: FontWeight.w800),
                          )
                        : Text(
                            "processing".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorConstants.primaryColorDriver,
                                fontSize: Adaptive.sp(14),
                                fontWeight: FontWeight.w800),
                          );
  }
}

var currencyFormat =
    NumberFormat.currency(locale: 'HI', symbol: '\u{20B9}', decimalDigits: 2);
