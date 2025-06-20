import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

class NotificationModel extends Equatable {
  final _id = "".obs;
  String get id => _id.value;
  set id(String value) => _id.value = value;

  final _title = "".obs;
  String get title => _title.value;
  set title(String value) => _title.value = value;

  final _isRead = false.obs;
  bool get isRead => _isRead.value;
  set isRead(bool value) => _isRead.value = value;

  final _message = "".obs;
  String get message => _message.value;
  set message(String value) => _message.value = value;

  final _createdBy = UserModel().obs;
  UserModel get createdBy => _createdBy.value;
  set createdBy(UserModel value) => _createdBy.value = value;

  final _createdAt = DateTime.now().obs;
  DateTime get createdAt => _createdAt.value;
  set createdAt(DateTime value) => _createdAt.value = value;

  final _updatedAt = DateTime.now().obs;
  DateTime get updatedAt => _updatedAt.value;
  set updatedAt(DateTime value) => _updatedAt.value = value;

  NotificationModel();

  factory NotificationModel.create({
    required String title,
    required String message,
    required UserModel createdBy,
    bool? isRead,
    DateTime? updatedAt,
  }) {
    return NotificationModel()
      ..id = Uuid().v8()
      ..title = title
      ..message = message
      ..isRead = isRead ?? false
      ..createdBy = createdBy
      ..createdAt = DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now();
  }

  factory NotificationModel.fromJson({required Map<dynamic, dynamic> json}) {
    return NotificationModel()
      ..id = json['id'].toString()
      ..title = json['title'].toString()
      ..isRead = json['isRead'].toString().toLowerCase() == 'true'
      ..message = json['message'].toString()
      ..createdBy = UserModel.fromJson(json: json['createdBy'])
      ..createdAt = DateTime.fromMillisecondsSinceEpoch(
        int.parse(json['createdAt'].toString()),
      )
      ..updatedAt = DateTime.fromMillisecondsSinceEpoch(
        int.parse(json['updatedAt'].toString()),
      );
  }

  static Map<String, dynamic> toJson({required NotificationModel model}) {
    return {
      'id': model.id.toString(),
      'title': model.title.toString(),
      'isRead': model.isRead.toString(),
      'message': model.message.toString(),
      'createdBy': UserModel.toJson(model: model.createdBy),
      'createdAt': model.createdAt.millisecondsSinceEpoch.toString(),
      'updatedAt': model.updatedAt.millisecondsSinceEpoch.toString(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    isRead,
    message,
    createdBy,
    createdAt,
    updatedAt,
  ];
}
