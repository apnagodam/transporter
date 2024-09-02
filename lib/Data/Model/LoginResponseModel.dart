// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromMap(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromMap(String str) => LoginResponseModel.fromMap(json.decode(str));

String loginResponseModelToMap(LoginResponseModel data) => json.encode(data.toMap());

class LoginResponseModel {
  String? authorization;
  UserDetails? userDetails;
  int? status;
  String? message;

  LoginResponseModel({
    this.authorization,
    this.userDetails,
    this.status,
    this.message,
  });

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) => LoginResponseModel(
    authorization: json["Authorization"],
    userDetails: json["user_details"] == null ? null : UserDetails.fromMap(json["user_details"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "Authorization": authorization,
    "user_details": userDetails?.toMap(),
    "status": status,
    "message": message,
  };
}

class UserDetails {
  int? id;
  int? userId;
  int? transportConstitution;
  String? name;
  String? firmName;
  dynamic email;
  String? phone;
  String? address;
  String? district;
  String? state;
  int? pincode;
  String? bankName;
  String? bankBranch;
  String? bankAccNo;
  String? bankIfscCode;
  dynamic gstNumber;
  String? chequeImage;
  String? pancardImage;
  String? aadharImage;
  String? aadharBackImage;
  String? pancardNo;
  dynamic aadharNo;
  int? proof;
  String? firmProofNumber;
  String? proprietorshipProof;
  dynamic partnershipDeed;
  dynamic partnersCount;
  dynamic moaAoa;
  dynamic boardResolution;
  dynamic proofDirector;
  dynamic noDirector;
  int? empId;
  int? approveBy;
  int? approve;
  int? verifyBy;
  int? verify;
  int? wallet;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;

  UserDetails({
    this.id,
    this.userId,
    this.transportConstitution,
    this.name,
    this.firmName,
    this.email,
    this.phone,
    this.address,
    this.district,
    this.state,
    this.pincode,
    this.bankName,
    this.bankBranch,
    this.bankAccNo,
    this.bankIfscCode,
    this.gstNumber,
    this.chequeImage,
    this.pancardImage,
    this.aadharImage,
    this.aadharBackImage,
    this.pancardNo,
    this.aadharNo,
    this.proof,
    this.firmProofNumber,
    this.proprietorshipProof,
    this.partnershipDeed,
    this.partnersCount,
    this.moaAoa,
    this.boardResolution,
    this.proofDirector,
    this.noDirector,
    this.empId,
    this.approveBy,
    this.approve,
    this.verifyBy,
    this.verify,
    this.wallet,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory UserDetails.fromMap(Map<String, dynamic> json) => UserDetails(
    id: json["id"],
    userId: json["user_id"],
    transportConstitution: json["transport_constitution"],
    name: json["name"],
    firmName: json["firm_name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    district: json["district"],
    state: json["state"],
    pincode: json["pincode"],
    bankName: json["bank_name"],
    bankBranch: json["bank_branch"],
    bankAccNo: json["bank_acc_no"],
    bankIfscCode: json["bank_ifsc_code"],
    gstNumber: json["gst_number"],
    chequeImage: json["cheque_image"],
    pancardImage: json["pancard_image"],
    aadharImage: json["aadhar_image"],
    aadharBackImage: json["aadhar_back_image"],
    pancardNo: json["pancard_no"],
    aadharNo: json["aadhar_no"],
    proof: json["proof"],
    firmProofNumber: json["firm_proof_number"],
    proprietorshipProof: json["proprietorship_proof"],
    partnershipDeed: json["partnership_deed"],
    partnersCount: json["partners_count"],
    moaAoa: json["moa_aoa"],
    boardResolution: json["board_resolution"],
    proofDirector: json["proof_director"],
    noDirector: json["no_director"],
    empId: json["emp_id"],
    approveBy: json["approve_by"],
    approve: json["approve"],
    verifyBy: json["verify_by"],
    verify: json["verify"],
    wallet: json["wallet"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "transport_constitution": transportConstitution,
    "name": name,
    "firm_name": firmName,
    "email": email,
    "phone": phone,
    "address": address,
    "district": district,
    "state": state,
    "pincode": pincode,
    "bank_name": bankName,
    "bank_branch": bankBranch,
    "bank_acc_no": bankAccNo,
    "bank_ifsc_code": bankIfscCode,
    "gst_number": gstNumber,
    "cheque_image": chequeImage,
    "pancard_image": pancardImage,
    "aadhar_image": aadharImage,
    "aadhar_back_image": aadharBackImage,
    "pancard_no": pancardNo,
    "aadhar_no": aadharNo,
    "proof": proof,
    "firm_proof_number": firmProofNumber,
    "proprietorship_proof": proprietorshipProof,
    "partnership_deed": partnershipDeed,
    "partners_count": partnersCount,
    "moa_aoa": moaAoa,
    "board_resolution": boardResolution,
    "proof_director": proofDirector,
    "no_director": noDirector,
    "emp_id": empId,
    "approve_by": approveBy,
    "approve": approve,
    "verify_by": verifyBy,
    "verify": verify,
    "wallet": wallet,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "image_url": imageUrl,
  };
}
