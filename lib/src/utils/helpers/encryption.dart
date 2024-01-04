import 'package:encrypt/encrypt.dart';

class Encrypt {
  static final _key = Key.fromUtf8('1234567891011123');
  static final _iv = IV.allZerosOfLength(16);

  static final encrypter = Encrypter(AES(_key, mode: AESMode.cbc, padding: 'PKCS7'));

  static Encrypted encrypted(String text) => encrypter.encrypt(text, iv: _iv);

  static String decrypted(String cipher) => encrypter.decrypt(Encrypted.fromBase64(cipher), iv: _iv);
}
