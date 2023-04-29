import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
import 'package:pointycastle/pointycastle.dart';

String cryptoHandler(String encrypted, String key, String iv) {
  final encryptedBytes = base64.decode(encrypted);
  final keyBytes = utf8.encode(key);
  final ivBytes = utf8.encode(iv);

  print(ivBytes.length);
  
  final cipher = CBCBlockCipher(AESEngine())
      ..init(false, ParametersWithIV(KeyParameter(Uint8List.fromList(keyBytes)), Uint8List.fromList(ivBytes)));

  final paddedCipher = PaddedBlockCipherImpl(
      PKCS7Padding(), cipher);

  final decryptedBytes = paddedCipher.process(encryptedBytes);

  return utf8.decode(decryptedBytes);
}
