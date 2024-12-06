import 'dart:io';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:button_animations/button_animations.dart';
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
                                                  "${data.data?[index].goodsInvoiceImage}",
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
                                 Text(
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
                                          ,
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
