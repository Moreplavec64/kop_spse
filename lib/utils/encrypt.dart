import 'package:encrypt/encrypt.dart';

class EncryptData {
//for AES Algorithms

  static String encryptAES(String plainText, String stringKey) {
    final key = Key.fromUtf8(stringKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return (encrypted.base64);
  }

  static String decryptAES(Encrypted encrypted, String stringKey) {
    final key = Key.fromUtf8(stringKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}
