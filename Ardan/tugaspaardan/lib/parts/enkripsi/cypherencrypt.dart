import 'dart:async';

Future<String> encryptPassword(String password, String email) async {
  int shift = email.length - 6;

  shift = shift % 26;

  String encryptedPassword = _caesarCipher(password, shift);

  return encryptedPassword;
}

String _caesarCipher(String text, int shift) {
  final buffer = StringBuffer();

  for (int i = 0; i < text.length; i++) {
    final codeUnit = text.codeUnitAt(i);

    if (codeUnit >= 65 && codeUnit <= 90) {
      buffer.writeCharCode(65 + (codeUnit - 65 + shift) % 26);
    } else if (codeUnit >= 97 && codeUnit <= 122) {
      buffer.writeCharCode(97 + (codeUnit - 97 + shift) % 26);
    } else {
      buffer.writeCharCode(codeUnit);
    }
  }

  return buffer.toString();
}

Future<String> decryptPassword(String encryptedPassword, String email) async {
  int shift = email.length - 6;

  shift = shift % 26;

  String decryptedPassword = _caesarCipher(encryptedPassword, 26 - shift);

  return decryptedPassword;
}
