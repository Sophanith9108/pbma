import 'package:hive/hive.dart';
import 'package:pbma/core.dart';

part 'member_entity.g.dart';

@HiveType(typeId: 14)
class MemberEntity extends UserEntity {
  static MemberModel toModel(UserEntity model) {
    return MemberModel()
      ..id = model.id ?? ''
      ..name = model.name ?? ''
      ..email = model.email ?? ''
      ..phone = model.phone ?? ''
      ..password = model.password ?? ''
      ..profilePicture = model.profilePicture ?? ''
      ..address = model.address ?? ''
      ..dateOfBirth = model.dateOfBirth ?? DateTime.now().format()
      ..gender = model.gender ?? GenderEnums.male
      ..createdAt = model.createdAt ?? DateTime.now()
      ..updatedAt = model.updatedAt ?? DateTime.now()
      ..role = model.role
      ..isLogin = model.isLogin
      ..deviceId = model.deviceId ?? ''
      ..deviceToken = model.deviceToken ?? ''
      ..deviceInfo = model.deviceInfo ?? ''
      ..status = model.status;
  }
}
