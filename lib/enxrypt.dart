import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';

class Encryption {
  static final Encryption instance = Encryption._('jhdsfjkhsukhyeiur');
  
  late IV _iv;
  late Encrypter _encrypter;

  Encryption._(String myKey) {
    myKey = _tokenEncoding(myKey);
    const myIv = 'Mo-Sa-A1763A-Sa-Mo';
    final keyUtf8 = utf8.encode(myKey);
    final ivUtf8 = utf8.encode(myIv);
    final key = sha256.convert(keyUtf8).toString().substring(0, 32);
    final iv = sha256.convert(ivUtf8).toString().substring(0, 16);
    _iv = IV.fromUtf8(iv);

    _encrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.cbc));
  }

  factory Encryption(String myKey) {
    return instance.._initialize(myKey);
  }

  void _initialize(String myKey) {
    myKey = _tokenEncoding(myKey);
    const myIv = 'Mo-Sa-A1763A-Sa-Mo';
    final keyUtf8 = utf8.encode(myKey);
    final ivUtf8 = utf8.encode(myIv);
    final key = sha256.convert(keyUtf8).toString().substring(0, 32);
    final iv = sha256.convert(ivUtf8).toString().substring(0, 16);
    _iv = IV.fromUtf8(iv);

    _encrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.cbc));
  }

  String encrypt(Map<String, dynamic> value) {
    return _encrypter.encrypt(jsonEncode(value), iv: _iv).base64;
  }

  Map<String, dynamic> decrypt(String base64Value) {
    final encrypted = Encrypted.fromBase64(base64Value);
    return jsonDecode(_encrypter.decrypt(encrypted, iv: _iv)) as Map<String, dynamic>;
  }

  String _tokenEncoding(String token) {
    final replace = {
      "a": "c",
      "b": "x",
      "c": "y",
      "d": "r",
      "e": "f",
      "f": "m",
      "g": "p",
      "h": "v",
      "i": "u",
      "j": "k",
      "k": "o",
      "l": "i",
      "m": "s",
      "n": "w",
      "o": "a",
      "p": "g",
      "q": "e",
      "r": "t",
      "s": "b",
      "t": "j",
      "u": "z",
      "v": "d",
      "w": "l",
      "x": "h",
      "y": "q",
      "z": "n",
    };
    final tokenList = token.split('');
    for (var i = 0; i < tokenList.length; i++) {
      if (replace.containsKey(tokenList[i])) {
        tokenList[i] = replace[tokenList[i]]!;
      }
    }
    return tokenList.reversed.join();
  }
}