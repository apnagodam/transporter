import 'dart:convert';
import 'dart:io';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:transporter/Domain/Authentication/AuthenticationService.dart';
import 'package:transporter/Presentation/Routes/routes.dart';
import 'package:transporter/Presentation/Routes/routes_strings.dart';

import '../../Data/Model/BankListModel.dart';
import '../../Data/Model/DistrictsResponseModel.dart';
import '../../Data/Model/StatesResponseModel.dart';
import '../Utils/Widgets/Widgets.dart';
import '../Utils/color_constants.dart';
import '../Utils/enums.dart';
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

  TextEditingController documentNumberController = TextEditingController();
  var stateProvider = StateProvider<String?>((ref) => null);

  var licenseImage = StateProvider<File?>((ref) => null);
  var panImage = StateProvider<File?>((ref) => null);
  var aadharImage = StateProvider<File?>((ref) => null);
  var aadharBackImage = StateProvider<File?>((ref) => null);
  var chequeImage = StateProvider<File?>((ref) => null);
  var profileImage = StateProvider<File?>((ref) => null);

  var documentImage = StateProvider<File?>((ref) => null);

  var propProof = StateProvider<File?>((ref) => null);
  var constitutionTypeProvider =
      StateProvider<ConstitutionType?>((ref) => null);

  var propDocTypeProvider = StateProvider<PropDocumentType?>((ref) => null);
  var bankProvider = StateProvider<BankDatum?>((ref) => null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SafeArea(
          child: defaultPadding(Form(
              key: formKey,
              child: SingleChildScrollView(
                child: driverFormLayout(context, ref),
              )))),
    );
  }

  driverFormLayout(BuildContext context, WidgetRef ref) => Column(children: [
        Center(
          child: CupertinoButton(
              child: Text(
                'Constitution',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Adaptive.sp(16),
                    color: ColorConstants.primaryColorDriver),
              ),
              onPressed: null),
        ),
        DropdownSearch<ConstitutionType?>(
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
                  ColumnSuper(alignment: Alignment.centerLeft, children: [
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
              isFilterOnline: true,
              title: Padding(
                padding: const Pad(all: 10),
                child: Text(
                  'Select Constitution',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Adaptive.sp(16), fontWeight: FontWeight.bold),
                ),
              ),
              showSearchBox: true,
              searchDelay: const Duration(microseconds: 500)),
          items: ConstitutionType.values ?? [],
          validator: (value) {
            if (ref.watch(constitutionTypeProvider) == null) {
              return "Please Select State";
            }
            return null;
          },
          itemAsString: (ConstitutionType? u) => u!.label,
          onChanged: (ConstitutionType? data) =>
              ref.watch(constitutionTypeProvider.notifier).state = data,
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                contentPadding: Pad(left: 10, bottom: 5, top: 5),
                hintText: "Select Constitution",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide:
                        BorderSide(color: ColorConstants.primaryColorDriver))),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: CupertinoButton(
              child: Text(
                ref.watch(constitutionTypeProvider) ==
                        ConstitutionType.proprietorship
                    ? 'Firm Details'
                    : 'Personal Details',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Adaptive.sp(16),
                    color: ColorConstants.primaryColorDriver),
              ),
              onPressed: null),
        ),

        personalDetailsLayout(context, ref),
        Center(
          child: CupertinoButton(
              child: Text(
                'Bank Details',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Adaptive.sp(16),
                    color: ColorConstants.primaryColorDriver),
              ),
              onPressed: null),
        ),
        bankDetailsLayout(context, ref),

        SizedBox(
          height: 10,
        ),
        ElevatedButton(
            style: StyleConstants.buttonBordersStyle(
                borderColor: Colors.white,
                backgroundColor: ColorConstants.secondaryColorWSP),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                switch (ref.watch(constitutionTypeProvider)) {
                  case null:
                    break;
                  case ConstitutionType.individual:
                    if (ref.watch(aadharImage) == null) {
                      errorToast(context, "Please select aadhar image");
                    } else if (ref.watch(aadharBackImage) == null) {
                      errorToast(context, "Please select aadhar back image");
                    } else if (ref.watch(profileImage) == null) {
                      errorToast(context, "Please select profile image");
                    } else if (ref.watch(panImage) == null) {
                      errorToast(context, "Please select pan image");
                    } else if (ref.watch(chequeImage) == null) {
                      errorToast(
                          context, "Please select cheque or passbook image");
                    } else {
                      callSubmitApi();
                    }
                    break;
                  case ConstitutionType.proprietorship:
                    if (ref.watch(profileImage) == null) {
                      errorToast(context, "Please select profile image");
                    } else if (ref.watch(panImage) == null) {
                      errorToast(context, "Please select pan image");
                    } else if (ref.watch(chequeImage) == null) {
                      errorToast(
                          context, "Please select cheque or passbook image");
                    } else if (ref.watch(documentImage) == null) {
                      errorToast(context, "Please select document image");
                    } else {
                      callSubmitApi();
                    }
                    break;
                }
              }
            },
            child: Text(
              "Submit",
              style: StyleConstants.buttonTextStyle(),
            ))
      ]);

  callSubmitApi() => ref.watch(registerUserProvider(data: {
        'transport_constitution': ref.watch(constitutionTypeProvider)?.type,
        'phone': driverPhoneController.text.toString(),
        'name': driverNameController.text.toString(),
        'state': ref.watch(statesProvider)?.name,
        'district': ref.watch(districtProvider)?.name,
        'address': addressController.text.toString(),
        'pincode': driverPincodeController.text.toString(),
        'bank_name': ref.watch(bankProvider)?.id.toString(),
        'bank_branch': bankBranchController.text.toString(),
        'bank_acc_no': driverBankAccountNoController.text.toString(),
        'bank_ifsc_code': driverBankIFSCController.text.toString(),
        'pancard_no': driverPanCardNoController.text.toString(),
        'pancard_image': base64Encode(ref.watch(panImage)!.readAsBytesSync()),
        'cheque_image': base64Encode(ref.watch(chequeImage)!.readAsBytesSync()),
        if (ref.watch(constitutionTypeProvider)!.type == 1)
          'aadhar_no': driverAadharNoController.text.toString(),
    if(ref.watch(aadharImage)!=null)  'aadhar_image': base64Encode(ref.watch(aadharImage)!.readAsBytesSync()),
        if(ref.watch(aadharBackImage)!=null)  'aadhar_back_image': base64Encode(ref.watch(aadharBackImage)!.readAsBytesSync()),
        if (ref.watch(constitutionTypeProvider)!.type == 2)
          'firm_name': driverNameController.text.toString(),
        'proof': ref.watch(propDocTypeProvider)?.type,
        'firm_proof_number': documentNumberController.text.toString(),
        if (ref.watch(documentImage) != null)
          'proprietorship_proof':
              base64Encode(ref.watch(documentImage)!.readAsBytesSync()),
      }).future).then((value){
        if(value['status'].toString()=="1"){
          ref.watch(goRouterProvider).go(RoutesStrings.login);
        }
  });

  personalDetailsLayout(BuildContext context, WidgetRef ref) => Column(
        children: [
          TextFormField(
            controller: driverNameController,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please input valid name';
              }
              return null;
            },
            decoration: InputDecoration(
                label: Text(ref.watch(constitutionTypeProvider) !=
                        ConstitutionType.proprietorship
                    ? "Name"
                    : "Firm Name"),
                hintText: "Name",
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
                label: Text("Mobile Phone"),
                hintText: "Mobile Phone",
                border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          ref.watch(constitutionTypeProvider) == ConstitutionType.proprietorship
              ? Column(
            children: [
              DropdownSearch<PropDocumentType?>(
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
                    isFilterOnline: true,
                    title: Padding(
                      padding: const Pad(all: 10),
                      child: Text(
                        'Select Document Type',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    showSearchBox: true,
                    searchDelay: const Duration(microseconds: 500)),
                items: PropDocumentType.values ?? [],
                itemAsString: (PropDocumentType? u) => u!.label,
                onChanged: (PropDocumentType? data) =>
                ref.watch(propDocTypeProvider.notifier).state = data,
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      contentPadding: Pad(left: 10, bottom: 5, top: 5),
                      hintText: "Select Document Type",
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                              color: ColorConstants.primaryColorDriver))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: documentNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please input valid document number';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    label: Text("Document Number"),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              DottedBorder(
                  borderType: BorderType.RRect,
                  dashPattern: const [5, 5, 5, 5],
                  color: ColorConstants.primaryColorDriver,
                  child: Padding(
                    padding: const Pad(all: 20),
                    child: Center(
                      child: ref.watch(documentImage) != null
                          ? Stack(
                        children: [
                          Image.file(
                              ref.watch(documentImage) ?? File('')),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle),
                            child: IconButton(
                                onPressed: () {
                                  ref.invalidate(documentImage);
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
                            "Select Document Image ",
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
                            "Upload Document Image,\n  Supports JPG, JPEG, PNG",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:
                                ColorConstants.primaryColorDriver,
                                fontWeight: FontWeight.w700,
                                fontSize: Adaptive.sp(13)),
                          )
                        ]),
                        onTap: () async {
                          await imagePicker
                              .pickImage(source: ImageSource.gallery,imageQuality: 30)
                              .then((value) async {
                            if (value != null) {
                              ref
                                  .watch(documentImage.notifier)
                                  .state = File(value.path);
                            }
                          });
                        },
                      ),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          )
              : SizedBox(),
          // TextFormField(
          //   controller: driverEmailController,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please input valid email';
          //     }
          //
          //     return null;
          //   },
          //   textInputAction: TextInputAction.next,
          //   decoration: const InputDecoration(
          //       label: Text("Email"),
          //       hintText: "Email",
          //       border: OutlineInputBorder()),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // ref.watch(stateListProvider).when(
          //     data: (states) => DropdownSearch<Datum?>(
          //           popupProps: PopupProps.menu(
          //               searchFieldProps: const TextFieldProps(
          //                   autofocus: true,
          //                   cursorColor: ColorConstants.primaryColorDriver,
          //                   padding: Pad(left: 10, right: 10),
          //                   decoration: InputDecoration(
          //                     contentPadding: Pad(left: 10, right: 10),
          //                     focusedErrorBorder: OutlineInputBorder(
          //                         borderSide: BorderSide(
          //                             style: BorderStyle.solid,
          //                             color:
          //                                 ColorConstants.primaryColorDriver)),
          //                     disabledBorder: OutlineInputBorder(
          //                         borderSide: BorderSide(
          //                             style: BorderStyle.solid,
          //                             color:
          //                                 ColorConstants.primaryColorDriver)),
          //                     errorBorder: OutlineInputBorder(
          //                         borderSide: BorderSide(
          //                             style: BorderStyle.solid,
          //                             color:
          //                                 ColorConstants.primaryColorDriver)),
          //                     focusedBorder: OutlineInputBorder(
          //                         borderSide: BorderSide(
          //                             style: BorderStyle.solid,
          //                             color:
          //                                 ColorConstants.primaryColorDriver)),
          //                     border: OutlineInputBorder(
          //                         borderSide: BorderSide(
          //                             style: BorderStyle.solid,
          //                             color:
          //                                 ColorConstants.primaryColorDriver)),
          //                     enabledBorder: OutlineInputBorder(
          //                         borderSide: BorderSide(
          //                             style: BorderStyle.solid,
          //                             color:
          //                                 ColorConstants.primaryColorDriver)),
          //                   )),
          //               menuProps: MenuProps(
          //                   shape: RoundedRectangleBorder(
          //                       side: const BorderSide(
          //                           color: ColorConstants.primaryColorDriver),
          //                       borderRadius: BorderRadius.circular(8))),
          //               itemBuilder: (context, terminal, isVisible) =>
          //                   ColumnSuper(
          //                       alignment: Alignment.centerLeft,
          //                       children: [
          //                         Padding(
          //                           padding: const Pad(all: 10),
          //                           child: Text(
          //                             "${terminal?.name}",
          //                             style: TextStyle(
          //                                 fontWeight: FontWeight.bold,
          //                                 fontSize: Adaptive.sp(16)),
          //                           ),
          //                         ),
          //                         Container(
          //                           height: 1,
          //                           color: Colors.grey.withOpacity(0.3),
          //                         ),
          //                       ]),
          //               isFilterOnline: true,
          //               title: Padding(
          //                 padding: const Pad(all: 10),
          //                 child: Text(
          //                   'Select State',
          //                   textAlign: TextAlign.center,
          //                   style: TextStyle(
          //                       fontSize: Adaptive.sp(16),
          //                       fontWeight: FontWeight.bold),
          //                 ),
          //               ),
          //               showSearchBox: true,
          //               searchDelay: const Duration(microseconds: 500)),
          //           filterFn: (user, filter) =>
          //               user?.stateFilterByName(filter) ?? false,
          //           // asyncItems: (String filter) => getData(filter),
          //
          //           items: states.data ?? [],
          //           validator: (value) {
          //             if (ref.watch(statesProvider) == null) {
          //               return "Please Select State";
          //             }
          //             return null;
          //           },
          //           itemAsString: (Datum? u) => u?.name ?? "",
          //           onChanged: (Datum? data) =>
          //               ref.watch(statesProvider.notifier).state = data,
          //           dropdownDecoratorProps: const DropDownDecoratorProps(
          //             dropdownSearchDecoration: InputDecoration(
          //                 contentPadding: Pad(left: 10, bottom: 5, top: 5),
          //                 hintText: "Select State",
          //                 border: OutlineInputBorder(
          //                     borderRadius:
          //                         BorderRadius.all(Radius.circular(8)),
          //                     borderSide: BorderSide(
          //                         color: ColorConstants.primaryColorDriver))),
          //           ),
          //         ),
          //     error: (e, s) => Container(),
          //     loading: () => const CupertinoActivityIndicator()),
          // const SizedBox(
          //   height: 10,
          // ),
          // ref.watch(statesProvider) == null
          //     ? SizedBox()
          //     : ref
          //         .watch(districtListProvider(
          //             code: "${ref.watch(statesProvider)?.code}"))
          //         .when(
          //             data: (states) => DropdownSearch<StateDatum?>(
          //                   popupProps: PopupProps.menu(
          //                       searchFieldProps: const TextFieldProps(
          //                           autofocus: true,
          //                           cursorColor:
          //                               ColorConstants.primaryColorDriver,
          //                           padding: Pad(left: 10, right: 10),
          //                           decoration: InputDecoration(
          //                             contentPadding: Pad(left: 10, right: 10),
          //                             focusedErrorBorder: OutlineInputBorder(
          //                                 borderSide: BorderSide(
          //                                     style: BorderStyle.solid,
          //                                     color: ColorConstants
          //                                         .primaryColorDriver)),
          //                             disabledBorder: OutlineInputBorder(
          //                                 borderSide: BorderSide(
          //                                     style: BorderStyle.solid,
          //                                     color: ColorConstants
          //                                         .primaryColorDriver)),
          //                             errorBorder: OutlineInputBorder(
          //                                 borderSide: BorderSide(
          //                                     style: BorderStyle.solid,
          //                                     color: ColorConstants
          //                                         .primaryColorDriver)),
          //                             focusedBorder: OutlineInputBorder(
          //                                 borderSide: BorderSide(
          //                                     style: BorderStyle.solid,
          //                                     color: ColorConstants
          //                                         .primaryColorDriver)),
          //                             border: OutlineInputBorder(
          //                                 borderSide: BorderSide(
          //                                     style: BorderStyle.solid,
          //                                     color: ColorConstants
          //                                         .primaryColorDriver)),
          //                             enabledBorder: OutlineInputBorder(
          //                                 borderSide: BorderSide(
          //                                     style: BorderStyle.solid,
          //                                     color: ColorConstants
          //                                         .primaryColorDriver)),
          //                           )),
          //                       menuProps: MenuProps(
          //                           shape: RoundedRectangleBorder(
          //                               side: const BorderSide(
          //                                   color: ColorConstants
          //                                       .primaryColorDriver),
          //                               borderRadius:
          //                                   BorderRadius.circular(8))),
          //                       itemBuilder: (context, terminal, isVisible) =>
          //                           ColumnSuper(
          //                               alignment: Alignment.centerLeft,
          //                               children: [
          //                                 Padding(
          //                                   padding: const Pad(all: 10),
          //                                   child: Text(
          //                                     "${terminal?.name}",
          //                                     style: TextStyle(
          //                                         fontWeight: FontWeight.bold,
          //                                         fontSize: Adaptive.sp(16)),
          //                                   ),
          //                                 ),
          //                                 Container(
          //                                   height: 1,
          //                                   color: Colors.grey.withOpacity(0.3),
          //                                 ),
          //                               ]),
          //                       isFilterOnline: true,
          //                       title: Padding(
          //                         padding: const Pad(all: 10),
          //                         child: Text(
          //                           'Select District',
          //                           textAlign: TextAlign.center,
          //                           style: TextStyle(
          //                               fontSize: Adaptive.sp(16),
          //                               fontWeight: FontWeight.bold),
          //                         ),
          //                       ),
          //                       showSearchBox: true,
          //                       searchDelay: const Duration(microseconds: 500)),
          //                   filterFn: (user, filter) =>
          //                       user?.districtFilterByName(filter) ?? false,
          //                   // asyncItems: (String filter) => getData(filter),
          //
          //                   items: states.data ?? [],
          //                   itemAsString: (StateDatum? u) => u?.name ?? "",
          //                   validator: (value) {
          //                     if (ref.watch(districtProvider) == null) {
          //                       return "Please Select District";
          //                     }
          //                     return null;
          //                   },
          //                   onChanged: (StateDatum? data) => ref
          //                       .watch(districtProvider.notifier)
          //                       .state = data,
          //                   dropdownDecoratorProps:
          //                       const DropDownDecoratorProps(
          //                     dropdownSearchDecoration: InputDecoration(
          //                         contentPadding:
          //                             Pad(left: 10, bottom: 5, top: 5),
          //                         hintText: "Select District",
          //                         border: OutlineInputBorder(
          //                             borderRadius:
          //                                 BorderRadius.all(Radius.circular(8)),
          //                             borderSide: BorderSide(
          //                                 color: ColorConstants
          //                                     .primaryColorDriver))),
          //                   ),
          //                 ),
          //             error: (e, s) => Container(),
          //             loading: () => const CupertinoActivityIndicator()),
          const SizedBox(
            height: 10,
          ),
          // TextFormField(
          //   controller: addressController,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please input valid address';
          //     }
          //
          //     return null;
          //   },
          //   textInputAction: TextInputAction.next,
          //   decoration: const InputDecoration(
          //       label: Text("Address"), border: OutlineInputBorder()),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // TextFormField(
          //   controller: driverPincodeController,
          //   textInputAction: TextInputAction.next,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please input valid pincode';
          //     }
          //     if (value.length != 6) {
          //       return 'Pincode should be of 6 digits';
          //     }
          //     return null;
          //   },
          //   maxLength: 6,
          //   keyboardType: TextInputType.number,
          //   decoration: const InputDecoration(
          //       label: Text("Enter Pincode"),
          //       hintText: "Enter Pincode",
          //       border: OutlineInputBorder()),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          ref.watch(constitutionTypeProvider) != ConstitutionType.individual
              ? SizedBox()
              : Column(
                  children: [
                    // TextFormField(
                    //   controller: driverAadharNoController,
                    //   keyboardType: TextInputType.number,
                    //   textInputAction: TextInputAction.next,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please input aadhar card no.';
                    //     }
                    //
                    //     return null;
                    //   },
                    //   decoration: const InputDecoration(
                    //       label: Text("Aadhar card no."),
                    //       hintText: "Aadhar card no.",
                    //       border: OutlineInputBorder()),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    DottedBorder(
                        borderType: BorderType.RRect,
                        dashPattern: const [5, 5, 5, 5],
                        color: ColorConstants.primaryColorDriver,
                        child: Padding(
                          padding: const Pad(all: 20),
                          child: Center(
                            child: ref.watch(aadharImage) != null
                                ? Stack(
                                    children: [
                                      Image.file(
                                          ref.watch(aadharImage) ?? File('')),
                                      Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            shape: BoxShape.circle),
                                        child: IconButton(
                                            onPressed: () {
                                              ref.invalidate(aadharImage);
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
                                        color:
                                            ColorConstants.primaryColorDriver,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Select Aadhar Image ",
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
                                        "Upload Document Image,\n  Supports JPG, JPEG, PNG",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorConstants
                                                .primaryColorDriver,
                                            fontWeight: FontWeight.w700,
                                            fontSize: Adaptive.sp(13)),
                                      )
                                    ]),
                                    onTap: () async {
                                      await imagePicker
                                          .pickImage(
                                              source: ImageSource.gallery,imageQuality: 30)
                                          .then((value) async {
                                        if (value != null) {
                                          ref
                                              .watch(aadharImage.notifier)
                                              .state = File(value.path);
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
                            child: ref.watch(aadharBackImage) != null
                                ? Stack(
                                    children: [
                                      Image.file(ref.watch(aadharBackImage) ??
                                          File('')),
                                      Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            shape: BoxShape.circle),
                                        child: IconButton(
                                            onPressed: () {
                                              ref.invalidate(aadharBackImage);
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
                                        color:
                                            ColorConstants.primaryColorDriver,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Select Aadhar back side Image ",
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
                                        "Upload Document Image,\n  Supports JPG, JPEG, PNG",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorConstants
                                                .primaryColorDriver,
                                            fontWeight: FontWeight.w700,
                                            fontSize: Adaptive.sp(13)),
                                      )
                                    ]),
                                    onTap: () async {
                                      await imagePicker
                                          .pickImage(
                                              source: ImageSource.gallery,imageQuality: 30)
                                          .then((value) async {
                                        if (value != null) {
                                          ref
                                              .watch(aadharBackImage.notifier)
                                              .state = File(value.path);
                                        }
                                      });
                                    },
                                  ),
                          ),
                        )),
                  ],
                ),
          const SizedBox(
            height: 10,
          ),
          DottedBorder(
              borderType: BorderType.RRect,
              dashPattern: const [5, 5, 5, 5],
              color: ColorConstants.primaryColorDriver,
              child: Padding(
                padding: const Pad(all: 20),
                child: Center(
                  child: ref.watch(profileImage) != null
                      ? Stack(
                          children: [
                            Image.file(ref.watch(profileImage) ?? File('')),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  shape: BoxShape.circle),
                              child: IconButton(
                                  onPressed: () {
                                    ref.invalidate(profileImage);
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
                              "Select Profile Image ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstants.primaryColorDriver,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Upload Profile Image,\n  Supports JPG, JPEG, PNG",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstants.primaryColorDriver,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Adaptive.sp(13)),
                            )
                          ]),
                          onTap: () async {
                            await imagePicker
                                .pickImage(source: ImageSource.gallery,imageQuality: 30)
                                .then((value) async {
                              if (value != null) {
                                ref.watch(profileImage.notifier).state =
                                    File(value.path);
                              }
                            });
                          },
                        ),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Center(
            child: CupertinoButton(
                child: Text(
                  'Pan Details',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Adaptive.sp(16),
                      color: ColorConstants.primaryColorDriver),
                ),
                onPressed: null),
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
          DottedBorder(
              borderType: BorderType.RRect,
              dashPattern: const [5, 5, 5, 5],
              color: ColorConstants.primaryColorDriver,
              child: Padding(
                padding: const Pad(all: 20),
                child: Center(
                  child: ref.watch(panImage) != null
                      ? Stack(
                    children: [
                      Image.file(ref.watch(panImage) ?? File('')),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            shape: BoxShape.circle),
                        child: IconButton(
                            onPressed: () {
                              ref.invalidate(panImage);
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
                        "Select PAN Image ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorConstants.primaryColorDriver,
                            fontWeight: FontWeight.bold,
                            fontSize: Adaptive.sp(16)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Upload Document Image,\n  Supports JPG, JPEG, PNG",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorConstants.primaryColorDriver,
                            fontWeight: FontWeight.w700,
                            fontSize: Adaptive.sp(13)),
                      )
                    ]),
                    onTap: () async {
                      await imagePicker
                          .pickImage(source: ImageSource.gallery,imageQuality: 30)
                          .then((value) async {
                        if (value != null) {
                          ref.watch(panImage.notifier).state =
                              File(value.path);
                        }
                      });
                    },
                  ),
                ),
              )),
          SizedBox(
            height: 10,
          ),
        ],
      );

  bankDetailsLayout(BuildContext context, WidgetRef ref) => Column(
        children: [
          // ref.watch(bankListProvider).when(data: (bankData)=>DropdownSearch<BankDatum?>(
          //   popupProps: PopupProps.menu(
          //       searchFieldProps: const TextFieldProps(
          //           autofocus: true,
          //           cursorColor:
          //           ColorConstants.primaryColorDriver,
          //           padding: Pad(left: 10, right: 10),
          //           decoration: InputDecoration(
          //             contentPadding: Pad(left: 10, right: 10),
          //             focusedErrorBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                     style: BorderStyle.solid,
          //                     color: ColorConstants
          //                         .primaryColorDriver)),
          //             disabledBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                     style: BorderStyle.solid,
          //                     color: ColorConstants
          //                         .primaryColorDriver)),
          //             errorBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                     style: BorderStyle.solid,
          //                     color: ColorConstants
          //                         .primaryColorDriver)),
          //             focusedBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                     style: BorderStyle.solid,
          //                     color: ColorConstants
          //                         .primaryColorDriver)),
          //             border: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                     style: BorderStyle.solid,
          //                     color: ColorConstants
          //                         .primaryColorDriver)),
          //             enabledBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                     style: BorderStyle.solid,
          //                     color: ColorConstants
          //                         .primaryColorDriver)),
          //           )),
          //       menuProps: MenuProps(
          //           shape: RoundedRectangleBorder(
          //               side: const BorderSide(
          //                   color: ColorConstants
          //                       .primaryColorDriver),
          //               borderRadius:
          //               BorderRadius.circular(8))),
          //       itemBuilder: (context, terminal, isVisible) =>
          //           ColumnSuper(
          //               alignment: Alignment.centerLeft,
          //               children: [
          //                 Padding(
          //                   padding: const Pad(all: 10),
          //                   child: Text(
          //                     "${terminal?.bankName}",
          //                     style: TextStyle(
          //                         fontWeight: FontWeight.bold,
          //                         fontSize: Adaptive.sp(16)),
          //                   ),
          //                 ),
          //                 Container(
          //                   height: 1,
          //                   color: Colors.grey.withOpacity(0.3),
          //                 ),
          //               ]),
          //       isFilterOnline: true,
          //       title: Padding(
          //         padding: const Pad(all: 10),
          //         child: Text(
          //           'Select Bank',
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //               fontSize: Adaptive.sp(16),
          //               fontWeight: FontWeight.bold),
          //         ),
          //       ),
          //       showSearchBox: true,
          //       searchDelay: const Duration(microseconds: 500)),
          //   filterFn: (user, filter) =>
          //   user?.filterByName(filter) ?? false,
          //   // asyncItems: (String filter) => getData(filter),
          //
          //   items:  bankData.data ?? [],
          //   itemAsString: (BankDatum? u) => u?.bankName ?? "",
          //   validator: (value) {
          //     if (ref.watch(bankProvider) == null) {
          //       return "Please Select Bank";
          //     }
          //     return null;
          //   },
          //   onChanged: (BankDatum? data) => ref
          //       .watch(bankProvider.notifier)
          //       .state = data,
          //   dropdownDecoratorProps:
          //   const DropDownDecoratorProps(
          //     dropdownSearchDecoration: InputDecoration(
          //         contentPadding:
          //         Pad(left: 10, bottom: 5, top: 5),
          //         hintText: "Select Bank",
          //         border: OutlineInputBorder(
          //             borderRadius:
          //             BorderRadius.all(Radius.circular(8)),
          //             borderSide: BorderSide(
          //                 color: ColorConstants
          //                     .primaryColorDriver))),
          //   ),
          // ), error: (e,_)=>Container(), loading: ()=>Container()),
          //
          // // TextFormField(
          // //   controller: driverBankNameController,
          // //   textInputAction: TextInputAction.next,
          // //   validator: (value) {
          // //     if (value == null || value.isEmpty) {
          // //       return 'Please select bank';
          // //     }
          // //
          // //     return null;
          // //   },
          // //   decoration: const InputDecoration(
          // //       label: Text("Bank Name"),
          // //       hintText: "Bank Name",
          // //       border: OutlineInputBorder()),
          // // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // TextFormField(
          //   controller: bankBranchController,
          //   textInputAction: TextInputAction.next,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please select bank branch';
          //     }
          //
          //     return null;
          //   },
          //   decoration: const InputDecoration(
          //       label: Text("Bank Branch Name"),
          //       hintText: "Bank Branch Name",
          //       border: OutlineInputBorder()),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // TextFormField(
          //   controller: driverBankAccountNoController,
          //   textInputAction: TextInputAction.next,
          //   keyboardType: TextInputType.number,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please input bank account number';
          //     }
          //
          //     return null;
          //   },
          //   decoration: const InputDecoration(
          //       label: Text("Bank Account Number"),
          //       hintText: "Bank Account Number",
          //       border: OutlineInputBorder()),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // TextFormField(
          //   controller: driverBankIFSCController,
          //   textInputAction: TextInputAction.next,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please input bank IFSC code';
          //     }
          //
          //     return null;
          //   },
          //   decoration: const InputDecoration(
          //       label: Text("Bank IFSC code"),
          //       hintText: "Bank IFSC code",
          //       border: OutlineInputBorder()),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),


          DottedBorder(
              borderType: BorderType.RRect,
              dashPattern: const [5, 5, 5, 5],
              color: ColorConstants.primaryColorDriver,
              child: Padding(
                padding: const Pad(all: 20),
                child: Center(
                  child: ref.watch(chequeImage) != null
                      ? Stack(
                          children: [
                            Image.file(ref.watch(chequeImage) ?? File('')),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  shape: BoxShape.circle),
                              child: IconButton(
                                  onPressed: () {
                                    ref.invalidate(chequeImage);
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
                              "Select Cheque /Passbook Image ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstants.primaryColorDriver,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Upload Document Image,\n  Supports JPG, JPEG, PNG",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstants.primaryColorDriver,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Adaptive.sp(13)),
                            )
                          ]),
                          onTap: () async {
                            await imagePicker
                                .pickImage(source: ImageSource.gallery,imageQuality: 30)
                                .then((value) async {
                              if (value != null) {
                                ref.watch(chequeImage.notifier).state =
                                    File(value.path);
                              }
                            });
                          },
                        ),
                ),
              )),
          SizedBox(
            height: 10,
          ),
        ],
      );
}
