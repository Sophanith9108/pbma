import 'package:hive/hive.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

part 'attachment_entity.g.dart';

@HiveType(typeId: 15)
class AttachmentEntity extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? image;

  @HiveField(3)
  String? type;

  @HiveField(4)
  String? size;

  @HiveField(5)
  UserEntity? createdBy;

  @HiveField(6)
  DateTime? createdAt;

  @HiveField(7)
  DateTime? updatedAt;

  AttachmentEntity();

  factory AttachmentEntity.create({
    required String id,
    required String name,
    required String image,
    String? type,
    String? size,
    required UserEntity createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AttachmentEntity()
      ..id = id
      ..name = name
      ..image = image
      ..type = type ?? "base64"
      ..size = size ?? "0 KB"
      ..createdBy = createdBy
      ..createdAt = createdAt ?? DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now();
  }

  static AttachmentEntity toEntity(AttachmentModel model) {
    return AttachmentEntity()
      ..id = model.id
      ..name = model.name
      ..image = model.image
      ..type = model.type
      ..size = model.size
      ..createdBy = UserEntity.toEntity(model.createdBy)
      ..createdAt = model.createdAt
      ..updatedAt = model.updatedAt;
  }

  static AttachmentModel toModel(AttachmentEntity entity) {
    return AttachmentModel()
      ..id = entity.id ?? Uuid().v8()
      ..name = entity.name ?? "Attachment ${entity.id}"
      ..image = entity.image ?? ""
      ..type = entity.type ?? "base64"
      ..size = entity.size ?? "0 KB"
      ..createdBy = UserEntity.toModel(entity.createdBy!)
      ..createdAt = entity.createdAt ?? DateTime.now()
      ..updatedAt = entity.updatedAt ?? DateTime.now();
  }
}
