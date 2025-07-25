import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:pbma/user_model.dart';
import 'package:uuid/uuid.dart';

class AttachmentModel extends Equatable {
  final _id = "".obs;
  String get id => _id.value;
  set id(String value) => _id.value = value;

  final _name = "".obs;
  String get name => _name.value;
  set name(String value) => _name.value = value;

  final _image = "".obs;
  String get image => _image.value;
  set image(String value) => _image.value = value;

  final _type = "".obs;
  String get type => _type.value;
  set type(String value) => _type.value = value;

  final _size = "".obs;
  String get size => _size.value;
  set size(String value) => _size.value = value;

  final _createdBy = UserModel().obs;
  UserModel get createdBy => _createdBy.value;
  set createdBy(UserModel value) => _createdBy.value = value;

  final _createdAt = DateTime.now().obs;
  DateTime get createdAt => _createdAt.value;
  set createdAt(DateTime value) => _createdAt.value = value;

  final _updatedAt = DateTime.now().obs;
  DateTime get updatedAt => _updatedAt.value;
  set updatedAt(DateTime value) => _updatedAt.value = value;

  AttachmentModel();

  factory AttachmentModel.create({
    required String name,
    required String image,
    required UserModel createdBy,
    String? id,
    String? type,
    String? size,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AttachmentModel()
      ..id = id ?? Uuid().v8()
      ..name = name
      ..image = image
      ..type = type ?? "base64"
      ..size = size ?? ""
      ..createdBy = createdBy
      ..createdAt = createdAt ?? DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now();
  }

  static Map<String, dynamic> toJson({required AttachmentModel model}) {
    return {
      "id": model.id,
      "name": model.name,
      "image": model.image,
      "type": model.type,
      "size": model.size,
      "createdBy": UserModel.toJson(model: model.createdBy),
      "createdAt": model.createdAt.millisecondsSinceEpoch,
      "updatedAt": model.updatedAt.millisecondsSinceEpoch,
    };
  }

  static AttachmentModel fromJson({required Map<dynamic, dynamic> json}) {
    return AttachmentModel()
      ..id = json["id"]
      ..name = json["name"]
      ..image = json["image"]
      ..type = json["type"]
      ..size = json["size"]
      ..createdBy = UserModel.fromJson(json: json["createdBy"])
      ..createdAt = DateTime.fromMillisecondsSinceEpoch(json["createdAt"])
      ..updatedAt = DateTime.fromMillisecondsSinceEpoch(json["updatedAt"]);
  }

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    type,
    size,
    createdAt,
    updatedAt,
  ];
}
