import 'dart:io';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:button_animations/button_animations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:one_context/one_context.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:restart_app/restart_app.dart';
import 'package:transporter/Data/Model/TruckDriverResponse.dart';
import 'package:transporter/Domain/Trips/TripsService.dart';
import 'package:transporter/Presentation/Routes/routes.dart';
import 'package:transporter/Presentation/Utils/Widgets/Widgets.dart';

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
        child: ListView(
          children: [
            InkWell(
              child: Card(
                color: Colors.white,
                margin: Pad(all: 10),
                elevation: 5,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      foregroundImage: NetworkImage(ref
                              .watch(sharedUtilityProvider)
                              .getUser()
                              ?.chequeImage ??
                          ""),
                      radius: 50,
                    ),
                    CupertinoActionSheetAction(
                        onPressed: () {
                          context.goNamed(RoutesStrings.profile);
                        },
                        child: RowSuper(
                          alignment: Alignment.centerLeft,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${ref.watch(sharedUtilityProvider).getUser()?.name ?? ""}',
                              style: TextStyle(
                                  fontSize: Adaptive.sp(16),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              onTap: () {
                ref.watch(goRouterProvider).goNamed(RoutesStrings.profile);
              },
            ),
            Card(
              color: Colors.white,
              margin: Pad(all: 10),
              elevation: 5,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'tripsHistory'.tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Adaptive.sp(16)),
                    ),
                    leading: Image.network('https://static-00.iconduck.com/assets.00/delivery-car-icon-512x423-t7gs5e74.png',width: 25,height: 25,),
                    onTap: () {
                      ref
                          .watch(goRouterProvider)
                          .goNamed(RoutesStrings.tripsHistory);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Image.network('https://banner2.cleanpng.com/20181207/psa/kisspng-clip-art-vector-graphics-computer-icons-illustrati-kalyan-profi-shop-1713912417297.webp',width: 30,height: 30,),

                    title: Text(
                      'tripsInProcess'.tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Adaptive.sp(16)),
                    ),
                    onTap: () {
                      ref
                          .watch(goRouterProvider)
                          .goNamed(RoutesStrings.tripsInProcess);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'changeLanguage'.tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Adaptive.sp(16)),
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
                ],
              ),
            ),

            // CupertinoActionSheet(
            //   actions: [
            //     // CupertinoActionSheetAction(
            //     //     onPressed: () async {
            //     //       ref
            //     //           .watch(createGoodsTaxInvoiceProvider(context: context)
            //     //               .future)
            //     //           .then((value) async {
            //     //         if (value != null) {
            //     //           await value
            //     //               .copy('/storage/emulated/0/Download/bilty.pdf');
            //     //           PDFDocument doc =
            //     //               await PDFDocument.fromFile(value ?? File(''));
            //     //           showBarModalBottomSheet(
            //     //               context: context,
            //     //               builder: (context) => PDFViewer(document: doc));
            //     //         }
            //     //       });
            //     //       //context.goNamed(RoutesStrings.profile);
            //     //     },
            //     //     child: Text('Goods Invoice',
            //     //         textAlign: TextAlign.start,
            //     //         style: TextStyle(
            //     //             fontSize: Adaptive.sp(16),
            //     //             color: Colors.black,
            //     //             fontWeight: FontWeight.w500))),
            //     // CupertinoActionSheetAction(
            //     //     onPressed: () async {
            //     //       ref
            //     //           .watch(
            //     //               createFreightPdfProvider(context: context).future)
            //     //           .then((value) async {
            //     //         if (value != null) {
            //     //           await value
            //     //               .copy('/storage/emulated/0/Download/bilty.pdf');
            //     //           PDFDocument doc =
            //     //               await PDFDocument.fromFile(value ?? File(''));
            //     //           showBarModalBottomSheet(
            //     //               context: context,
            //     //               builder: (context) => PDFViewer(document: doc));
            //     //         }
            //     //       });
            //     //       //context.goNamed(RoutesStrings.profile);
            //     //     },
            //     //     child: Text('Freight Invoice',
            //     //         textAlign: TextAlign.start,
            //     //         style: TextStyle(
            //     //             fontSize: Adaptive.sp(16),
            //     //             color: Colors.black,
            //     //             fontWeight: FontWeight.w500))),
            //     // CupertinoActionSheetAction(
            //     //     onPressed: () async {
            //     //       // ref
            //     //       //     .watch(
            //     //       //         createBiltyPdfProvider(context: context).future)
            //     //       //     .then((value) async {
            //     //       //   if (value != null) {
            //     //       //     await value
            //     //       //         .copy('/storage/emulated/0/Download/bilty.pdf');
            //     //       //     PDFDocument doc =
            //     //       //         await PDFDocument.fromFile(value ?? File(''));
            //     //       //     showBarModalBottomSheet(
            //     //       //         context: context,
            //     //       //         builder: (context) => PDFViewer(document: doc));
            //     //       //   }
            //     //       // });
            //     //       //context.goNamed(RoutesStrings.profile);
            //     //     },
            //     //     child: Text('Bilty',
            //     //         textAlign: TextAlign.start,
            //     //         style: TextStyle(
            //     //             fontSize: Adaptive.sp(16),
            //     //             color: Colors.black,
            //     //             fontWeight: FontWeight.w500))),
            //     CupertinoActionSheetAction(
            //         onPressed: () {
            //           context.goNamed(RoutesStrings.moneyRequests);
            //           // if (ref
            //           //         .watch(sharedUtilityProvider)
            //           //         .getUser()
            //           //         ?.tryPartyStatus !=
            //           //     2) {
            //           //   tripartyDialog(context, ref);
            //           // } else {
            //           //   context.goNamed(RoutesStrings.sanctionedAmount);
            //           // }
            //         },
            //         child: Text('Add Money Requests',
            //             textAlign: TextAlign.start,
            //             style: TextStyle(
            //                 fontSize: Adaptive.sp(16),
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.w500))),
            //     CupertinoActionSheetAction(
            //         onPressed: () {
            //           context.goNamed(RoutesStrings.withdrawMoney);
            //           // if (ref
            //           //         .watch(sharedUtilityProvider)
            //           //         .getUser()
            //           //         ?.tryPartyStatus !=
            //           //     2) {
            //           //   tripartyDialog(context, ref);
            //           // } else {
            //           //   context.goNamed(RoutesStrings.sanctionedAmount);
            //           // }
            //         },
            //         child: Text('Withdraw Money',
            //             textAlign: TextAlign.start,
            //             style: TextStyle(
            //                 fontSize: Adaptive.sp(16),
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.w500))),
            //     CupertinoActionSheetAction(
            //         onPressed: () {
            //           context.goNamed(RoutesStrings.withdrawRequests);
            //           // if (ref
            //           //         .watch(sharedUtilityProvider)
            //           //         .getUser()
            //           //         ?.tryPartyStatus !=
            //           //     2) {
            //           //   tripartyDialog(context, ref);
            //           // } else {
            //           //   context.goNamed(RoutesStrings.sanctionedAmount);
            //           // }
            //         },
            //         child: Text('Withdraw Requests',
            //             textAlign: TextAlign.start,
            //             style: TextStyle(
            //                 fontSize: Adaptive.sp(16),
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.w500))),
            //   ],
            // ),

            CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () async {
                      ref.watch(sharedPreferencesProvider).clear();
                      context.go(RoutesStrings.login);
                    },
                    child: Text(
                      'logout'.tr(),
                      style: TextStyle(
                          fontSize: Adaptive.sp(16),
                          color: Colors.red,
                          fontWeight: FontWeight.w700),
                    )),
              ],
            )
          ],
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
                            "Running Trip Ids",
                            style: TextStyle(
                                fontSize: Adaptive.sp(18),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dataList?.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return tripRequestLayout(dataList![index]);
                            })
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
        ? AnimatedButton(
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
            child: Text(
              "${"selectTruck".tr()} / ${'selectDriver'.tr()}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Adaptive.sp(14),
                  fontWeight: FontWeight.w800),
            ),
          )
        : dataList.weight != null && dataList.tripStart == null
            ? AnimatedButton(
                height: 35,
                color: ColorConstants.primaryColorWSP,
                width: MediaQuery.of(context).size.width / 1.2,
                isOutline: true,
                isMultiColor: true,
                colors: [
                  ColorConstants.secondaryColorWSP,
                  ColorConstants.secondaryColorWSP,
                ],
                borderWidth: 1,
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
                child: Text(
                  "startTrip".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Adaptive.sp(14),
                      fontWeight: FontWeight.w800),
                ),
              )
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
                    ? AnimatedButton(
                        height: 35,
                        color: ColorConstants.primaryColorWSP,
                        width: MediaQuery.of(context).size.width / 1.2,
                        isOutline: true,
                        isMultiColor: true,
                        colors: [
                          ColorConstants.primaryColorDriver,
                          ColorConstants.primaryColorDriver,
                        ],
                        borderWidth: 1,
                        onTap: () async {
                          ref.watch(goRouterProvider).goNamed(
                              RoutesStrings.paotiEndTrip,
                              extra: dataList);
                        },
                        child: Text(
                          "endTrip".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Adaptive.sp(14),
                              fontWeight: FontWeight.w800),
                        ),
                      )
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
