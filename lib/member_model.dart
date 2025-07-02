import 'package:get/get.dart';
import 'package:pbma/core.dart';

class MemberModel extends UserModel {
  final _user = UserModel().obs;
  UserModel get user => _user.value;
  set user(UserModel value) => _user.value = value;

  MemberModel();

  MemberModel.create({required UserModel user}) {
    this.user = user;
  }

  MemberModel.fromJson({required Map<dynamic, dynamic> json}) {
    user = UserModel.fromJson(json: json['user'] as Map<String, dynamic>);
  }

  static Map<String, dynamic> toJson({required MemberModel member}) => {
    'user': UserModel.toJson(model: member),
  };
}
