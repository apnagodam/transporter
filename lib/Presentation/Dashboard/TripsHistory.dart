import 'dart:io';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:button_animations/button_animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:transporter/Domain/Trips/TripsService.dart';

import '../../Domain/Dio/DioProvider.dart';
import '../Utils/color_constants.dart';
import '../Utils/pdf/BiltyPdf.dart';
import 'Dashboard.dart';

class Tripshistory extends ConsumerStatefulWidget {
  const Tripshistory({super.key});

  @override
  ConsumerState<Tripshistory> createState() => _TripshistoryState();
}

class _TripshistoryState extends ConsumerState<Tripshistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trips History'),),
      body: SafeArea(
          child: RefreshIndicator.adaptive(
              child: ListView(
                children: [
                  ref.watch(tripsHistoryProvider).when(
                      data: (data) =>ListView.builder(
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
                                                '${'tripId'.tr()}: ${data.data?[index].tripId ?? "--"}',
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
                                          'from'.tr(),
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
                                          'to'.tr(),
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
                                          'vehicleNumber'.tr(),
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
                                          'driverName'.tr(),
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
                                          'driverPhone'.tr(),
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
                                          'customer'.tr(),
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
                                              'customerPhone'.tr(),
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
                                              'ratePerQtl'.tr(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColorWSP,
                                                  fontSize: Adaptive.sp(14),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Text(
                                              '${currencyFormat.format(int.parse("${data.data?[index].rate ?? 0}"))} / perQtl'.tr(),
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
                                              'commodity'.tr(),
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
                                              'finalWeight'.tr(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColorWSP,
                                                  fontSize: Adaptive.sp(14),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Text(
                                              '${data.data?[index].weight ?? "pending".tr()}',
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
                                              '${data.data?[index].noOfBags ?? "pending".tr()}',
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
                                              '${data.data?[index].recevingWeight ?? "pending".tr()}',
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
                                              '${data.data?[index].recevingBags ?? "pending".tr()}',
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
                                              '${data.data?[index].weight == null ? 'provBilty'.tr() : "provBilty".tr()}',
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
                                              'goodsInvoiceImage'.tr(),
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
                                              'kantaImage'.tr(),
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
                                              'receivingKanta'.tr(),
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

                                        },
                                        child: Text(
                                          "selectTruck / selectDriver".tr(),
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
                                          "startTrip".tr(),
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
                                          ? Text(
                                        "endTrip".tr(),
                                        textAlign:
                                        TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                            Adaptive.sp(14),
                                            fontWeight:
                                            FontWeight
                                                .w800),
                                      )
                                          : data.data?[index].tripEnd !=
                                          null &&
                                          data.data?[index]
                                              .tripStart !=
                                              null
                                          ? Text(
                                        "completed".tr(),
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
                                        "processing".tr(),
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
                  ref.invalidate(tripsHistoryProvider);
                });
              })),
    );
  }
}
