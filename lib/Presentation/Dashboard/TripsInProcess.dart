import 'dart:convert';
import 'dart:io';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:button_animations/button_animations.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:transporter/Domain/Trips/TripsService.dart';

import '../../Data/Model/TripDataResponse.dart';
import '../../Data/Model/TruckDriverResponse.dart';
import '../Routes/routes.dart';
import '../Utils/Widgets/Widgets.dart';
import '../Utils/color_constants.dart';
import '../Utils/pdf/BiltyPdf.dart';
import 'Dashboard.dart';

class Tripsinprocess extends ConsumerStatefulWidget {
  const Tripsinprocess({super.key});

  @override
  ConsumerState<Tripsinprocess> createState() => _TripsinprocessState();
}

class _TripsinprocessState extends ConsumerState<Tripsinprocess> {
  var truckProvider = StateProvider<TruckDatum?>((ref) => null);
  var driverProvider = StateProvider<DriverDatum?>((ref) => null);
  final form = GlobalKey<FormState>();

  final bagsController = TextEditingController();
  final weightController = TextEditingController();
  final imagePicker = ImagePicker();
  var kantaImage = StateProvider<File?>((ref) => null);
  var qualityImage = StateProvider<File?>((ref) => null);
  final paotiController = TextEditingController();
  var paotiImage = StateProvider<File?>((ref) => null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips In process'),
      ),
      body: SafeArea(
          child: RefreshIndicator.adaptive(
              child: ListView(
                children: [
                  ref.watch(tripsListProvider).when(
                      data: (data) {
                        var dataList = data.data
                            ?.where((datum) =>
                                datum.weight == null ||
                                datum.tripStart == null ||
                                datum.tripEnd == null)
                            .toList();
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dataList?.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return tripRequestLayout(dataList![index]);
                            });
                      },
                      error: (e, s) => Container(),
                      loading: () => const CupertinoActivityIndicator())
                ],
              ),
              onRefresh: () {
                return Future(() {
                  ref.invalidate(tripsHistoryProvider);
                });
              })),
    );
  }

  tripRequestLayout(Datum dataList) => Container(
        margin: const Pad(all: 10),
        decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.primaryColorWSP),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const Pad(all: 10),
          child: ColumnSuper(alignment: Alignment.center, children: [
            RowSuper(fill: true, alignment: Alignment.centerRight, children: [
              Padding(
                padding: const Pad(all: 10),
                child: Text(
                  dataList.tripId == null
                      ? "--"
                      : '${'tripId'.tr()}: ${dataList.tripId.toString()}',
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
                                padding: const Pad(all: 10),
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
                                            dataList.weight == null
                                                ? 'provBilty'.tr()
                                                : "provBilty".tr(),
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
                                              child: const Icon(
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
                                    const Divider(
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
            const Divider(
              height: 2,
            ),
            const SizedBox(
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
            const SizedBox(
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
                ' ${dataList.fromAddress}',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              )),
            ]),
            const SizedBox(
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
                ' ${dataList.toAddress}',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: ColorConstants.primaryColorWSP,
                    fontSize: Adaptive.sp(14),
                    fontWeight: FontWeight.w800),
              )),
            ]),
            const SizedBox(
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
                '${dataList.commodity}',
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
            const Divider(),
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
                ? const SizedBox()
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
                          child: const Icon(
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
                    child: const Icon(
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
                    child: const Icon(
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
                    child: const Icon(
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
                    child: const Icon(
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
                    child: const Icon(
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
                ? const SizedBox()
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
                          child: const Icon(
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
                    child: const Icon(
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
                    child: const Icon(
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
                    child: const Icon(
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
                        terminal?.truckNumber ?? "--",
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
          itemAsString: (TruckDatum? u) => u?.truckNumber ?? "--",
          onChanged: (TruckDatum? data) =>
              ref.watch(truckProvider.notifier).state = data,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                contentPadding: const Pad(left: 10, bottom: 5, top: 5),
                hintText: 'selectTruck'.tr(),
                border: const OutlineInputBorder(
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
                        terminal?.driverName ?? "--",
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
          itemAsString: (DriverDatum? u) => u?.driverName ?? "--",
          onChanged: (DriverDatum? data) =>
              ref.watch(driverProvider.notifier).state = data,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                contentPadding: const Pad(left: 10, bottom: 5, top: 5),
                hintText: 'selectDriver'.tr(),
                border: const OutlineInputBorder(
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
            colors: const [
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
                            padding: const Pad(all: 10),
                            child: ColumnSuper(children: [
                              const SizedBox(
                                height: 10,
                              ),
                              truckSelection(
                                  ref, context, truckData.truckData ?? []),
                              const SizedBox(
                                height: 10,
                              ),
                              driverSelection(
                                  ref, context, truckData.driverData ?? []),
                              const SizedBox(
                                height: 10,
                              ),
                              AnimatedButton(
                                height: 35,
                                color: ColorConstants.primaryColorWSP,
                                width: MediaQuery.of(context).size.width / 1.2,
                                isOutline: true,
                                isMultiColor: true,
                                colors: const [
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
                colors: const [
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
                        colors: const [
                          ColorConstants.primaryColorDriver,
                          ColorConstants.primaryColorDriver,
                        ],
                        borderWidth: 1,
                        onTap: () async {
                          showBarModalBottomSheet(
                              context: context,
                              builder: (context) => Consumer(
                                  builder: (context, ref, child) => SafeArea(
                                          child: Padding(
                                        padding: const Pad(all: 10),
                                        child: Form(
                                            key: form,
                                            child: ListView(
                                              children: [
                                                TextFormField(
                                                  controller: bagsController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'inputBags'.tr();
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                      label: Text(
                                                          'inputBags'.tr()),
                                                      contentPadding: const Pad(
                                                          top: 0,
                                                          bottom: 0,
                                                          left: 10),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  controller: weightController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'enterRecevingBags'
                                                          .tr();
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                      label: Text(
                                                          'recievingWeight'
                                                              .tr()),
                                                      contentPadding: const Pad(
                                                          top: 0,
                                                          bottom: 0,
                                                          left: 10),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  controller: paotiController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                      label: Text(
                                                          'enterPaotiNumber'
                                                              .tr()),
                                                      contentPadding: const Pad(
                                                          top: 0,
                                                          bottom: 0,
                                                          left: 10),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                DottedBorder(
                                                    borderType:
                                                        BorderType.RRect,
                                                    dashPattern: const [
                                                      5,
                                                      5,
                                                      5,
                                                      5
                                                    ],
                                                    color: ColorConstants
                                                        .primaryColorDriver,
                                                    child: Padding(
                                                      padding:
                                                          const Pad(all: 20),
                                                      child: Center(
                                                        child: ref.watch(
                                                                    kantaImage) !=
                                                                null
                                                            ? Stack(
                                                                children: [
                                                                  Image.file(ref
                                                                          .watch(
                                                                              kantaImage) ??
                                                                      File('')),
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.6),
                                                                        shape: BoxShape
                                                                            .circle),
                                                                    child: IconButton(
                                                                        onPressed: () {
                                                                          ref.invalidate(
                                                                              kantaImage);
                                                                        },
                                                                        icon: const Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              Colors.white,
                                                                        )),
                                                                  )
                                                                ],
                                                              )
                                                            : InkWell(
                                                                child: ColumnSuper(
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .cloud_upload,
                                                                        color: ColorConstants
                                                                            .primaryColorDriver,
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "selectKanta"
                                                                            .tr(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color:
                                                                                ColorConstants.primaryColorDriver,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: Adaptive.sp(16)),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "uploadDocumentImage"
                                                                            .tr(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color:
                                                                                ColorConstants.primaryColorDriver,
                                                                            fontWeight: FontWeight.w700,
                                                                            fontSize: Adaptive.sp(13)),
                                                                      )
                                                                    ]),
                                                                onTap:
                                                                    () async {
                                                                  imagePicker
                                                                      .pickImage(
                                                                          source: ImageSource
                                                                              .camera)
                                                                      .then(
                                                                          (file) {
                                                                    if (file !=
                                                                        null) {
                                                                      ref.watch(kantaImage.notifier).state =
                                                                          File(file
                                                                              .path);
                                                                    }
                                                                  });
                                                                },
                                                              ),
                                                      ),
                                                    )),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                DottedBorder(
                                                    borderType:
                                                        BorderType.RRect,
                                                    dashPattern: const [
                                                      5,
                                                      5,
                                                      5,
                                                      5
                                                    ],
                                                    color: ColorConstants
                                                        .primaryColorDriver,
                                                    child: Padding(
                                                      padding:
                                                          const Pad(all: 20),
                                                      child: Center(
                                                        child: ref.watch(
                                                                    qualityImage) !=
                                                                null
                                                            ? Stack(
                                                                children: [
                                                                  Image.file(ref
                                                                          .watch(
                                                                              qualityImage) ??
                                                                      File('')),
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.6),
                                                                        shape: BoxShape
                                                                            .circle),
                                                                    child: IconButton(
                                                                        onPressed: () {
                                                                          ref.invalidate(
                                                                              qualityImage);
                                                                        },
                                                                        icon: const Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              Colors.white,
                                                                        )),
                                                                  )
                                                                ],
                                                              )
                                                            : InkWell(
                                                                child: ColumnSuper(
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .cloud_upload,
                                                                        color: ColorConstants
                                                                            .primaryColorDriver,
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "selectQualityImage"
                                                                            .tr(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color:
                                                                                ColorConstants.primaryColorDriver,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: Adaptive.sp(16)),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "uploadDocumentImage"
                                                                            .tr(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color:
                                                                                ColorConstants.primaryColorDriver,
                                                                            fontWeight: FontWeight.w700,
                                                                            fontSize: Adaptive.sp(13)),
                                                                      )
                                                                    ]),
                                                                onTap:
                                                                    () async {
                                                                  imagePicker
                                                                      .pickImage(
                                                                          source: ImageSource
                                                                              .camera)
                                                                      .then(
                                                                          (file) {
                                                                    if (file !=
                                                                        null) {
                                                                      ref.watch(qualityImage.notifier).state =
                                                                          File(file
                                                                              .path);
                                                                    }
                                                                  });
                                                                },
                                                              ),
                                                      ),
                                                    )),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                DottedBorder(
                                                    borderType:
                                                        BorderType.RRect,
                                                    dashPattern: const [
                                                      5,
                                                      5,
                                                      5,
                                                      5
                                                    ],
                                                    color: ColorConstants
                                                        .primaryColorDriver,
                                                    child: Padding(
                                                      padding:
                                                          const Pad(all: 20),
                                                      child: Center(
                                                        child: ref.watch(
                                                                    paotiImage) !=
                                                                null
                                                            ? Stack(
                                                                children: [
                                                                  Image.file(ref
                                                                          .watch(
                                                                              paotiImage) ??
                                                                      File('')),
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.6),
                                                                        shape: BoxShape
                                                                            .circle),
                                                                    child: IconButton(
                                                                        onPressed: () {
                                                                          ref.invalidate(
                                                                              paotiImage);
                                                                        },
                                                                        icon: const Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              Colors.white,
                                                                        )),
                                                                  )
                                                                ],
                                                              )
                                                            : InkWell(
                                                                child: ColumnSuper(
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .cloud_upload,
                                                                        color: ColorConstants
                                                                            .primaryColorDriver,
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "selectPaotiImage"
                                                                            .tr(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color:
                                                                                ColorConstants.primaryColorDriver,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: Adaptive.sp(16)),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "uploadDocumentImage"
                                                                            .tr(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color:
                                                                                ColorConstants.primaryColorDriver,
                                                                            fontWeight: FontWeight.w700,
                                                                            fontSize: Adaptive.sp(13)),
                                                                      )
                                                                    ]),
                                                                onTap:
                                                                    () async {
                                                                  imagePicker
                                                                      .pickImage(
                                                                          source: ImageSource
                                                                              .camera)
                                                                      .then(
                                                                          (file) {
                                                                    if (file !=
                                                                        null) {
                                                                      ref.watch(paotiImage.notifier).state =
                                                                          File(file
                                                                              .path);
                                                                    }
                                                                  });
                                                                },
                                                              ),
                                                      ),
                                                    )),
                                                AnimatedButton(
                                                  height: 35,
                                                  color: ColorConstants
                                                      .primaryColorDriver,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.2,
                                                  isOutline: true,
                                                  isMultiColor: true,
                                                  colors: const [
                                                    ColorConstants
                                                        .primaryColorDriver,
                                                    ColorConstants
                                                        .primaryColorDriver,
                                                  ],
                                                  borderWidth: 1,
                                                  child: Text(
                                                    "submit".tr(),
                                                  ),
                                                  onTap: () async {
                                                    if (form.currentState!
                                                        .validate()) {
                                                      if (ref.watch(
                                                              kantaImage) ==
                                                          null) {
                                                        errorToast(context,
                                                            "kantaImage".tr());
                                                      }
                                                      if (ref.watch(
                                                              qualityImage) ==
                                                          null) {
                                                        errorToast(
                                                            context,
                                                            'selectQualityImage'
                                                                .tr());
                                                      } else {
                                                        final bytes = File(ref
                                                                    .watch(
                                                                        kantaImage)
                                                                    ?.path ??
                                                                "")
                                                            .readAsBytesSync();
                                                        String img64 =
                                                            base64Encode(bytes);

                                                        final bytes2 = File(ref
                                                                    .watch(
                                                                        qualityImage)
                                                                    ?.path ??
                                                                "")
                                                            .readAsBytesSync();
                                                        String img642 =
                                                            base64Encode(bytes);
                                                        ref
                                                            .watch(endTripProvider(
                                                                    tripRequestId:
                                                                        '${dataList.id ?? 0}',
                                                                    kantaWeight:
                                                                        weightController
                                                                            .text
                                                                            .toString(),
                                                                    bags: bagsController
                                                                        .text
                                                                        .toString(),
                                                                    kantaImage:
                                                                        img64,
                                                                    qualityImage:
                                                                        img642,
                                                                    paotiNumber:
                                                                        paotiController
                                                                            .text,
                                                                    paotiImage: base64Encode(File(
                                                                            ref.watch(paotiImage)?.path ??
                                                                                "")
                                                                        .readAsBytesSync()))
                                                                .future)
                                                            .then((value) {
                                                          if (value['status']
                                                                  .toString() ==
                                                              "1") {
                                                            ref.invalidate(
                                                                tripsListProvider);
                                                            ref.invalidate(
                                                                kantaImage);
                                                            ref.invalidate(
                                                                qualityImage);
                                                            bagsController
                                                                .clear();
                                                            weightController
                                                                .clear();
                                                            ref
                                                                .watch(
                                                                    goRouterProvider)
                                                                .pop(context);
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
