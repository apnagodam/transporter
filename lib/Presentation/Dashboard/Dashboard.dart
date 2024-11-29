import 'dart:convert';
import 'dart:io';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:button_animations/button_animations.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:transporter/Data/Model/TruckDriverResponse.dart';
import 'package:transporter/Domain/Trips/TripsService.dart';
import 'package:transporter/Presentation/Routes/routes.dart';
import 'package:transporter/Presentation/Utils/Widgets/Widgets.dart';
import 'package:transporter/Presentation/Utils/pdf/BiltyPdf.dart';

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
  var truckProvider = StateProvider<TruckDatum?>((ref) => null);
  var driverProvider = StateProvider<DriverDatum?>((ref) => null);
  final form = GlobalKey<FormState>();

  final bagsController = TextEditingController();
  final weightController = TextEditingController();
  final imagePicker = ImagePicker();
  var kantaImage = StateProvider<File?>((ref) => null);
  var qualityImage = StateProvider<File?>((ref) => null);

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
          child: RefreshIndicator.adaptive(
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
                                  border: Border.all(
                                      color: ColorConstants.primaryColorWSP),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const Pad(all: 10),
                                child: ColumnSuper(
                                    alignment: Alignment.center,
                                    children: [
                                      RowSuper(
                                          fill: true,
                                          alignment: Alignment.center,
                                          children: [
                                            Padding(
                                              padding: Pad(all: 10),
                                              child: Text(
                                                'Trip Id : ${data.data?[index].tripId ?? "--"}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: Adaptive.sp(16),
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
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
                                      RowSuper(fill: true, children: [
                                        Text(
                                          'From',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstants
                                                  .primaryColorWSP,
                                              fontSize: Adaptive.sp(14),
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Text(
                                          ' ${data.data?[index]?.fromAddress}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: ColorConstants
                                                  .primaryColorWSP,
                                              fontSize: Adaptive.sp(14),
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      RowSuper(fill: true, children: [
                                        Text(
                                          'To',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstants
                                                  .primaryColorWSP,
                                              fontSize: Adaptive.sp(14),
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Text(
                                          ' ${data.data?[index]?.toAddress}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: ColorConstants
                                                  .primaryColorWSP,
                                              fontSize: Adaptive.sp(14),
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      RowSuper(fill: true, children: [
                                        Text(
                                          'Vehicle Number',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstants
                                                  .primaryColorWSP,
                                              fontSize: Adaptive.sp(14),
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Text(
                                          '${data.data?[index].truckNumber ?? "--"}',
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
                                      RowSuper(fill: true, children: [
                                        Text(
                                          'Driver name',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstants
                                                  .primaryColorWSP,
                                              fontSize: Adaptive.sp(14),
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Text(
                                          '${data.data?[index].driverName ?? "--"}',
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
                                      RowSuper(fill: true, children: [
                                        Text(
                                          'Driver phone',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstants
                                                  .primaryColorWSP,
                                              fontSize: Adaptive.sp(14),
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Text(
                                          '${data.data?[index].driverPhone ?? "--"}',
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
                                      RowSuper(fill: true, children: [
                                        Text(
                                          'Customer',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstants
                                                  .primaryColorWSP,
                                              fontSize: Adaptive.sp(14),
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Text.rich(
                                            textAlign: TextAlign.end,
                                            TextSpan(
                                              text:
                                                  '${data.data?[index].userName}',
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
                                              'Customer Phone',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColorWSP,
                                                  fontSize: Adaptive.sp(14),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Text(
                                              '${data.data?[index].userPhone}',
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
                                              'Rate per Qtl. (Freight Rate)',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColorWSP,
                                                  fontSize: Adaptive.sp(14),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Text(
                                              '${currencyFormat.format(int.parse("${data.data?[index].rate ?? 0}"))} / per Qtl.',
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
                                              'Commodity',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColorWSP,
                                                  fontSize: Adaptive.sp(14),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Text(
                                              '${data.data?[index].commodity}',
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
                                              'Final Weight(Qtl.)',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColorWSP,
                                                  fontSize: Adaptive.sp(14),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Text(
                                              '${data.data?[index].weight ?? "Pending"}',
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
                                              'Final No of Bags',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColorWSP,
                                                  fontSize: Adaptive.sp(14),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Text(
                                              '${data.data?[index].noOfBags ?? "Pending"}',
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
                                              'Receiving Weight(Qtl.)',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColorWSP,
                                                  fontSize: Adaptive.sp(14),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Text(
                                              '${data.data?[index].recevingWeight ?? "Pending"}',
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
                                              'Receiving Bags',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColorWSP,
                                                  fontSize: Adaptive.sp(14),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Text(
                                              '${data.data?[index].recevingBags ?? "Pending"}',
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
                                              '${data.data?[index].weight == null ? 'Provisional Billty ' : "Final Billty "}',
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
                                                                  "${data.data?[index].id}")
                                                          .future)
                                                      .then((value) {
                                                    ref
                                                        .watch(
                                                            createBiltyPdfProvider(
                                                                    context:
                                                                        context,
                                                                    model:
                                                                        value)
                                                                .future)
                                                        .then((value) async {
                                                      if (value != null) {
                                                        PDFDocument doc =
                                                            await PDFDocument
                                                                .fromFile(
                                                                    value ??
                                                                        File(
                                                                            ''));
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
                                      data.data?[index].poId == null
                                          ? SizedBox()
                                          : RowSuper(
                                              fill: true,
                                              alignment: Alignment.center,
                                              children: [
                                                  Text(
                                                    'Goods Invoice Image',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color: ColorConstants
                                                            .primaryColorDriver,
                                                        fontSize:
                                                            Adaptive.sp(14),
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: InstaImageViewer(
                                                        imageUrl:
                                                            "${ImageClient.assetsImageUrl}${data.data?[index].goodsInvoiceImage}",
                                                        child: Icon(
                                                          CupertinoIcons.eye,
                                                          color: ColorConstants
                                                              .primaryColorDriver,
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
                                                  color: ColorConstants
                                                      .primaryColorWSP,
                                                  fontSize: Adaptive.sp(14),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: () {},
                                                child: InstaImageViewer(
                                                  imageUrl:
                                                      "${ImageClient.secondKantaImage}${data.data![index].kantaImage}",
                                                  child: Icon(
                                                    CupertinoIcons.eye,
                                                    color: ColorConstants
                                                        .primaryColorWSP,
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
                                                  color: ColorConstants
                                                      .primaryColorWSP,
                                                  fontSize: Adaptive.sp(14),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: () {},
                                                child: InstaImageViewer(
                                                  imageUrl:
                                                      "${ImageClient.secondKantaImage}${data.data?[index].recevingKantaImage}",
                                                  child: Icon(
                                                    CupertinoIcons.eye,
                                                    color: ColorConstants
                                                        .primaryColorWSP,
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
                                      data.data?[index].truckNumber == null &&
                                              data.data?[index].driverName ==
                                                  null
                                          ? AnimatedButton(
                                              height: 35,
                                              color: ColorConstants
                                                  .primaryColorWSP,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2,
                                              isOutline: true,
                                              isMultiColor: true,
                                              colors: [
                                                ColorConstants.primaryColorWSP,
                                                ColorConstants.primaryColorWSP,
                                              ],
                                              borderWidth: 1,
                                              onTap: () async {
                                                ref
                                                    .watch(truckDriverProvider
                                                        .future)
                                                    .then((truckData) =>
                                                        showBarModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (modalContext) =>
                                                                    SafeArea(
                                                                        child:
                                                                            Padding(
                                                                      padding: Pad(
                                                                          all:
                                                                              10),
                                                                      child: ColumnSuper(
                                                                          children: [
                                                                            truckSelection(
                                                                                ref,
                                                                                context,
                                                                                truckData.truckData ?? []),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            driverSelection(
                                                                                ref,
                                                                                context,
                                                                                truckData.driverData ?? []),
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
                                                                                  errorToast(context, 'Please select truck');
                                                                                }
                                                                                if (ref.watch(driverProvider) == null) {
                                                                                  errorToast(context, 'Please select driver');
                                                                                } else {
                                                                                  ref.watch(updateTruckDriverProvider(driverId: "${ref.watch(driverProvider)?.id ?? 0}", truckId: "${ref.watch(truckProvider)?.id ?? 0}", tripRequestId: "${data.data?[index].id}").future).then((value) {
                                                                                    if (value['status'].toString() == "1") {
                                                                                      ref.invalidate(tripsListProvider);
                                                                                      ref.watch(goRouterProvider).pop(modalContext);
                                                                                    }
                                                                                  });
                                                                                }
                                                                              },
                                                                              child: Text(
                                                                                "Submit",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(color: Colors.white, fontSize: Adaptive.sp(14), fontWeight: FontWeight.w800),
                                                                              ),
                                                                            )
                                                                          ]),
                                                                    ))));
                                              },
                                              child: Text(
                                                "Add Truck / Driver",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Adaptive.sp(14),
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            )
                                          : data.data?[index].weight != null &&
                                                  data.data?[index].tripStart ==
                                                      null
                                              ? AnimatedButton(
                                                  height: 35,
                                                  color: ColorConstants
                                                      .primaryColorWSP,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.2,
                                                  isOutline: true,
                                                  isMultiColor: true,
                                                  colors: [
                                                    ColorConstants
                                                        .secondaryColorWSP,
                                                    ColorConstants
                                                        .secondaryColorWSP,
                                                  ],
                                                  borderWidth: 1,
                                                  onTap: () async {
                                                    ref
                                                        .watch(startTripProvider(
                                                                tripRequestId:
                                                                    "${data.data?[index].id}")
                                                            .future)
                                                        .then((value) {
                                                      if (value['status']
                                                              .toString() ==
                                                          "1") {
                                                        ref.invalidate(
                                                            tripsListProvider);
                                                      }
                                                    });
                                                  },
                                                  child: Text(
                                                    "Start Trip",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            Adaptive.sp(14),
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                )
                                              : data.data?[index].weight !=
                                                          null &&
                                                      data.data?[index]
                                                              .tripStart !=
                                                          null &&
                                                      data.data?[index]
                                                              .tripEnd ==
                                                          null
                                                  ? AnimatedButton(
                                                      height: 35,
                                                      color: ColorConstants
                                                          .primaryColorWSP,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.2,
                                                      isOutline: true,
                                                      isMultiColor: true,
                                                      colors: [
                                                        ColorConstants
                                                            .primaryColorDriver,
                                                        ColorConstants
                                                            .primaryColorDriver,
                                                      ],
                                                      borderWidth: 1,
                                                      onTap: () async {
                                                        showBarModalBottomSheet(
                                                            context: context,
                                                            builder: (context) =>
                                                                Consumer(
                                                                    builder: (context,
                                                                            ref,
                                                                            child) =>
                                                                        SafeArea(
                                                                            child:
                                                                                Padding(
                                                                          padding:
                                                                              Pad(all: 10),
                                                                          child: Form(
                                                                              key: form,
                                                                              child: ListView(
                                                                                children: [
                                                                                  TextFormField(
                                                                                    controller: bagsController,
                                                                                    keyboardType: TextInputType.text,
                                                                                    validator: (value) {
                                                                                      if (value == null || value.isEmpty) {
                                                                                        return 'Please input bags';
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                    decoration: InputDecoration(label: const Text('Enter bags'), contentPadding: const Pad(top: 0, bottom: 0, left: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  TextFormField(
                                                                                    controller: weightController,
                                                                                    keyboardType: TextInputType.text,
                                                                                    validator: (value) {
                                                                                      if (value == null || value.isEmpty) {
                                                                                        return 'Please input receieving weight';
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                    decoration: InputDecoration(label: const Text('Enter Receiving weight'), contentPadding: const Pad(top: 0, bottom: 0, left: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  DottedBorder(
                                                                                      borderType: BorderType.RRect,
                                                                                      dashPattern: const [5, 5, 5, 5],
                                                                                      color: ColorConstants.primaryColorDriver,
                                                                                      child: Padding(
                                                                                        padding: const Pad(all: 20),
                                                                                        child: Center(
                                                                                          child: ref.watch(kantaImage) != null
                                                                                              ? Stack(
                                                                                                  children: [
                                                                                                    Image.file(ref.watch(kantaImage) ?? File('')),
                                                                                                    Container(
                                                                                                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle),
                                                                                                      child: IconButton(
                                                                                                          onPressed: () {
                                                                                                            ref.invalidate(kantaImage);
                                                                                                          },
                                                                                                          icon: const Icon(
                                                                                                            Icons.close,
                                                                                                            color: Colors.white,
                                                                                                          )),
                                                                                                    )
                                                                                                  ],
                                                                                                )
                                                                                              : InkWell(
                                                                                                  child: ColumnSuper(children: [
                                                                                                    Icon(
                                                                                                      Icons.cloud_upload,
                                                                                                      color: ColorConstants.primaryColorDriver,
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      height: 5,
                                                                                                    ),
                                                                                                    Text(
                                                                                                      "Select kanta ",
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: TextStyle(color: ColorConstants.primaryColorDriver, fontWeight: FontWeight.bold, fontSize: Adaptive.sp(16)),
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      height: 5,
                                                                                                    ),
                                                                                                    Text(
                                                                                                      "Upload Document Image,\n  Supports JPG, JPEG, PNG",
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: TextStyle(color: ColorConstants.primaryColorDriver, fontWeight: FontWeight.w700, fontSize: Adaptive.sp(13)),
                                                                                                    )
                                                                                                  ]),
                                                                                                  onTap: () async {
                                                                                                    imagePicker.pickImage(source: ImageSource.camera).then((file) {
                                                                                                      if (file != null) {
                                                                                                        ref.watch(kantaImage.notifier).state = File(file.path);
                                                                                                      }
                                                                                                    });
                                                                                                  },
                                                                                                ),
                                                                                        ),
                                                                                      )),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  DottedBorder(
                                                                                      borderType: BorderType.RRect,
                                                                                      dashPattern: const [5, 5, 5, 5],
                                                                                      color: ColorConstants.primaryColorDriver,
                                                                                      child: Padding(
                                                                                        padding: const Pad(all: 20),
                                                                                        child: Center(
                                                                                          child: ref.watch(qualityImage) != null
                                                                                              ? Stack(
                                                                                                  children: [
                                                                                                    Image.file(ref.watch(qualityImage) ?? File('')),
                                                                                                    Container(
                                                                                                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle),
                                                                                                      child: IconButton(
                                                                                                          onPressed: () {
                                                                                                            ref.invalidate(qualityImage);
                                                                                                          },
                                                                                                          icon: const Icon(
                                                                                                            Icons.close,
                                                                                                            color: Colors.white,
                                                                                                          )),
                                                                                                    )
                                                                                                  ],
                                                                                                )
                                                                                              : InkWell(
                                                                                                  child: ColumnSuper(children: [
                                                                                                    Icon(
                                                                                                      Icons.cloud_upload,
                                                                                                      color: ColorConstants.primaryColorDriver,
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      height: 5,
                                                                                                    ),
                                                                                                    Text(
                                                                                                      "Select Quality Image",
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: TextStyle(color: ColorConstants.primaryColorDriver, fontWeight: FontWeight.bold, fontSize: Adaptive.sp(16)),
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      height: 5,
                                                                                                    ),
                                                                                                    Text(
                                                                                                      "Upload Document Image,\n  Supports JPG, JPEG, PNG",
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: TextStyle(color: ColorConstants.primaryColorDriver, fontWeight: FontWeight.w700, fontSize: Adaptive.sp(13)),
                                                                                                    )
                                                                                                  ]),
                                                                                                  onTap: () async {
                                                                                                    imagePicker.pickImage(source: ImageSource.camera).then((file) {
                                                                                                      if (file != null) {
                                                                                                        ref.watch(qualityImage.notifier).state = File(file.path);
                                                                                                      }
                                                                                                    });
                                                                                                  },
                                                                                                ),
                                                                                        ),
                                                                                      )),
                                                                                  AnimatedButton(
                                                                                    height: 35,
                                                                                    color: ColorConstants.primaryColorDriver,
                                                                                    width: MediaQuery.of(context).size.width / 1.2,
                                                                                    isOutline: true,
                                                                                    isMultiColor: true,
                                                                                    colors: [
                                                                                      ColorConstants.primaryColorDriver,
                                                                                      ColorConstants.primaryColorDriver,
                                                                                    ],
                                                                                    borderWidth: 1,
                                                                                    child: Text(
                                                                                      "Submit",
                                                                                    ),
                                                                                    onTap: () async {
                                                                                      if (form.currentState!.validate()) {
                                                                                        if (ref.watch(kantaImage) == null) {
                                                                                          errorToast(context, "please select kanta image");
                                                                                        }
                                                                                        if (ref.watch(qualityImage) == null) {
                                                                                          errorToast(context, 'Please select quality image');
                                                                                        } else {
                                                                                          final bytes = File(ref.watch(kantaImage)?.path ?? "").readAsBytesSync();
                                                                                          String img64 = base64Encode(bytes);

                                                                                          final bytes2 = File(ref.watch(qualityImage)?.path ?? "").readAsBytesSync();
                                                                                          String img642 = base64Encode(bytes);
                                                                                          ref.watch(endTripProvider(tripRequestId: '${data.data?[index]?.id ?? 0}', kantaWeight: '${weightController.text.toString()}', bags: "${bagsController.text.toString()}", kantaImage: img64, qualityImage: img642).future).then((value) {
                                                                                            if (value['status'].toString() == "1") {
                                                                                              ref.invalidate(tripsListProvider);
                                                                                              ref.invalidate(kantaImage);
                                                                                              ref.invalidate(qualityImage);
                                                                                              bagsController.clear();
                                                                                              weightController.clear();
                                                                                              ref.watch(goRouterProvider).pop(context);
                                                                                            }
                                                                                          });
                                                                                        }
                                                                                      }
                                                                                    },
                                                                                  )
                                                                                ],
                                                                              )),
                                                                        ))));
                                                      },
                                                      child: Text(
                                                        "End Trip",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                Adaptive.sp(14),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    )
                                                  : data.data?[index].tripEnd !=
                                                              null &&
                                                          data.data?[index]
                                                                  .tripStart !=
                                                              null
                                                      ? Text(
                                                          "Completed",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: ColorConstants
                                                                  .primaryColorDriver,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      14),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        )
                                                      : Text(
                                                          "Processing",
                                                          textAlign:
                                                              TextAlign.center,
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
              ),
              onRefresh: () {
                return Future(() {
                  ref.invalidate(tripsListProvider);
                });
              })),
    );
  }

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
                  'Select Truck',
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
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                contentPadding: Pad(left: 10, bottom: 5, top: 5),
                hintText: "Select Truck",
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
                  'Select Driver',
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
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                contentPadding: Pad(left: 10, bottom: 5, top: 5),
                hintText: "Select Driver",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide:
                        BorderSide(color: ColorConstants.primaryColorWSP))),
          ));
}

var currencyFormat =
    NumberFormat.currency(locale: 'HI', symbol: '\u{20B9}', decimalDigits: 2);
