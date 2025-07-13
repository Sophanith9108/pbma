import 'package:get/get.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

class MemberModel extends UserModel {
  final _user = UserModel().obs;
  UserModel get user => _user.value;
  set user(UserModel value) => _user.value = value;

  final _isSelected = false.obs;
  bool get isSelected => _isSelected.value;
  set isSelected(bool value) => _isSelected.value = value;

  MemberModel();

  static MemberModel create({
    required String name,
    required String email,
    required String phone,
    required String address,
    String? profile,
    String? deviceId,
    String? deviceToken,
    String? deviceInfo,
    required UserModel user,
  }) {
    return MemberModel()
      ..id = Uuid().v8()
      ..name = name
      ..email = email
      ..phone = phone
      ..role = UserRoleEnums.user
      ..isLogin = false
      ..profilePicture = profile ?? ""
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now()
      ..dateOfBirth = DateTime.now().format(pattern: AppConstants.dateFormat)
      ..gender = GenderEnums.male
      ..address = address
      ..password = ""
      ..deviceId = deviceId ?? ""
      ..deviceToken = deviceToken ?? ""
      ..deviceInfo = deviceInfo ?? ""
      ..user = user;
  }

  MemberModel.fromJson({required Map<dynamic, dynamic> json}) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    profilePicture = json['profilePicture'];
    address = json['address'];
    dateOfBirth = json['dateOfBirth'];
    gender = GenderEnums.values.byName(json['gender']);
    createdAt = DateTime.tryParse(json['createdAt']) ?? DateTime.now();
    updatedAt = DateTime.tryParse(json['updatedAt']) ?? DateTime.now();
    role = UserRoleEnums.values.byName(json['role']);
    deviceId = json['deviceId'];
    deviceToken = json['deviceToken'];
    deviceInfo = json['deviceInfo'];
    isLogin = json['isLogin'] == 'true';
    user = UserModel.fromJson(json: json['user'] as Map<dynamic, dynamic>);
  }

  static Map<String, dynamic> toJson({required MemberModel member}) => {
    'id': member.id,
    'name': member.name,
    'email': member.email,
    'phone': member.phone,
    'password': member.password,
    'profilePicture': member.profilePicture,
    'address': member.address,
    'dateOfBirth': member.dateOfBirth,
    'deviceId': member.deviceId,
    'deviceToken': member.deviceToken,
    'deviceInfo': member.deviceInfo,
    'gender': member.gender.name,
    'createdAt': member.createdAt.millisecondsSinceEpoch.toString(),
    'updatedAt': member.updatedAt.millisecondsSinceEpoch.toString(),
    'role': member.role.name,
    'isLogin': member.isLogin.toString(),
    'user': UserModel.toJson(model: member.user),
  };
}
