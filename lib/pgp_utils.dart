import 'package:openpgp/openpgp.dart';
import 'dart:convert';

class PGPUtil {
  /// Generate a new PGP key pair
  static Future<Map<String, String>> generateKeyPair({
    required String name,
    required String email,
    int numBits = 2048,
  }) async {
    final keyOptions = KeyOptions()..rsaBits = numBits;
    final options =
        Options()
          ..name = name
          ..email = email
          ..keyOptions = keyOptions;
    final generatedKey = await OpenPGP.generate(options: options);
    return {
      'publicKey': generatedKey.publicKey,
      'privateKey': generatedKey.privateKey,
    };
  }

  /// Encrypt a message using a public key
  static Future<String> encrypt({
    required String plainText,
    required String publicKey,
  }) async {
    return OpenPGP.encrypt(plainText, publicKey);
  }

  /// Decrypt a message using a private key
  static Future<String> decrypt({
    required String cipherText,
    required String privateKey,
    required String passphrase,
  }) async {
    return OpenPGP.decrypt(cipherText, privateKey, passphrase);
  }

  /// Sign a message using a private key
  static Future<String> sign({
    required String plainText,
    required String privateKey,
    required String passphrase,
  }) async {
    return OpenPGP.sign(plainText, privateKey, passphrase);
  }

  /// Verify a signed message using a public key
  static Future<bool> verify({
    required String plainText,
    required String signature,
    required String publicKey,
  }) async {
    try {
      final result = await OpenPGP.verify(plainText, signature, publicKey);
      return result;
    } catch (e) {
      return false;
    }
  }

  /// Encrypt binary data (e.g., files)
  static Future<List<int>> encryptBinary({
    required List<int> data,
    required String publicKey,
  }) async {
    final base64Data = base64Encode(data);
    final encrypted = await encrypt(
      plainText: base64Data,
      publicKey: publicKey,
    );
    return utf8.encode(encrypted).toList();
  }

  /// Decrypt binary data (e.g., files)
  static Future<List<int>> decryptBinary({
    required List<int> encryptedData,
    required String privateKey,
  }) async {
    final cipherText = utf8.decode(encryptedData);
    final decryptedBase64 = await decrypt(
      cipherText: cipherText,
      privateKey: privateKey,
      passphrase: '',
    );
    return base64Decode(decryptedBase64);
  }
}
