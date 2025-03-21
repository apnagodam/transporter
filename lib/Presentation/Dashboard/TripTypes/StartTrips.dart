import 'dart:io';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:button_animations/button_animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:transporter/Domain/Trips/TripsService.dart';

import '../../../Data/Model/TripDataResponse.dart';
import '../../Routes/routes.dart';
import '../../Routes/routes_strings.dart';
import '../../Utils/color_constants.dart';
import '../../Utils/pdf/BiltyPdf.dart';
import '../Dashboard.dart';

class Starttrips extends ConsumerStatefulWidget {
  const Starttrips({super.key});

  @override
  ConsumerState<Starttrips> createState() => _StarttripsState();
}

class _StarttripsState extends ConsumerState<Starttrips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('startTrip'.tr()),
        centerTitle: false,
      ),
      body: SafeArea(
          child: RefreshIndicator.adaptive(
              child: ref.watch(tripsListProvider).when(
                  data: (data) {
                    var dataList = data.data
                        ?.where((element) =>
                            element.weight != null && element.tripStart == null)
                        .toList();
                    return ListView(
                      children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dataList?.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return tripRequestLayout(dataList?[index]);
                            })
                      ],
                    );
                  },
                  error: (e, s) => Container(),
                  loading: () => const CupertinoActivityIndicator()),
              onRefresh: () {
                return Future(() {
                  ref.invalidate(tripsListProvider);
                });
              })),
    );
  }

  tripRequestLayout(Datum? dataList) => Container(
        margin: Pad(all: 10),
        decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.primaryColorDriver),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const Pad(all: 10),
          child: ColumnSuper(alignment: Alignment.center, children: [
            RowSuper(fill: true, alignment: Alignment.centerRight, children: [
              Padding(
                padding: Pad(all: 10),
                child: Text(
                  dataList!.tripId == null
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
                                      "tripDetails".tr(),
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
                                        'Trip ID'.tr(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: ColorConstants
                                                .primaryColorDriver,
                                            fontSize: Adaptive.sp(14),
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        '${dataList.tripId ?? "--"}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: ColorConstants
                                                .primaryColorDriver,
                                            fontSize: Adaptive.sp(14),
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RowSuper(fill: true, children: [
                                      Text(
                                        'Truck number'.tr(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color:
                                                ColorConstants.primaryColorWSP,
                                            fontSize: Adaptive.sp(14),
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        '${dataList.truckNumber ?? "--"}',
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
                                        'transporterName'.tr(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: ColorConstants
                                                .primaryColorDriver,
                                            fontSize: Adaptive.sp(14),
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        '${dataList.transporterName ?? "--"}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: ColorConstants
                                                .primaryColorDriver,
                                            fontSize: Adaptive.sp(14),
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RowSuper(fill: true, children: [
                                      Text(
                                        'transporterPhone'.tr(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: ColorConstants
                                                .primaryColorDriver,
                                            fontSize: Adaptive.sp(14),
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        '${dataList.transporterPhone ?? "--"}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: ColorConstants
                                                .primaryColorDriver,
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
                                            color: ColorConstants
                                                .primaryColorDriver,
                                            fontSize: Adaptive.sp(14),
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text.rich(
                                          textAlign: TextAlign.end,
                                          TextSpan(
                                            text: '${dataList.userName}',
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorDriver,
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
                                                    .primaryColorDriver,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${dataList.userPhone}',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorDriver,
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
                                                    .primaryColorDriver,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${currencyFormat.format(num.parse("${dataList.rate ?? 0}"))} / perQtl'
                                                .tr(),
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorDriver,
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
                                                    .primaryColorDriver,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${dataList.weight ?? "pending".tr()}',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorDriver,
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
                                                    .primaryColorDriver,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${dataList.noOfBags ?? "pending".tr()}',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorDriver,
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
                                                    .primaryColorDriver,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${dataList.recevingWeight ?? "pending".tr()}',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorDriver,
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
                                                    .primaryColorDriver,
                                                fontSize: Adaptive.sp(14),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${dataList.recevingBags ?? "pending".tr()}',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryColorDriver,
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
                                                    .primaryColorDriver,
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
                                                    .primaryColorDriver,
                                              ),
                                            ),
                                          )
                                        ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //imageLayout(dataList),
                                    Divider(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: Text(
                    'viewDetails'.tr(),
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
                    color: ColorConstants.primaryColorDriver,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              )),
              Expanded(
                  child: Text(
                '${dataList.tripDate ?? ""}',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: ColorConstants.primaryColorDriver,
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
                    color: ColorConstants.primaryColorDriver,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              )),
              Expanded(
                  child: Text(
                ' ${dataList?.fromAddress}',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: ColorConstants.primaryColorDriver,
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
                    color: ColorConstants.primaryColorDriver,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              )),
              Expanded(
                  child: Text(
                ' ${dataList?.toAddress}',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: ColorConstants.primaryColorDriver,
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
                    color: ColorConstants.primaryColorDriver,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              ),
              Text(
                '${dataList?.commodity}',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: ColorConstants.primaryColorDriver,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            // RowSuper(fill: true, children: [
            //   Text(
            //     'vehicleNumber'.tr(),
            //     textAlign: TextAlign.start,
            //     style: TextStyle(
            //         color: ColorConstants.primaryColorDriver,
            //         fontSize: Adaptive.sp(14),
            //         fontWeight: FontWeight.w800),
            //   ),
            //   Text(
            //     '${dataList.nim ?? "--"}',
            //     textAlign: TextAlign.end,
            //     style: TextStyle(
            //         color: ColorConstants.primaryColorDriver,
            //         fontSize: Adaptive.sp(14),
            //         fontWeight: FontWeight.w800),
            //   ),
            // ]),
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

  actionLayout(Datum? dataList) {
    return dataList?.tripEnd != null && dataList?.tripStart != null
        ? Text(
            'tripComplete'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: dataList?.status?.toInt() == 0
                    ? Colors.red
                    : ColorConstants.primaryColorDriver,
                fontSize: Adaptive.sp(14),
                fontWeight: FontWeight.w800),
          )
        : dataList?.weight == null
            ? Text(
                'tripStartPending'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: dataList?.status?.toInt() == 0
                        ? Colors.red
                        : ColorConstants.primaryColorDriver,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              )
            : dataList?.weight != null && dataList?.tripStart != null
                ? (dataList?.inOutTypes ?? "").toLowerCase() == "in"
                    ? (dataList?.paymentTo.toString() == "1" &&
                            dataList?.tripStart != null)
                        ? AnimatedButton(
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
                            onTap: () async {
                              // try {
                              //   showBarModalBottomSheet(
                              //       context: context,
                              //       builder: (context) => Consumer(
                              //           builder:
                              //               (context, ref, child) => SafeArea(
                              //                       child: Padding(
                              //                     padding: const Pad(all: 10),
                              //                     child: Form(
                              //                         key: form,
                              //                         child: ListView(
                              //                           children: [
                              //                             TextFormField(
                              //                               controller:
                              //                                   bagsController,
                              //                               keyboardType:
                              //                                   TextInputType
                              //                                       .text,
                              //                               validator: (value) {
                              //                                 if (value ==
                              //                                         null ||
                              //                                     value
                              //                                         .isEmpty) {
                              //                                   return 'inputBags'
                              //                                       .tr();
                              //                                 }
                              //                                 return null;
                              //                               },
                              //                               decoration: InputDecoration(
                              //                                   label: Text(
                              //                                       'inputBags'
                              //                                           .tr()),
                              //                                   contentPadding:
                              //                                       const Pad(
                              //                                           top: 0,
                              //                                           bottom:
                              //                                               0,
                              //                                           left:
                              //                                               10),
                              //                                   border: OutlineInputBorder(
                              //                                       borderRadius:
                              //                                           BorderRadius.circular(
                              //                                               10)),
                              //                                   enabledBorder:
                              //                                       OutlineInputBorder(
                              //                                           borderRadius:
                              //                                               BorderRadius.circular(10))),
                              //                             ),
                              //                             const SizedBox(
                              //                               height: 10,
                              //                             ),
                              //                             TextFormField(
                              //                               controller:
                              //                                   weightController,
                              //                               keyboardType:
                              //                                   TextInputType
                              //                                       .text,
                              //                               validator: (value) {
                              //                                 if (value ==
                              //                                         null ||
                              //                                     value
                              //                                         .isEmpty) {
                              //                                   return 'enterRecevingBags'
                              //                                       .tr();
                              //                                 }
                              //                                 return null;
                              //                               },
                              //                               decoration: InputDecoration(
                              //                                   label: Text(
                              //                                       'enterRecevingBags'
                              //                                           .tr()),
                              //                                   contentPadding:
                              //                                       const Pad(
                              //                                           top: 0,
                              //                                           bottom:
                              //                                               0,
                              //                                           left:
                              //                                               10),
                              //                                   border: OutlineInputBorder(
                              //                                       borderRadius:
                              //                                           BorderRadius.circular(
                              //                                               10)),
                              //                                   enabledBorder: OutlineInputBorder(
                              //                                       borderRadius:
                              //                                           BorderRadius.circular(
                              //                                               10))),
                              //                             ),
                              //                             const SizedBox(
                              //                               height: 10,
                              //                             ),
                              //                             TextFormField(
                              //                               controller:
                              //                                   paotiController,
                              //                               keyboardType:
                              //                                   TextInputType
                              //                                       .text,
                              //                               decoration: InputDecoration(
                              //                                   label: Text(
                              //                                       'enterPaotiNumber'
                              //                                           .tr()),
                              //                                   contentPadding:
                              //                                       const Pad(
                              //                                           top: 0,
                              //                                           bottom:
                              //                                               0,
                              //                                           left:
                              //                                               10),
                              //                                   border: OutlineInputBorder(
                              //                                       borderRadius:
                              //                                           BorderRadius.circular(
                              //                                               10)),
                              //                                   enabledBorder: OutlineInputBorder(
                              //                                       borderRadius:
                              //                                           BorderRadius.circular(
                              //                                               10))),
                              //                             ),
                              //                             const SizedBox(
                              //                               height: 10,
                              //                             ),
                              //                             DottedBorder(
                              //                                 borderType:
                              //                                     BorderType
                              //                                         .RRect,
                              //                                 dashPattern: const [
                              //                                   5,
                              //                                   5,
                              //                                   5,
                              //                                   5
                              //                                 ],
                              //                                 color: ColorConstants
                              //                                     .primaryColorDriver,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const Pad(
                              //                                           all:
                              //                                               20),
                              //                                   child: Center(
                              //                                     child: ref.watch(
                              //                                                 kantaImage) !=
                              //                                             null
                              //                                         ? Stack(
                              //                                             children: [
                              //                                               Image.file(ref.watch(kantaImage) ??
                              //                                                   File('')),
                              //                                               Container(
                              //                                                 decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle),
                              //                                                 child: IconButton(
                              //                                                     onPressed: () {
                              //                                                       ref.invalidate(kantaImage);
                              //                                                     },
                              //                                                     icon: const Icon(
                              //                                                       Icons.close,
                              //                                                       color: Colors.white,
                              //                                                     )),
                              //                                               )
                              //                                             ],
                              //                                           )
                              //                                         : InkWell(
                              //                                             child:
                              //                                                 ColumnSuper(children: [
                              //                                               const Icon(
                              //                                                 Icons.cloud_upload,
                              //                                                 color: ColorConstants.primaryColorDriver,
                              //                                               ),
                              //                                               const SizedBox(
                              //                                                 height: 5,
                              //                                               ),
                              //                                               Text(
                              //                                                 "selectKanta".tr(),
                              //                                                 textAlign: TextAlign.center,
                              //                                                 style: TextStyle(color: ColorConstants.primaryColorDriver, fontWeight: FontWeight.bold, fontSize: Adaptive.sp(16)),
                              //                                               ),
                              //                                               const SizedBox(
                              //                                                 height: 5,
                              //                                               ),
                              //                                               Text(
                              //                                                 "uploadDocumentImage".tr(),
                              //                                                 textAlign: TextAlign.center,
                              //                                                 style: TextStyle(color: ColorConstants.primaryColorDriver, fontWeight: FontWeight.w700, fontSize: Adaptive.sp(13)),
                              //                                               )
                              //                                             ]),
                              //                                             onTap:
                              //                                                 () async {
                              //                                               imagePicker.pickImage(source: ImageSource.camera).then((file) {
                              //                                                 if (file != null) {
                              //                                                   ref.watch(kantaImage.notifier).state = File(file.path);
                              //                                                 }
                              //                                               });
                              //                                             },
                              //                                           ),
                              //                                   ),
                              //                                 )),
                              //                             const SizedBox(
                              //                               height: 10,
                              //                             ),
                              //                             DottedBorder(
                              //                                 borderType:
                              //                                     BorderType
                              //                                         .RRect,
                              //                                 dashPattern: const [
                              //                                   5,
                              //                                   5,
                              //                                   5,
                              //                                   5
                              //                                 ],
                              //                                 color: ColorConstants
                              //                                     .primaryColorDriver,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const Pad(
                              //                                           all:
                              //                                               20),
                              //                                   child: Center(
                              //                                     child: ref.watch(
                              //                                                 qualityImage) !=
                              //                                             null
                              //                                         ? Stack(
                              //                                             children: [
                              //                                               Image.file(ref.watch(qualityImage) ??
                              //                                                   File('')),
                              //                                               Container(
                              //                                                 decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle),
                              //                                                 child: IconButton(
                              //                                                     onPressed: () {
                              //                                                       ref.invalidate(qualityImage);
                              //                                                     },
                              //                                                     icon: const Icon(
                              //                                                       Icons.close,
                              //                                                       color: Colors.white,
                              //                                                     )),
                              //                                               )
                              //                                             ],
                              //                                           )
                              //                                         : InkWell(
                              //                                             child:
                              //                                                 ColumnSuper(children: [
                              //                                               const Icon(
                              //                                                 Icons.cloud_upload,
                              //                                                 color: ColorConstants.primaryColorDriver,
                              //                                               ),
                              //                                               const SizedBox(
                              //                                                 height: 5,
                              //                                               ),
                              //                                               Text(
                              //                                                 "selectQualityImage".tr(),
                              //                                                 textAlign: TextAlign.center,
                              //                                                 style: TextStyle(color: ColorConstants.primaryColorDriver, fontWeight: FontWeight.bold, fontSize: Adaptive.sp(16)),
                              //                                               ),
                              //                                               const SizedBox(
                              //                                                 height: 5,
                              //                                               ),
                              //                                               Text(
                              //                                                 "uploadDocumentImage".tr(),
                              //                                                 textAlign: TextAlign.center,
                              //                                                 style: TextStyle(color: ColorConstants.primaryColorDriver, fontWeight: FontWeight.w700, fontSize: Adaptive.sp(13)),
                              //                                               )
                              //                                             ]),
                              //                                             onTap:
                              //                                                 () async {
                              //                                               imagePicker.pickImage(source: ImageSource.camera).then((file) {
                              //                                                 if (file != null) {
                              //                                                   ref.watch(qualityImage.notifier).state = File(file.path);
                              //                                                 }
                              //                                               });
                              //                                             },
                              //                                           ),
                              //                                   ),
                              //                                 )),
                              //                             const SizedBox(
                              //                               height: 10,
                              //                             ),
                              //                             DottedBorder(
                              //                                 borderType:
                              //                                     BorderType
                              //                                         .RRect,
                              //                                 dashPattern: const [
                              //                                   5,
                              //                                   5,
                              //                                   5,
                              //                                   5
                              //                                 ],
                              //                                 color: ColorConstants
                              //                                     .primaryColorDriver,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const Pad(
                              //                                           all:
                              //                                               20),
                              //                                   child: Center(
                              //                                     child: ref.watch(
                              //                                                 paotiImage) !=
                              //                                             null
                              //                                         ? Stack(
                              //                                             children: [
                              //                                               Image.file(ref.watch(paotiImage) ??
                              //                                                   File('')),
                              //                                               Container(
                              //                                                 decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle),
                              //                                                 child: IconButton(
                              //                                                     onPressed: () {
                              //                                                       ref.invalidate(qualityImage);
                              //                                                     },
                              //                                                     icon: const Icon(
                              //                                                       Icons.close,
                              //                                                       color: Colors.white,
                              //                                                     )),
                              //                                               )
                              //                                             ],
                              //                                           )
                              //                                         : InkWell(
                              //                                             child:
                              //                                                 ColumnSuper(children: [
                              //                                               const Icon(
                              //                                                 Icons.cloud_upload,
                              //                                                 color: ColorConstants.primaryColorDriver,
                              //                                               ),
                              //                                               const SizedBox(
                              //                                                 height: 5,
                              //                                               ),
                              //                                               Text(
                              //                                                 "selectPaotiImage".tr(),
                              //                                                 textAlign: TextAlign.center,
                              //                                                 style: TextStyle(color: ColorConstants.primaryColorDriver, fontWeight: FontWeight.bold, fontSize: Adaptive.sp(16)),
                              //                                               ),
                              //                                               const SizedBox(
                              //                                                 height: 5,
                              //                                               ),
                              //                                               Text(
                              //                                                 "uploadDocumentImage".tr(),
                              //                                                 textAlign: TextAlign.center,
                              //                                                 style: TextStyle(color: ColorConstants.primaryColorDriver, fontWeight: FontWeight.w700, fontSize: Adaptive.sp(13)),
                              //                                               )
                              //                                             ]),
                              //                                             onTap:
                              //                                                 () async {
                              //                                               imagePicker.pickImage(source: ImageSource.camera).then((file) {
                              //                                                 if (file != null) {
                              //                                                   ref.watch(paotiImage.notifier).state = File(file.path);
                              //                                                 }
                              //                                               });
                              //                                             },
                              //                                           ),
                              //                                   ),
                              //                                 )),
                              //                             const SizedBox(
                              //                               height: 10,
                              //                             ),
                              //                             AnimatedButton(
                              //                               height: 35,
                              //                               color: ColorConstants
                              //                                   .primaryColorDriver,
                              //                               width: MediaQuery.of(
                              //                                           context)
                              //                                       .size
                              //                                       .width /
                              //                                   1.2,
                              //                               isOutline: true,
                              //                               isMultiColor: true,
                              //                               colors: [
                              //                                 ColorConstants
                              //                                     .primaryColorDriver,
                              //                                 ColorConstants
                              //                                     .primaryColorDriver,
                              //                               ],
                              //                               borderWidth: 1,
                              //                               child: Text(
                              //                                 "submit".tr(),
                              //                               ),
                              //                               onTap: () async {
                              //                                 ref.watch(goRouterProvider).goNamed(
                              //                                     RoutesStrings
                              //                                         .paotiEndTrip,
                              //                                     extra:
                              //                                         dataList);
                              //                               },
                              //                             )
                              //                           ],
                              //                         )),
                              //                   ))));
                              // } catch (e, s) {
                              //   print(s);
                              // }
                              ref.watch(goRouterProvider).goNamed(
                                  RoutesStrings.paotiEndTrip,
                                  extra: dataList);
                            },
                            child: Text(
                              "tripEnd".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Adaptive.sp(14),
                                  fontWeight: FontWeight.w800),
                            ),
                          )
                        : Text(
                            'tripEndPending'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: dataList?.status?.toInt() == 0
                                    ? Colors.red
                                    : ColorConstants.primaryColorDriver,
                                fontSize: Adaptive.sp(14),
                                fontWeight: FontWeight.w800),
                          )
                    : AnimatedButton(
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
                        onTap: () async {
                          // try {
                          //   showBarModalBottomSheet(
                          //       context: context,
                          //       builder: (context) => Consumer(
                          //           builder: (context, ref, child) => SafeArea(
                          //                   child: Padding(
                          //                 padding: const Pad(all: 10),
                          //                 child: Form(
                          //                     key: form,
                          //                     child: ListView(
                          //                       children: [
                          //                         TextFormField(
                          //                           controller: bagsController,
                          //                           keyboardType:
                          //                               TextInputType.text,
                          //                           validator: (value) {
                          //                             if (value == null ||
                          //                                 value.isEmpty) {
                          //                               return 'inputBags'.tr();
                          //                             }
                          //                             return null;
                          //                           },
                          //                           decoration: InputDecoration(
                          //                               label: Text(
                          //                                   'inputBags'.tr()),
                          //                               contentPadding:
                          //                                   const Pad(
                          //                                       top: 0,
                          //                                       bottom: 0,
                          //                                       left: 10),
                          //                               border: OutlineInputBorder(
                          //                                   borderRadius:
                          //                                       BorderRadius
                          //                                           .circular(
                          //                                               10)),
                          //                               enabledBorder:
                          //                                   OutlineInputBorder(
                          //                                       borderRadius:
                          //                                           BorderRadius
                          //                                               .circular(
                          //                                                   10))),
                          //                         ),
                          //                         const SizedBox(
                          //                           height: 10,
                          //                         ),
                          //                         TextFormField(
                          //                           controller:
                          //                               weightController,
                          //                           keyboardType:
                          //                               TextInputType.text,
                          //                           validator: (value) {
                          //                             if (value == null ||
                          //                                 value.isEmpty) {
                          //                               return 'enterRecevingBags'
                          //                                   .tr();
                          //                             }
                          //                             return null;
                          //                           },
                          //                           decoration: InputDecoration(
                          //                               label: Text(
                          //                                   'enterRecevingBags'
                          //                                       .tr()),
                          //                               contentPadding:
                          //                                   const Pad(
                          //                                       top: 0,
                          //                                       bottom: 0,
                          //                                       left: 10),
                          //                               border: OutlineInputBorder(
                          //                                   borderRadius:
                          //                                       BorderRadius
                          //                                           .circular(
                          //                                               10)),
                          //                               enabledBorder:
                          //                                   OutlineInputBorder(
                          //                                       borderRadius:
                          //                                           BorderRadius
                          //                                               .circular(
                          //                                                   10))),
                          //                         ),
                          //                         const SizedBox(
                          //                           height: 10,
                          //                         ),
                          //                         TextFormField(
                          //                           controller: paotiController,
                          //                           keyboardType:
                          //                               TextInputType.text,
                          //                           decoration: InputDecoration(
                          //                               label: Text(
                          //                                   'enterPaotiNumber'
                          //                                       .tr()),
                          //                               contentPadding:
                          //                                   const Pad(
                          //                                       top: 0,
                          //                                       bottom: 0,
                          //                                       left: 10),
                          //                               border: OutlineInputBorder(
                          //                                   borderRadius:
                          //                                       BorderRadius
                          //                                           .circular(
                          //                                               10)),
                          //                               enabledBorder:
                          //                                   OutlineInputBorder(
                          //                                       borderRadius:
                          //                                           BorderRadius
                          //                                               .circular(
                          //                                                   10))),
                          //                         ),
                          //                         const SizedBox(
                          //                           height: 10,
                          //                         ),
                          //                         DottedBorder(
                          //                             borderType:
                          //                                 BorderType.RRect,
                          //                             dashPattern: const [
                          //                               5,
                          //                               5,
                          //                               5,
                          //                               5
                          //                             ],
                          //                             color: ColorConstants
                          //                                 .primaryColorDriver,
                          //                             child: Padding(
                          //                               padding:
                          //                                   const Pad(all: 20),
                          //                               child: Center(
                          //                                 child: ref.watch(
                          //                                             kantaImage) !=
                          //                                         null
                          //                                     ? Stack(
                          //                                         children: [
                          //                                           Image.file(ref.watch(
                          //                                                   kantaImage) ??
                          //                                               File(
                          //                                                   '')),
                          //                                           Container(
                          //                                             decoration: BoxDecoration(
                          //                                                 color: Colors.black.withOpacity(
                          //                                                     0.6),
                          //                                                 shape:
                          //                                                     BoxShape.circle),
                          //                                             child: IconButton(
                          //                                                 onPressed: () {
                          //                                                   ref.invalidate(kantaImage);
                          //                                                 },
                          //                                                 icon: const Icon(
                          //                                                   Icons.close,
                          //                                                   color:
                          //                                                       Colors.white,
                          //                                                 )),
                          //                                           )
                          //                                         ],
                          //                                       )
                          //                                     : InkWell(
                          //                                         child: ColumnSuper(
                          //                                             children: [
                          //                                               const Icon(
                          //                                                 Icons
                          //                                                     .cloud_upload,
                          //                                                 color:
                          //                                                     ColorConstants.primaryColorDriver,
                          //                                               ),
                          //                                               const SizedBox(
                          //                                                 height:
                          //                                                     5,
                          //                                               ),
                          //                                               Text(
                          //                                                 "selectKanta"
                          //                                                     .tr(),
                          //                                                 textAlign:
                          //                                                     TextAlign.center,
                          //                                                 style: TextStyle(
                          //                                                     color: ColorConstants.primaryColorDriver,
                          //                                                     fontWeight: FontWeight.bold,
                          //                                                     fontSize: Adaptive.sp(16)),
                          //                                               ),
                          //                                               const SizedBox(
                          //                                                 height:
                          //                                                     5,
                          //                                               ),
                          //                                               Text(
                          //                                                 "uploadDocumentImage"
                          //                                                     .tr(),
                          //                                                 textAlign:
                          //                                                     TextAlign.center,
                          //                                                 style: TextStyle(
                          //                                                     color: ColorConstants.primaryColorDriver,
                          //                                                     fontWeight: FontWeight.w700,
                          //                                                     fontSize: Adaptive.sp(13)),
                          //                                               )
                          //                                             ]),
                          //                                         onTap:
                          //                                             () async {
                          //                                           imagePicker
                          //                                               .pickImage(
                          //                                                   source: ImageSource
                          //                                                       .camera)
                          //                                               .then(
                          //                                                   (file) {
                          //                                             if (file !=
                          //                                                 null) {
                          //                                               ref.watch(kantaImage.notifier).state =
                          //                                                   File(file.path);
                          //                                             }
                          //                                           });
                          //                                         },
                          //                                       ),
                          //                               ),
                          //                             )),
                          //                         const SizedBox(
                          //                           height: 10,
                          //                         ),
                          //                         DottedBorder(
                          //                             borderType:
                          //                                 BorderType.RRect,
                          //                             dashPattern: const [
                          //                               5,
                          //                               5,
                          //                               5,
                          //                               5
                          //                             ],
                          //                             color: ColorConstants
                          //                                 .primaryColorDriver,
                          //                             child: Padding(
                          //                               padding:
                          //                                   const Pad(all: 20),
                          //                               child: Center(
                          //                                 child: ref.watch(
                          //                                             qualityImage) !=
                          //                                         null
                          //                                     ? Stack(
                          //                                         children: [
                          //                                           Image.file(ref.watch(
                          //                                                   qualityImage) ??
                          //                                               File(
                          //                                                   '')),
                          //                                           Container(
                          //                                             decoration: BoxDecoration(
                          //                                                 color: Colors.black.withOpacity(
                          //                                                     0.6),
                          //                                                 shape:
                          //                                                     BoxShape.circle),
                          //                                             child: IconButton(
                          //                                                 onPressed: () {
                          //                                                   ref.invalidate(qualityImage);
                          //                                                 },
                          //                                                 icon: const Icon(
                          //                                                   Icons.close,
                          //                                                   color:
                          //                                                       Colors.white,
                          //                                                 )),
                          //                                           )
                          //                                         ],
                          //                                       )
                          //                                     : InkWell(
                          //                                         child: ColumnSuper(
                          //                                             children: [
                          //                                               const Icon(
                          //                                                 Icons
                          //                                                     .cloud_upload,
                          //                                                 color:
                          //                                                     ColorConstants.primaryColorDriver,
                          //                                               ),
                          //                                               const SizedBox(
                          //                                                 height:
                          //                                                     5,
                          //                                               ),
                          //                                               Text(
                          //                                                 "selectQualityImage"
                          //                                                     .tr(),
                          //                                                 textAlign:
                          //                                                     TextAlign.center,
                          //                                                 style: TextStyle(
                          //                                                     color: ColorConstants.primaryColorDriver,
                          //                                                     fontWeight: FontWeight.bold,
                          //                                                     fontSize: Adaptive.sp(16)),
                          //                                               ),
                          //                                               const SizedBox(
                          //                                                 height:
                          //                                                     5,
                          //                                               ),
                          //                                               Text(
                          //                                                 "uploadDocumentImage"
                          //                                                     .tr(),
                          //                                                 textAlign:
                          //                                                     TextAlign.center,
                          //                                                 style: TextStyle(
                          //                                                     color: ColorConstants.primaryColorDriver,
                          //                                                     fontWeight: FontWeight.w700,
                          //                                                     fontSize: Adaptive.sp(13)),
                          //                                               )
                          //                                             ]),
                          //                                         onTap:
                          //                                             () async {
                          //                                           imagePicker
                          //                                               .pickImage(
                          //                                                   source: ImageSource
                          //                                                       .camera)
                          //                                               .then(
                          //                                                   (file) {
                          //                                             if (file !=
                          //                                                 null) {
                          //                                               ref.watch(qualityImage.notifier).state =
                          //                                                   File(file.path);
                          //                                             }
                          //                                           });
                          //                                         },
                          //                                       ),
                          //                               ),
                          //                             )),
                          //                         DottedBorder(
                          //                             borderType:
                          //                                 BorderType.RRect,
                          //                             dashPattern: const [
                          //                               5,
                          //                               5,
                          //                               5,
                          //                               5
                          //                             ],
                          //                             color: ColorConstants
                          //                                 .primaryColorDriver,
                          //                             child: Padding(
                          //                               padding:
                          //                                   const Pad(all: 20),
                          //                               child: Center(
                          //                                 child: ref.watch(
                          //                                             paotiImage) !=
                          //                                         null
                          //                                     ? Stack(
                          //                                         children: [
                          //                                           Image.file(ref.watch(
                          //                                                   paotiImage) ??
                          //                                               File(
                          //                                                   '')),
                          //                                           Container(
                          //                                             decoration: BoxDecoration(
                          //                                                 color: Colors.black.withOpacity(
                          //                                                     0.6),
                          //                                                 shape:
                          //                                                     BoxShape.circle),
                          //                                             child: IconButton(
                          //                                                 onPressed: () {
                          //                                                   ref.invalidate(qualityImage);
                          //                                                 },
                          //                                                 icon: const Icon(
                          //                                                   Icons.close,
                          //                                                   color:
                          //                                                       Colors.white,
                          //                                                 )),
                          //                                           )
                          //                                         ],
                          //                                       )
                          //                                     : InkWell(
                          //                                         child: ColumnSuper(
                          //                                             children: [
                          //                                               const Icon(
                          //                                                 Icons
                          //                                                     .cloud_upload,
                          //                                                 color:
                          //                                                     ColorConstants.primaryColorDriver,
                          //                                               ),
                          //                                               const SizedBox(
                          //                                                 height:
                          //                                                     5,
                          //                                               ),
                          //                                               Text(
                          //                                                 "selectPaotiImage"
                          //                                                     .tr(),
                          //                                                 textAlign:
                          //                                                     TextAlign.center,
                          //                                                 style: TextStyle(
                          //                                                     color: ColorConstants.primaryColorDriver,
                          //                                                     fontWeight: FontWeight.bold,
                          //                                                     fontSize: Adaptive.sp(16)),
                          //                                               ),
                          //                                               const SizedBox(
                          //                                                 height:
                          //                                                     5,
                          //                                               ),
                          //                                               Text(
                          //                                                 "uploadDocumentImage"
                          //                                                     .tr(),
                          //                                                 textAlign:
                          //                                                     TextAlign.center,
                          //                                                 style: TextStyle(
                          //                                                     color: ColorConstants.primaryColorDriver,
                          //                                                     fontWeight: FontWeight.w700,
                          //                                                     fontSize: Adaptive.sp(13)),
                          //                                               )
                          //                                             ]),
                          //                                         onTap:
                          //                                             () async {
                          //                                           imagePicker
                          //                                               .pickImage(
                          //                                                   source: ImageSource
                          //                                                       .camera)
                          //                                               .then(
                          //                                                   (file) {
                          //                                             if (file !=
                          //                                                 null) {
                          //                                               ref.watch(paotiImage.notifier).state =
                          //                                                   File(file.path);
                          //                                             }
                          //                                           });
                          //                                         },
                          //                                       ),
                          //                               ),
                          //                             )),
                          //                         AnimatedButton(
                          //                           height: 35,
                          //                           color: ColorConstants
                          //                               .primaryColorDriver,
                          //                           width:
                          //                               MediaQuery.of(context)
                          //                                       .size
                          //                                       .width /
                          //                                   1.2,
                          //                           isOutline: true,
                          //                           isMultiColor: true,
                          //                           colors: [
                          //                             ColorConstants
                          //                                 .primaryColorDriver,
                          //                             ColorConstants
                          //                                 .primaryColorDriver,
                          //                           ],
                          //                           borderWidth: 1,
                          //                           child: Text(
                          //                             "submit".tr(),
                          //                           ),
                          //                           onTap: () async {
                          //                             if (form.currentState!
                          //                                 .validate()) {
                          //                               if (ref.watch(
                          //                                       kantaImage) ==
                          //                                   null) {
                          //                                 errorToast(
                          //                                     context,
                          //                                     "selectKanta"
                          //                                         .tr());
                          //                               }
                          //                               if (ref.watch(
                          //                                       qualityImage) ==
                          //                                   null) {
                          //                                 errorToast(
                          //                                     context,
                          //                                     'selectQualityImage'
                          //                                         .tr());
                          //                               } else {
                          //                                 hideLoader(context);
                          //
                          //                                 final bytes = File(ref
                          //                                             .watch(
                          //                                                 kantaImage)
                          //                                             ?.path ??
                          //                                         "")
                          //                                     .readAsBytesSync();
                          //                                 String img64 =
                          //                                     base64Encode(
                          //                                         bytes);
                          //
                          //                                 final bytes2 = File(ref
                          //                                             .watch(
                          //                                                 qualityImage)
                          //                                             ?.path ??
                          //                                         "")
                          //                                     .readAsBytesSync();
                          //                                 String img642 =
                          //                                     base64Encode(
                          //                                         bytes2);
                          //                                 ref
                          //                                     .watch(endTripProvider(
                          //                                             tripRequestId:
                          //                                                 '${dataList?.id ?? 0}',
                          //                                             kantaWeight:
                          //                                                 '${weightController.text.toString()}',
                          //                                             bags:
                          //                                                 "${bagsController.text.toString()}",
                          //                                             kantaImage:
                          //                                                 img64,
                          //                                             qualityImage:
                          //                                                 img642,
                          //                                             paotiImage:
                          //                                                 base64Encode(File(ref.watch(paotiImage)?.path ?? "")
                          //                                                     .readAsBytesSync()),
                          //                                             paotiNumber:
                          //                                                 paotiController
                          //                                                     .text)
                          //                                         .future)
                          //                                     .then((value) {
                          //                                   hideLoader(context);
                          //                                   if (value['status']
                          //                                           .toString() ==
                          //                                       "1") {
                          //                                     successToast(
                          //                                         context,
                          //                                         value[
                          //                                             'message']);
                          //                                     ref.invalidate(
                          //                                         tripsProvider);
                          //                                     ref.invalidate(
                          //                                         kantaImage);
                          //                                     ref.invalidate(
                          //                                         qualityImage);
                          //                                     bagsController
                          //                                         .clear();
                          //                                     weightController
                          //                                         .clear();
                          //                                     ref
                          //                                         .watch(
                          //                                             goRouterProvider)
                          //                                         .pop(context);
                          //                                   } else {
                          //                                     errorToast(
                          //                                         context,
                          //                                         value[
                          //                                             'message']);
                          //                                   }
                          //                                 }).onError((e, s) {
                          //                                   hideLoader(context);
                          //
                          //                                   errorToast(context,
                          //                                       e.toString());
                          //                                 });
                          //                               }
                          //                             }
                          //                           },
                          //                         )
                          //                       ],
                          //                     )),
                          //               ))));
                          // } catch (e, s) {
                          //   print(s);
                          // }
                          ref.watch(goRouterProvider).goNamed(
                              RoutesStrings.paotiEndTrip,
                              extra: dataList);
                        },
                        child: Text(
                          "tripEnd".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Adaptive.sp(14),
                              fontWeight: FontWeight.w800),
                        ),
                      )
                : dataList?.weight != null && dataList?.tripStart == null
                    ? (dataList?.paymentTo.toString() == "1" &&
                            dataList?.tripStart != null)
                        ? AnimatedButton(
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
                            onTap: () async {
                              ref.watch(goRouterProvider).goNamed(
                                  RoutesStrings.paotiEndTrip,
                                  extra: dataList);
                              // try {
                              //   showBarModalBottomSheet(
                              //       context: context,
                              //       builder: (context) => Consumer(
                              //           builder:
                              //               (context, ref, child) => SafeArea(
                              //                       child: Padding(
                              //                     padding: const Pad(all: 10),
                              //                     child: Form(
                              //                         key: form,
                              //                         child: ListView(
                              //                           children: [
                              //                             TextFormField(
                              //                               controller:
                              //                                   bagsController,
                              //                               keyboardType:
                              //                                   TextInputType
                              //                                       .text,
                              //                               validator: (value) {
                              //                                 if (value ==
                              //                                         null ||
                              //                                     value
                              //                                         .isEmpty) {
                              //                                   return 'inputBags'
                              //                                       .tr();
                              //                                 }
                              //                                 return null;
                              //                               },
                              //                               decoration: InputDecoration(
                              //                                   label: Text(
                              //                                       'inputBags'
                              //                                           .tr()),
                              //                                   contentPadding:
                              //                                       const Pad(
                              //                                           top: 0,
                              //                                           bottom:
                              //                                               0,
                              //                                           left:
                              //                                               10),
                              //                                   border: OutlineInputBorder(
                              //                                       borderRadius:
                              //                                           BorderRadius.circular(
                              //                                               10)),
                              //                                   enabledBorder:
                              //                                       OutlineInputBorder(
                              //                                           borderRadius:
                              //                                               BorderRadius.circular(10))),
                              //                             ),
                              //                             const SizedBox(
                              //                               height: 10,
                              //                             ),
                              //                             TextFormField(
                              //                               controller:
                              //                                   weightController,
                              //                               keyboardType:
                              //                                   TextInputType
                              //                                       .text,
                              //                               validator: (value) {
                              //                                 if (value ==
                              //                                         null ||
                              //                                     value
                              //                                         .isEmpty) {
                              //                                   return 'enterRecevingBags'
                              //                                       .tr();
                              //                                 }
                              //                                 return null;
                              //                               },
                              //                               decoration: InputDecoration(
                              //                                   label: Text(
                              //                                       'enterRecevingBags'
                              //                                           .tr()),
                              //                                   contentPadding:
                              //                                       const Pad(
                              //                                           top: 0,
                              //                                           bottom:
                              //                                               0,
                              //                                           left:
                              //                                               10),
                              //                                   border: OutlineInputBorder(
                              //                                       borderRadius:
                              //                                           BorderRadius.circular(
                              //                                               10)),
                              //                                   enabledBorder: OutlineInputBorder(
                              //                                       borderRadius:
                              //                                           BorderRadius.circular(
                              //                                               10))),
                              //                             ),
                              //                             const SizedBox(
                              //                               height: 10,
                              //                             ),
                              //                             DottedBorder(
                              //                                 borderType:
                              //                                     BorderType
                              //                                         .RRect,
                              //                                 dashPattern: const [
                              //                                   5,
                              //                                   5,
                              //                                   5,
                              //                                   5
                              //                                 ],
                              //                                 color: ColorConstants
                              //                                     .primaryColorDriver,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const Pad(
                              //                                           all:
                              //                                               20),
                              //                                   child: Center(
                              //                                     child: ref.watch(
                              //                                                 kantaImage) !=
                              //                                             null
                              //                                         ? Stack(
                              //                                             children: [
                              //                                               Image.file(ref.watch(kantaImage) ??
                              //                                                   File('')),
                              //                                               Container(
                              //                                                 decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle),
                              //                                                 child: IconButton(
                              //                                                     onPressed: () {
                              //                                                       ref.invalidate(kantaImage);
                              //                                                     },
                              //                                                     icon: const Icon(
                              //                                                       Icons.close,
                              //                                                       color: Colors.white,
                              //                                                     )),
                              //                                               )
                              //                                             ],
                              //                                           )
                              //                                         : InkWell(
                              //                                             child:
                              //                                                 ColumnSuper(children: [
                              //                                               const Icon(
                              //                                                 Icons.cloud_upload,
                              //                                                 color: ColorConstants.primaryColorDriver,
                              //                                               ),
                              //                                               const SizedBox(
                              //                                                 height: 5,
                              //                                               ),
                              //                                               Text(
                              //                                                 "selectKanta".tr(),
                              //                                                 textAlign: TextAlign.center,
                              //                                                 style: TextStyle(color: ColorConstants.primaryColorDriver, fontWeight: FontWeight.bold, fontSize: Adaptive.sp(16)),
                              //                                               ),
                              //                                               const SizedBox(
                              //                                                 height: 5,
                              //                                               ),
                              //                                               Text(
                              //                                                 "uploadDocumentImage".tr(),
                              //                                                 textAlign: TextAlign.center,
                              //                                                 style: TextStyle(color: ColorConstants.primaryColorDriver, fontWeight: FontWeight.w700, fontSize: Adaptive.sp(13)),
                              //                                               )
                              //                                             ]),
                              //                                             onTap:
                              //                                                 () async {
                              //                                               imagePicker.pickImage(source: ImageSource.camera).then((file) {
                              //                                                 if (file != null) {
                              //                                                   ref.watch(kantaImage.notifier).state = File(file.path);
                              //                                                 }
                              //                                               });
                              //                                             },
                              //                                           ),
                              //                                   ),
                              //                                 )),
                              //                             const SizedBox(
                              //                               height: 10,
                              //                             ),
                              //                             DottedBorder(
                              //                                 borderType:
                              //                                     BorderType
                              //                                         .RRect,
                              //                                 dashPattern: const [
                              //                                   5,
                              //                                   5,
                              //                                   5,
                              //                                   5
                              //                                 ],
                              //                                 color: ColorConstants
                              //                                     .primaryColorDriver,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const Pad(
                              //                                           all:
                              //                                               20),
                              //                                   child: Center(
                              //                                     child: ref.watch(
                              //                                                 qualityImage) !=
                              //                                             null
                              //                                         ? Stack(
                              //                                             children: [
                              //                                               Image.file(ref.watch(qualityImage) ??
                              //                                                   File('')),
                              //                                               Container(
                              //                                                 decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle),
                              //                                                 child: IconButton(
                              //                                                     onPressed: () {
                              //                                                       ref.invalidate(qualityImage);
                              //                                                     },
                              //                                                     icon: const Icon(
                              //                                                       Icons.close,
                              //                                                       color: Colors.white,
                              //                                                     )),
                              //                                               )
                              //                                             ],
                              //                                           )
                              //                                         : InkWell(
                              //                                             child:
                              //                                                 ColumnSuper(children: [
                              //                                               const Icon(
                              //                                                 Icons.cloud_upload,
                              //                                                 color: ColorConstants.primaryColorDriver,
                              //                                               ),
                              //                                               const SizedBox(
                              //                                                 height: 5,
                              //                                               ),
                              //                                               Text(
                              //                                                 "selectQualityImage".tr(),
                              //                                                 textAlign: TextAlign.center,
                              //                                                 style: TextStyle(color: ColorConstants.primaryColorDriver, fontWeight: FontWeight.bold, fontSize: Adaptive.sp(16)),
                              //                                               ),
                              //                                               const SizedBox(
                              //                                                 height: 5,
                              //                                               ),
                              //                                               Text(
                              //                                                 "uploadDocumentImage".tr(),
                              //                                                 textAlign: TextAlign.center,
                              //                                                 style: TextStyle(color: ColorConstants.primaryColorDriver, fontWeight: FontWeight.w700, fontSize: Adaptive.sp(13)),
                              //                                               )
                              //                                             ]),
                              //                                             onTap:
                              //                                                 () async {
                              //                                               imagePicker.pickImage(source: ImageSource.camera).then((file) {
                              //                                                 if (file != null) {
                              //                                                   ref.watch(qualityImage.notifier).state = File(file.path);
                              //                                                 }
                              //                                               });
                              //                                             },
                              //                                           ),
                              //                                   ),
                              //                                 )),
                              //                             AnimatedButton(
                              //                               height: 35,
                              //                               color: ColorConstants
                              //                                   .primaryColorDriver,
                              //                               width: MediaQuery.of(
                              //                                           context)
                              //                                       .size
                              //                                       .width /
                              //                                   1.2,
                              //                               isOutline: true,
                              //                               isMultiColor: true,
                              //                               colors: [
                              //                                 ColorConstants
                              //                                     .primaryColorDriver,
                              //                                 ColorConstants
                              //                                     .primaryColorDriver,
                              //                               ],
                              //                               borderWidth: 1,
                              //                               child: Text(
                              //                                 "submit".tr(),
                              //                               ),
                              //                               onTap: () async {
                              //                                 if (form
                              //                                     .currentState!
                              //                                     .validate()) {
                              //                                   if (ref.watch(
                              //                                           kantaImage) ==
                              //                                       null) {
                              //                                     errorToast(
                              //                                         context,
                              //                                         "selectKanta"
                              //                                             .tr());
                              //                                   }
                              //                                   if (ref.watch(
                              //                                           qualityImage) ==
                              //                                       null) {
                              //                                     errorToast(
                              //                                         context,
                              //                                         'selectQualityImage'
                              //                                             .tr());
                              //                                   } else {
                              //                                     hideLoader(
                              //                                         context);
                              //
                              //                                     final bytes = File(
                              //                                             ref.watch(kantaImage)?.path ??
                              //                                                 "")
                              //                                         .readAsBytesSync();
                              //                                     String img64 =
                              //                                         base64Encode(
                              //                                             bytes);
                              //
                              //                                     final bytes2 =
                              //                                         File(ref.watch(qualityImage)?.path ??
                              //                                                 "")
                              //                                             .readAsBytesSync();
                              //                                     String
                              //                                         img642 =
                              //                                         base64Encode(
                              //                                             bytes2);
                              //                                     ref
                              //                                         .watch(endTripProvider(
                              //                                                 tripRequestId:
                              //                                                     '${dataList?.id ?? 0}',
                              //                                                 kantaWeight:
                              //                                                     '${weightController.text.toString()}',
                              //                                                 bags:
                              //                                                     "${bagsController.text.toString()}",
                              //                                                 kantaImage:
                              //                                                     img64,
                              //                                                 qualityImage:
                              //                                                     img642)
                              //                                             .future)
                              //                                         .then(
                              //                                             (value) {
                              //                                       hideLoader(
                              //                                           context);
                              //                                       if (value['status']
                              //                                               .toString() ==
                              //                                           "1") {
                              //                                         successToast(
                              //                                             context,
                              //                                             value[
                              //                                                 'message']);
                              //                                         ref.invalidate(
                              //                                             tripsProvider);
                              //                                         ref.invalidate(
                              //                                             kantaImage);
                              //                                         ref.invalidate(
                              //                                             qualityImage);
                              //                                         bagsController
                              //                                             .clear();
                              //                                         weightController
                              //                                             .clear();
                              //                                         ref
                              //                                             .watch(
                              //                                                 goRouterProvider)
                              //                                             .pop(
                              //                                                 context);
                              //                                       } else {
                              //                                         errorToast(
                              //                                             context,
                              //                                             value[
                              //                                                 'message']);
                              //                                       }
                              //                                     }).onError((e,
                              //                                             s) {
                              //                                       hideLoader(
                              //                                           context);
                              //
                              //                                       errorToast(
                              //                                           context,
                              //                                           e.toString());
                              //                                     });
                              //                                   }
                              //                                 }
                              //                               },
                              //                             )
                              //                           ],
                              //                         )),
                              //                   ))));
                              // } catch (e, s) {
                              //   print(s);
                              // }
                            },
                            child: Text(
                              "tripEnd".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Adaptive.sp(14),
                                  fontWeight: FontWeight.w800),
                            ),
                          )
                        : Text(
                            'tripStartPendingTrans'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: dataList?.status?.toInt() == 0
                                    ? Colors.red
                                    : ColorConstants.primaryColorDriver,
                                fontSize: Adaptive.sp(14),
                                fontWeight: FontWeight.w800),
                          )
                    : const SizedBox();
    ;
  }
}
