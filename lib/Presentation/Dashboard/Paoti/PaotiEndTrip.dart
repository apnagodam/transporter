import 'dart:convert';
import 'dart:io';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:button_animations/button_animations.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one_context/one_context.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:transporter/Data/Model/TripDataResponse.dart';
import 'package:transporter/Presentation/Utils/enums.dart';

import '../../../Domain/Trips/TripsService.dart';
import '../../Routes/routes.dart';
import '../../Utils/Widgets/Widgets.dart';
import '../../Utils/color_constants.dart';

class Paotiendtrip extends ConsumerStatefulWidget {
  const Paotiendtrip({super.key, required this.dataList});

  final Datum? dataList;

  @override
  ConsumerState<Paotiendtrip> createState() => _PaotiendtripState();
}

class _PaotiendtripState extends ConsumerState<Paotiendtrip> {
  final form = GlobalKey<FormState>();

  final bagsController = TextEditingController();
  final weightController = TextEditingController();
  final imagePicker = ImagePicker();
  var kantaImage = StateProvider<File?>((ref) => null);
  var qualityImage = StateProvider<File?>((ref) => null);
  final paotiController = TextEditingController();
  var paotiImage = StateProvider<File?>((ref) => null);
  var tripStatusProvider =
      StateProvider<TripStatus>((ref) => TripStatus.accepted);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('End Trip'),
        centerTitle: false,
      ),
      body: SafeArea(
          child: Padding(
        padding: Pad(all: 10),
        child: Form(
            key: form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "tripStatus".tr(),
                    style: TextStyle(
                        fontSize: Adaptive.sp(16),
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primaryColorWSP),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownSearch<TripStatus?>(
                    popupProps: PopupProps.menu(
                        searchFieldProps: const TextFieldProps(
                            autofocus: true,
                            cursorColor: ColorConstants.primaryColorDriver,
                            padding: Pad(left: 10, right: 10),
                            decoration: InputDecoration(
                              contentPadding: Pad(left: 10, right: 10),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color:
                                          ColorConstants.primaryColorDriver)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color:
                                          ColorConstants.primaryColorDriver)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color:
                                          ColorConstants.primaryColorDriver)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color:
                                          ColorConstants.primaryColorDriver)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color:
                                          ColorConstants.primaryColorDriver)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color:
                                          ColorConstants.primaryColorDriver)),
                            )),
                        menuProps: MenuProps(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: ColorConstants.primaryColorDriver),
                                borderRadius: BorderRadius.circular(8))),
                        itemBuilder: (context, terminal, isVisible) =>
                            ColumnSuper(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Padding(
                                    padding: const Pad(all: 10),
                                    child: Text(
                                      "${terminal?.label}",
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
                        isFilterOnline: false,
                        title: Padding(
                          padding: const Pad(all: 10),
                          child: Text(
                            'selectTripStatus'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        showSearchBox: false,
                        searchDelay: const Duration(microseconds: 500)),
                    items: TripStatus.values ?? [],
                    itemAsString: (TripStatus? u) => u!.label,
                    onChanged: (TripStatus? data) =>
                        ref.watch(tripStatusProvider.notifier).state = data!,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          contentPadding: Pad(left: 10, bottom: 5, top: 5),
                          hintText: "selectTripStatus".tr(),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  color: ColorConstants.primaryColorDriver))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Total Bags",
                    style: TextStyle(
                        fontSize: Adaptive.sp(16),
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primaryColorWSP),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: bagsController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Total Bags'.tr();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        label: Text('Total Bags'.tr()),
                        contentPadding: const Pad(top: 0, bottom: 0, left: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Receiving Weight(KG)",
                    style: TextStyle(
                        fontSize: Adaptive.sp(16),
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primaryColorWSP),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: weightController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter receiving weight'.tr();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        label: Text('enter receiving weight'.tr()),
                        contentPadding: const Pad(top: 0, bottom: 0, left: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Paotee Number",
                    style: TextStyle(
                        fontSize: Adaptive.sp(16),
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primaryColorWSP),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: paotiController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        label: Text('enterPaotiNumber'.tr()),
                        contentPadding: const Pad(top: 0, bottom: 0, left: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: DottedBorder(
                              borderType: BorderType.RRect,
                              dashPattern: const [5, 5, 5, 5],
                              color: ColorConstants.primaryColorDriver,
                              child: Padding(
                                padding: const Pad(all: 20),
                                child: Center(
                                  child: ref.watch(kantaImage) != null
                                      ? Stack(
                                          children: [
                                            Image.file(ref.watch(kantaImage) ??
                                                File('')),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                  shape: BoxShape.circle),
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
                                              color: ColorConstants
                                                  .primaryColorDriver,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Select Kanta Image".tr(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColorDriver,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Adaptive.sp(16)),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "uploadDocumentImage".tr(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColorDriver,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: Adaptive.sp(13)),
                                            )
                                          ]),
                                          onTap: () async {
                                            imagePicker
                                                .pickImage(
                                                    source: ImageSource.camera)
                                                .then((file) {
                                              if (file != null) {
                                                ref
                                                    .watch(kantaImage.notifier)
                                                    .state = File(file.path);
                                              }
                                            });
                                          },
                                        ),
                                ),
                              ))),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: DottedBorder(
                              borderType: BorderType.RRect,
                              dashPattern: const [5, 5, 5, 5],
                              color: ColorConstants.primaryColorDriver,
                              child: Padding(
                                padding: const Pad(all: 20),
                                child: Center(
                                  child: ref.watch(qualityImage) != null
                                      ? Stack(
                                          children: [
                                            Image.file(
                                                ref.watch(qualityImage) ??
                                                    File('')),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                  shape: BoxShape.circle),
                                              child: IconButton(
                                                  onPressed: () {
                                                    ref.invalidate(
                                                        qualityImage);
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
                                              color: ColorConstants
                                                  .primaryColorDriver,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Quality Image ".tr(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColorDriver,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Adaptive.sp(16)),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "uploadDocumentImage".tr(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColorDriver,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: Adaptive.sp(13)),
                                            )
                                          ]),
                                          onTap: () async {
                                            imagePicker
                                                .pickImage(
                                                    source: ImageSource.camera)
                                                .then((file) {
                                              if (file != null) {
                                                ref
                                                    .watch(
                                                        qualityImage.notifier)
                                                    .state = File(file.path);
                                              }
                                            });
                                          },
                                        ),
                                ),
                              ))),
                    ],
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
                          child: ref.watch(paotiImage) != null
                              ? Stack(
                                  children: [
                                    Image.file(
                                        ref.watch(paotiImage) ?? File('')),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                          shape: BoxShape.circle),
                                      child: IconButton(
                                          onPressed: () {
                                            ref.invalidate(paotiImage);
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
                                      "selectPaotiImage".tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              ColorConstants.primaryColorDriver,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Adaptive.sp(16)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "uploadDocumentImage".tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              ColorConstants.primaryColorDriver,
                                          fontWeight: FontWeight.w700,
                                          fontSize: Adaptive.sp(13)),
                                    )
                                  ]),
                                  onTap: () async {
                                    imagePicker
                                        .pickImage(source: ImageSource.camera)
                                        .then((file) {
                                      if (file != null) {
                                        ref.watch(paotiImage.notifier).state =
                                            File(file.path);
                                      }
                                    });
                                  },
                                ),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
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
                      "submit".tr(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () async {
                      if (form.currentState!.validate()) {
                        if (ref.watch(kantaImage) == null) {
                          errorToast(context, "kantaImage".tr());
                        }
                        if (ref.watch(qualityImage) == null) {
                          errorToast(context, 'selectQualityImage'.tr());
                        } else {
                          final bytes = File(ref.watch(kantaImage)?.path ?? "")
                              .readAsBytesSync();
                          String img64 = base64Encode(bytes);

                          final bytes2 =
                              File(ref.watch(qualityImage)?.path ?? "")
                                  .readAsBytesSync();
                          String img642 = base64Encode(bytes2);
                          ref
                              .watch(endTripProvider(
                                      tripRequestId:
                                          '${widget.dataList?.id ?? 0}',
                                      kantaWeight:
                                          '${num.parse(weightController.text.toString())}',
                                      bags: "${bagsController.text.toString()}",
                                      kantaImage: img64,
                                      qualityImage: img642,
                                      paotiNumber: paotiController.text,
                                      paotiImage: base64Encode(File(
                                              ref.watch(paotiImage)?.path ?? "")
                                          .readAsBytesSync()),
                                      tripStatus:
                                          ref.watch(tripStatusProvider)?.type)
                                  .future)
                              .then((value) {
                            if (value['status'].toString() == "1") {
                              successToast(OneContext().context!,
                                  "${value['message'] ?? value['Message']}");
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
              ),
            )),
      )),
    );
  }
}
