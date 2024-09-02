import 'dart:io';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Data/Model/DistrictsResponseModel.dart';
import '../../Data/Model/StatesResponseModel.dart';
import '../../Domain/StateService/StateService.dart';
import '../Utils/Widgets/Widgets.dart';
import '../Utils/color_constants.dart';
import '../Utils/style_constants.dart';



class Registrationscreen extends ConsumerStatefulWidget {
  const Registrationscreen({super.key});

  @override
  ConsumerState<Registrationscreen> createState() => _RegistrationscreenState();
}
final formKey = GlobalKey<FormState>();

class _RegistrationscreenState extends ConsumerState<Registrationscreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController bankBranchController = TextEditingController();
  TextEditingController mobileNumberController3 = TextEditingController();

  var statesProvider = StateProvider<Datum?>((ref) => null);

  var districtProvider = StateProvider<StateDatum?>((ref) => null);
  ImagePicker imagePicker = ImagePicker();

  TextEditingController driverNameController = TextEditingController();
  TextEditingController driverPhoneController = TextEditingController();
  TextEditingController driverEmailController = TextEditingController();
  TextEditingController driverLicenseController = TextEditingController();
  TextEditingController driverCityController = TextEditingController();
  TextEditingController driverStateController = TextEditingController();
  TextEditingController driverPincodeController = TextEditingController();
  TextEditingController driverBankNameController = TextEditingController();
  TextEditingController driverBankAccountNoController = TextEditingController();
  TextEditingController driverBankIFSCController = TextEditingController();
  TextEditingController driverPanCardNoController = TextEditingController();
  TextEditingController driverAadharNoController = TextEditingController();
  var stateProvider = StateProvider<String?>((ref) => null);

  var licenseImage = StateProvider<File?>((ref) => null);
  var panImage = StateProvider<File?>((ref) => null);
  var aadharImage = StateProvider<File?>((ref) => null);
  var chequeImage = StateProvider<File?>((ref) => null);
  var profileImage = StateProvider<File?>((ref) => null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: defaultPadding(
              Form(key: formKey, child: driverFormLayout(context, ref)))),
    );
  }

  driverFormLayout(BuildContext context, WidgetRef ref) => ListView(children: [
        TextFormField(
          controller: driverNameController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input valid name';
            }
            return null;
          },
          decoration: const InputDecoration(
              label: Text("Driver Name"),
              hintText: "Driver Name",
              border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: driverPhoneController,
          textInputAction: TextInputAction.next,
          maxLength: 10,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input valid number';
            }
            if (value.length != 10) {
              return "Mobile number must be of 10 digits!";
            }
            return null;
          },
          decoration: const InputDecoration(
              label: Text("Driver Phone"),
              hintText: "Driver Phone",
              border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: driverEmailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input valid email';
            }

            return null;
          },
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
              label: Text("Driver Email"),
              hintText: "Driver Email",
              border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: driverLicenseController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input valid license';
            }

            return null;
          },
          decoration: const InputDecoration(
              label: Text("Driver License number"),
              hintText: "Driver License number",
              border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              // style: StyleConstants.buttonBordersStyle(
              //     borderColor: Col,
              //     backgroundColor: Colors.white),
              onPressed: () async {
                await imagePicker
                    .pickImage(source: ImageSource.gallery)
                    .then((value) async {
                  if (value != null) {
                    ref.watch(licenseImage.notifier).state = File(value.path);
                  }
                });
              },
              child: Text(
                "Select license Image",
                style: StyleConstants.normalStyle(),
              )),
        ),
        if (ref.watch(licenseImage) != null)
          Image.file(ref.watch(licenseImage) ?? File(""))
        else
          SizedBox(),
        const SizedBox(
          height: 10,
        ),
        ref.watch(stateListProvider).when(
            data: (states) => DropdownSearch<Datum?>(
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
                                    color: ColorConstants.primaryColorDriver)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: ColorConstants.primaryColorDriver)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: ColorConstants.primaryColorDriver)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: ColorConstants.primaryColorDriver)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: ColorConstants.primaryColorDriver)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: ColorConstants.primaryColorDriver)),
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
                                    "${terminal?.name}",
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
                          'Select State',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      showSearchBox: true,
                      searchDelay: const Duration(microseconds: 500)),
                  filterFn: (user, filter) =>
                      user?.stateFilterByName(filter) ?? false,
                  // asyncItems: (String filter) => getData(filter),

                  items: states.data ?? [],
                  itemAsString: (Datum? u) => u?.name ?? "",
                  onChanged: (Datum? data) =>
                      ref.watch(statesProvider.notifier).state = data,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        contentPadding: Pad(left: 10, bottom: 5, top: 5),
                        hintText: "Select State",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                                color: ColorConstants.primaryColorDriver))),
                  ),
                ),
            error: (e, s) => Container(),
            loading: () => const CupertinoActivityIndicator()),
        const SizedBox(
          height: 10,
        ),
        ref.watch(statesProvider) == null
            ? const SizedBox()
            : ref
                .watch(
                    districtListProvider(code: ref.watch(statesProvider)?.code))
                .when(
                    data: (states) => DropdownSearch<StateDatum?>(
                          popupProps: PopupProps.menu(
                              searchFieldProps: const TextFieldProps(
                                  autofocus: true,
                                  cursorColor:
                                      ColorConstants.primaryColorDriver,
                                  padding: Pad(left: 10, right: 10),
                                  decoration: InputDecoration(
                                    contentPadding: Pad(left: 10, right: 10),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: ColorConstants
                                                .primaryColorDriver)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: ColorConstants
                                                .primaryColorDriver)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: ColorConstants
                                                .primaryColorDriver)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: ColorConstants
                                                .primaryColorDriver)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: ColorConstants
                                                .primaryColorDriver)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: ColorConstants
                                                .primaryColorDriver)),
                                  )),
                              menuProps: MenuProps(
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: ColorConstants
                                              .primaryColorDriver),
                                      borderRadius: BorderRadius.circular(8))),
                              itemBuilder: (context, terminal, isVisible) =>
                                  ColumnSuper(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        Padding(
                                          padding: const Pad(all: 10),
                                          child: Text(
                                            "${terminal?.name}",
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
                                  'Select District',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              showSearchBox: true,
                              searchDelay: const Duration(microseconds: 500)),
                          filterFn: (user, filter) =>
                              user?.districtFilterByName(filter) ?? false,
                          // asyncItems: (String filter) => getData(filter),

                          items: states.data ?? [],
                          itemAsString: (StateDatum? u) => u?.name ?? "",
                          onChanged: (StateDatum? data) =>
                              ref.watch(districtProvider.notifier).state = data,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                contentPadding:
                                    Pad(left: 10, bottom: 5, top: 5),
                                hintText: "Select District",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: ColorConstants
                                            .primaryColorDriver))),
                          ),
                        ),
                    error: (e, s) => Container(),
                    loading: () => const CupertinoActivityIndicator()),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: driverPincodeController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input valid pincode';
            }
            if (value.length != 6) {
              return 'Pincode should be of 6 digits';
            }
            return null;
          },
          maxLength: 6,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              label: Text("Enter Pincode"),
              hintText: "Enter Pincode",
              border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: driverBankNameController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select bank';
            }

            return null;
          },
          decoration: const InputDecoration(
              label: Text("Bank Name"),
              hintText: "Bank Name",
              border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: driverBankAccountNoController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input bank account number';
            }

            return null;
          },
          decoration: const InputDecoration(
              label: Text("Bank Account Number"),
              hintText: "Bank Account Number",
              border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: driverBankIFSCController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input bank IFSC code';
            }

            return null;
          },
          decoration: const InputDecoration(
              label: Text("Bank IFSC code"),
              hintText: "Bank IFSC code",
              border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: driverPanCardNoController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input pan card';
            }

            return null;
          },
          decoration: const InputDecoration(
              label: Text("Pan card no"),
              hintText: "Pan card no",
              border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: driverAadharNoController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input aadhar card no.';
            }

            return null;
          },
          decoration: const InputDecoration(
              label: Text("Aadhar card no."),
              hintText: "Aadhar card no.",
              border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              style: StyleConstants.buttonBordersStyle(
                  borderColor: ColorConstants.primaryColorWSP,
                  backgroundColor: Colors.white),
              onPressed: () async {
                await imagePicker
                    .pickImage(source: ImageSource.gallery)
                    .then((value) async {
                  if (value != null) {
                    ref.watch(panImage.notifier).state = File(value.path);
                  }
                });
              },
              child: Text(
                "Select Pan Image",
                style: StyleConstants.normalStyle(),
              )),
        ),
        if (ref.watch(panImage) != null)
          Image.file(ref.watch(panImage) ?? File(""))
        else
          SizedBox(),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              style: StyleConstants.buttonBordersStyle(
                  borderColor: ColorConstants.primaryColorWSP,
                  backgroundColor: Colors.white),
              onPressed: () async {
                await imagePicker
                    .pickImage(source: ImageSource.gallery)
                    .then((value) async {
                  if (value != null) {
                    ref.watch(aadharImage.notifier).state = File(value.path);
                  }
                });
              },
              child: Text(
                "Select Aadhar Image",
                style: StyleConstants.normalStyle(),
              )),
        ),
        if (ref.watch(aadharImage) != null)
          Image.file(ref.watch(aadharImage) ?? File(""))
        else
          SizedBox(),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              style: StyleConstants.buttonBordersStyle(
                  borderColor: ColorConstants.primaryColorWSP,
                  backgroundColor: Colors.white),
              onPressed: () async {
                await imagePicker
                    .pickImage(source: ImageSource.gallery)
                    .then((value) async {
                  if (value != null) {
                    ref.watch(chequeImage.notifier).state = File(value.path);
                  }
                });
              },
              child: Text(
                "Select Cheque/Passbook Image",
                style: StyleConstants.normalStyle(),
              )),
        ),
        if (ref.watch(chequeImage) != null)
          Image.file(ref.watch(chequeImage) ?? File(""))
        else
          SizedBox(),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              style: StyleConstants.buttonBordersStyle(
                  borderColor: ColorConstants.primaryColorWSP,
                  backgroundColor: Colors.white),
              onPressed: () async {
                await imagePicker
                    .pickImage(source: ImageSource.gallery)
                    .then((value) async {
                  if (value != null) {
                    ref.watch(profileImage.notifier).state = File(value.path);
                  }
                });
              },
              child: Text(
                "Select Profile Image",
                style: StyleConstants.normalStyle(),
              )),
        ),
        if (ref.watch(profileImage) != null)
          Image.file(ref.watch(profileImage) ?? File(""))
        else
          SizedBox(),
        ElevatedButton(
            style: StyleConstants.buttonBordersStyle(
                borderColor: Colors.white,
                backgroundColor: ColorConstants.secondaryColorWSP),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (ref.watch(licenseImage) == null) {
                  errorToast(context, "please select license image");
                } else if (ref.watch(panImage) == null) {
                  errorToast(context, "please select pan card image");
                } else if (ref.watch(aadharImage) == null) {
                  errorToast(context, "please select aadhar card image");
                } else if (ref.watch(chequeImage) == null) {
                  errorToast(context, "please select cheque image");
                } else if (ref.watch(profileImage) == null) {
                  errorToast(context, "please select profile image");
                } else {
                  successToast(context, "Success");
                }
              }
            },
            child: Text(
              "Submit",
              style: StyleConstants.buttonTextStyle(),
            ))
      ]);
}
