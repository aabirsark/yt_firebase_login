import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
import 'package:pointycastle/pointycastle.dart';

/// Handles he crypto encryption and decrpyption of the codes
String cryptoHandler(String string, String key, String iv, {bool encrypt = false}) {
  final cipher = CBCBlockCipher(AESEngine());

  final keyParams = PaddedBlockCipherParameters<CipherParameters?, CipherParameters?>(
    ParametersWithIV<KeyParameter>(KeyParameter(Uint8List.fromList(key.codeUnits)),Uint8List.fromList(iv.codeUnits)),
    null,
  );

  final paddingCipher = PaddedBlockCipherImpl(PKCS7Padding(), cipher);
  paddingCipher.init(encrypt, keyParams);

  final input = encrypt ? string.codeUnits :  base64.decode(string);
  
  final output = paddingCipher.process(Uint8List.fromList(input));

  return encrypt ? base64.encode(output) : utf8.decode(output);
} 


