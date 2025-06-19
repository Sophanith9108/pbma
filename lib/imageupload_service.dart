import 'package:firebase_storage/firebase_storage.dart';
import 'package:pbma/core.dart';

class ImageUploadService extends AppFirebaseStorageService<String> {
  final Reference _storage = FirebaseStorage.instance
      .ref()
      .child(AppFirebaseReference.root)
      .child(AppFirebaseReference.image);

  @override
  Future<String> create(String data) async {
    return await _storage
        .child(data)
        .putString(data, format: PutStringFormat.base64)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL())
        .catchError((error) {
          throw Exception('Failed to upload image: $error');
        });
  }

  @override
  Future<void> delete(String id) async {
    return await _storage.child(id).delete().catchError((error) {
      throw Exception('Failed to delete image: $error');
    });
  }

  @override
  Future<String> read(String id) async {
    return await _storage.child(id).getDownloadURL().catchError((error) {
      throw Exception('Failed to read image: $error');
    });
  }

  @override
  Future<List<String>> reads() async {
    return await _storage
        .listAll()
        .then((result) async {
          List<String> urls = [];
          for (var item in result.items) {
            String url = await item.getDownloadURL();
            urls.add(url);
          }
          return urls;
        })
        .catchError((error) {
          throw Exception('Failed to read images: $error');
        });
  }

  @override
  Future<String> update(String data) async {
    return await _storage
        .child(data)
        .putString(data, format: PutStringFormat.base64)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL())
        .catchError((error) {
          throw Exception('Failed to update image: $error');
        });
  }
}
