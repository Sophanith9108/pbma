import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:pbma/core.dart';

class ProfileUploadService extends AppFileUploadService {
  final FirebaseStorage _storage = FirebaseStorage.instanceFor(
    bucket:
        kDebugMode
            ? AppFirebaseReference.devNode
            : kProfileMode
            ? AppFirebaseReference.preNode
            : AppFirebaseReference.proNode,
  );

  @override
  Future<String> create(String base64Data, {String? fileName}) async {
    String fileName = 'base64_${DateTime.now().millisecondsSinceEpoch}.jpg';

    SettableMetadata metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {"uploaded": "base64"},
    );

    return await _storage
        .ref()
        .child(fileName)
        .putString(
          base64Data,
          format: PutStringFormat.base64,
          metadata: metadata,
        )
        .then((value) => value.ref.fullPath);
  }

  @override
  Future<bool> delete(String fileId) async {
    return await _storage.ref().child(fileId).delete().then((value) => true);
  }

  @override
  Future<String?> read(String fileId) async {
    return await _storage
        .ref()
        .child(fileId)
        .getDownloadURL()
        .then((value) => value);
  }

  @override
  Future<String> update(
    String fileId,
    String newBase64Data, {
    String? fileName,
  }) async {
    return await _storage
        .ref()
        .child(fileName ?? '')
        .putString(newBase64Data)
        .then((value) => value.ref.fullPath);
  }

  @override
  Future<List<String>> uploads(
    List<String> base64DataList, {
    List<String>? fileNames,
  }) async {
    return await Future.wait(
      base64DataList.map(
        (data) =>
            create(data, fileName: fileNames?[base64DataList.indexOf(data)]),
      ),
    );
  }
}
