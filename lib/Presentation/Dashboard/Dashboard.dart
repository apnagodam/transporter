import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:button_animations/button_animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:transporter/Domain/Trips/TripsService.dart';

import '../../Domain/Dio/DioProvider.dart';
import '../Preferences/SharedPrefs/SharedUtility.dart';
import '../Routes/routes_strings.dart';
import '../Utils/color_constants.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      context.goNamed(RoutesStrings.profile);
                    },
                    child: RowSuper(
                      alignment: Alignment.centerLeft,
                      children: [
                        ClipOval(
                          child: Icon(Icons.person_2),
                        ),
                        // CircleAvatar(
                        //   foregroundImage: NetworkImage(ref
                        //       .watch(sharedUtilityProvider)
                        //       .getUser()
                        //       ?.profileImage ??
                        //       ""),
                        // ),
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
            CupertinoActionSheet(
              actions: [
                // CupertinoActionSheetAction(
                //     onPressed: () async {
                //       ref
                //           .watch(createGoodsTaxInvoiceProvider(context: context)
                //               .future)
                //           .then((value) async {
                //         if (value != null) {
                //           await value
                //               .copy('/storage/emulated/0/Download/bilty.pdf');
                //           PDFDocument doc =
                //               await PDFDocument.fromFile(value ?? File(''));
                //           showBarModalBottomSheet(
                //               context: context,
                //               builder: (context) => PDFViewer(document: doc));
                //         }
                //       });
                //       //context.goNamed(RoutesStrings.profile);
                //     },
                //     child: Text('Goods Invoice',
                //         textAlign: TextAlign.start,
                //         style: TextStyle(
                //             fontSize: Adaptive.sp(16),
                //             color: Colors.black,
                //             fontWeight: FontWeight.w500))),
                // CupertinoActionSheetAction(
                //     onPressed: () async {
                //       ref
                //           .watch(
                //               createFreightPdfProvider(context: context).future)
                //           .then((value) async {
                //         if (value != null) {
                //           await value
                //               .copy('/storage/emulated/0/Download/bilty.pdf');
                //           PDFDocument doc =
                //               await PDFDocument.fromFile(value ?? File(''));
                //           showBarModalBottomSheet(
                //               context: context,
                //               builder: (context) => PDFViewer(document: doc));
                //         }
                //       });
                //       //context.goNamed(RoutesStrings.profile);
                //     },
                //     child: Text('Freight Invoice',
                //         textAlign: TextAlign.start,
                //         style: TextStyle(
                //             fontSize: Adaptive.sp(16),
                //             color: Colors.black,
                //             fontWeight: FontWeight.w500))),
                // CupertinoActionSheetAction(
                //     onPressed: () async {
                //       // ref
                //       //     .watch(
                //       //         createBiltyPdfProvider(context: context).future)
                //       //     .then((value) async {
                //       //   if (value != null) {
                //       //     await value
                //       //         .copy('/storage/emulated/0/Download/bilty.pdf');
                //       //     PDFDocument doc =
                //       //         await PDFDocument.fromFile(value ?? File(''));
                //       //     showBarModalBottomSheet(
                //       //         context: context,
                //       //         builder: (context) => PDFViewer(document: doc));
                //       //   }
                //       // });
                //       //context.goNamed(RoutesStrings.profile);
                //     },
                //     child: Text('Bilty',
                //         textAlign: TextAlign.start,
                //         style: TextStyle(
                //             fontSize: Adaptive.sp(16),
                //             color: Colors.black,
                //             fontWeight: FontWeight.w500))),
                CupertinoActionSheetAction(
                    onPressed: () {
                      context.goNamed(RoutesStrings.moneyRequests);
                      // if (ref
                      //         .watch(sharedUtilityProvider)
                      //         .getUser()
                      //         ?.tryPartyStatus !=
                      //     2) {
                      //   tripartyDialog(context, ref);
                      // } else {
                      //   context.goNamed(RoutesStrings.sanctionedAmount);
                      // }
                    },
                    child: Text('Add Money Requests',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: Adaptive.sp(16),
                            color: Colors.black,
                            fontWeight: FontWeight.w500))),
                CupertinoActionSheetAction(
                    onPressed: () {
                      context.goNamed(RoutesStrings.withdrawMoney);
                      // if (ref
                      //         .watch(sharedUtilityProvider)
                      //         .getUser()
                      //         ?.tryPartyStatus !=
                      //     2) {
                      //   tripartyDialog(context, ref);
                      // } else {
                      //   context.goNamed(RoutesStrings.sanctionedAmount);
                      // }
                    },
                    child: Text('Withdraw Money',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: Adaptive.sp(16),
                            color: Colors.black,
                            fontWeight: FontWeight.w500))),
                CupertinoActionSheetAction(
                    onPressed: () {
                      context.goNamed(RoutesStrings.withdrawRequests);
                      // if (ref
                      //         .watch(sharedUtilityProvider)
                      //         .getUser()
                      //         ?.tryPartyStatus !=
                      //     2) {
                      //   tripartyDialog(context, ref);
                      // } else {
                      //   context.goNamed(RoutesStrings.sanctionedAmount);
                      // }
                    },
                    child: Text('Withdraw Requests',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: Adaptive.sp(16),
                            color: Colors.black,
                            fontWeight: FontWeight.w500))),
              ],
            ),
            CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () async {
                      ref.watch(sharedPreferencesProvider).clear();
                      context.go(RoutesStrings.login);
                    },
                    child: Text(
                      'Logout',
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
          child: ListView(
        children: [
          ref.watch(tripsListProvider).when(
              data: (data) => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.data?.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: Pad(all: 10),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: ColorConstants.primaryColorWSP),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const Pad(all: 10),
                        child:
                            ColumnSuper(alignment: Alignment.center, children: [
                          Padding(
                            padding: Pad(all: 10),
                            child: Text.rich(TextSpan(
                                text:
                                    'From:  ${data.data?[index]?.fromAddress},\n\nTo:  ${data.data?[index]?.toAddress}',
                                style: TextStyle(
                                    color: ColorConstants.primaryColorWSP,
                                    fontSize: Adaptive.sp(15),
                                    fontWeight: FontWeight.bold))),
                          ),
                          Divider(
                            height: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RowSuper(
                              fill: true,
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: Pad(all: 10),
                                  child: Text(
                                    'Trip Id : ${data.data?[index].tripId}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ]),
                          const SizedBox(
                            height: 10,
                          ),
                          RowSuper(fill: true, children: [
                            Text(
                              'Driver name',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: ColorConstants.primaryColorWSP,
                                  fontSize: Adaptive.sp(14),
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              '${data.data?[index].driverName}',
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
                              'Driver phone',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: ColorConstants.primaryColorWSP,
                                  fontSize: Adaptive.sp(14),
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              '${data.data?[index].driverPhone}',
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
                          RowSuper(
                              fill: true,
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  'Customer',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: ColorConstants.primaryColorWSP,
                                      fontSize: Adaptive.sp(14),
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  '${data.data?[index].userName}',
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
                          RowSuper(
                              fill: true,
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  'Customer Phone',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: ColorConstants.primaryColorWSP,
                                      fontSize: Adaptive.sp(14),
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  '${data.data?[index].userPhone}',
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
                          RowSuper(
                              fill: true,
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  'Rate per Qtl.',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: ColorConstants.primaryColorWSP,
                                      fontSize: Adaptive.sp(14),
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  '${currencyFormat.format(int.parse("${data.data?[index].rate ?? 0}"))} / per Qtl.',
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
                          RowSuper(
                              fill: true,
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  'Commodity',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: ColorConstants.primaryColorWSP,
                                      fontSize: Adaptive.sp(14),
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  '${data.data?[index].commodity}',
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
                          RowSuper(
                              fill: true,
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  'Weight',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: ColorConstants.primaryColorWSP,
                                      fontSize: Adaptive.sp(14),
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  '${data.data?[index].weight ?? "Pending"}',
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
                          RowSuper(
                              fill: true,
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  'No of Bags',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: ColorConstants.primaryColorWSP,
                                      fontSize: Adaptive.sp(14),
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  '${data.data?[index].noOfBags ?? "Pending"}',
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
                          RowSuper(
                              fill: true,
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  'Receiving Weight(Qtl.)',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: ColorConstants.primaryColorWSP,
                                      fontSize: Adaptive.sp(14),
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  '${data.data?[index].recevingBags ?? "Pending"}',
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
                          RowSuper(
                              fill: true,
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  'Bilty Image',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: ColorConstants.primaryColorWSP,
                                      fontSize: Adaptive.sp(14),
                                      fontWeight: FontWeight.w800),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () async {
                                      // ref
                                      //     .watch(tripDataProvider(
                                      //     tripRequestid:
                                      //     data.data?[index].id ??
                                      //         "")
                                      //     .future)
                                      //     .then((value) {
                                      //   ref
                                      //       .watch(createBiltyPdfProvider(
                                      //       context: context,
                                      //       model: value)
                                      //       .future)
                                      //       .then((value) async {
                                      //     if (value != null) {
                                      //       PDFDocument doc =
                                      //       await PDFDocument.fromFile(
                                      //           value ?? File(''));
                                      //       showBarModalBottomSheet(
                                      //           context: context,
                                      //           builder: (context) =>
                                      //               PDFViewer(document: doc));
                                      //     }
                                      //   });
                                      // });
                                    },
                                    child: Icon(
                                      CupertinoIcons.eye,
                                      color: ColorConstants.primaryColorWSP,
                                    ),
                                  ),
                                )
                              ]),
                          const SizedBox(
                            height: 10,
                          ),
                          RowSuper(
                              fill: true,
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  'Goods Invoice Image',
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
                                      imageUrl:
                                          "${ImageClient.assetsImageUrl}${data.data?[index].goodsInvoiceImage}",
                                      child: Icon(
                                        CupertinoIcons.eye,
                                        color:
                                            ColorConstants.primaryColorDriver,
                                      ),
                                    ),
                                  ),
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
                                  'Kanta Image',
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
                                      imageUrl:
                                          "${ImageClient.frontEndAssetsUrl}${data.data![index].kantaImage}",
                                      child: Icon(
                                        CupertinoIcons.eye,
                                        color:
                                            ColorConstants.primaryColorWSP,
                                      ),
                                    ),
                                  ),
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
                                  'Receiving Kanta Parchi',
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
                                      imageUrl:
                                          "${ImageClient.assetsImageUrl}${data.data?[index].goodsInvoiceImage}",
                                      child: Icon(
                                        CupertinoIcons.eye,
                                        color:
                                            ColorConstants.primaryColorWSP,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                            height: 2,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          data.data?[index].tripEnd != null ||
                                  data.data?[index].tripStart != null
                              ? Text(
                                  'Trip Ended',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: data.data?[index]?.status
                                                  ?.toInt() ==
                                              0
                                          ? Colors.red
                                          : ColorConstants.primaryColorWSP,
                                      fontSize: Adaptive.sp(14),
                                      fontWeight: FontWeight.w800),
                                )
                              : data.data?[index].weight == null ||
                                      data.data?[index].tripStart == null
                                  ? Text(
                                      'Trip Start Pending',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: data.data?[index]?.status
                                                      ?.toInt() ==
                                                  0
                                              ? Colors.red
                                              : ColorConstants
                                                  .primaryColorDriver,
                                          fontSize: Adaptive.sp(14),
                                          fontWeight: FontWeight.w800),
                                    )
                                  : AnimatedButton(
                                      height: 35,
                                      color: ColorConstants.primaryColorWSP,
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      isOutline: true,
                                      isMultiColor: true,
                                      colors: [
                                        ColorConstants.primaryColorWSP,
                                        ColorConstants.primaryColorWSP,
                                      ],
                                      borderWidth: 1,
                                      onTap: () async {},
                                      child: Text(
                                        "Trip End",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Adaptive.sp(14),
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                          const SizedBox(
                            height: 10,
                          ),
                        ]),
                      ),
                    );
                  }),
              error: (e, s) => Container(),
              loading: () => CupertinoActivityIndicator())
        ],
      )),
    );
  }
}

var currencyFormat =
    NumberFormat.currency(locale: 'HI', symbol: '\u{20B9}', decimalDigits: 2);
