import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
import 'package:pointycastle/pointycastle.dart';

// String cryptoHandler(String? encrypted, String? key, String? iv , {bool encrypt = false}) {
//   if (encrypted == null || key == null || iv == null) {
//     throw Exception("Missing required arguments");
//   }

//   final encryptedBytes = base64.decode(encrypted);
//   final keyBytes = utf8.encode(key);
//   final ivBytes = utf8.encode(iv);

//   final cipher = CBCBlockCipher(AESEngine())
//     ..init(
//         encrypt,
//         ParametersWithIV(KeyParameter(Uint8List.fromList(keyBytes)),
//             Uint8List.fromList(ivBytes)));

//   final paddedCipher = PaddedBlockCipherImpl(PKCS7Padding(), cipher);

//   final params =
//       PaddedBlockCipherParameters<CipherParameters?, CipherParameters?>(
//           ParametersWithIV<KeyParameter>(
//               KeyParameter(Uint8List.fromList(keyBytes)),
//               Uint8List.fromList(ivBytes)),
//           null);
//   paddedCipher.init(encrypt, params);

//   final decryptedBytes = paddedCipher.process(encryptedBytes);



//   if (encrypt){
//     return base64.encode(decryptedBytes);
//   }

//   return utf8.decode(decryptedBytes);
// }

String cryptoHandler(String string, String key, String iv, {bool encrypt = false}) {
  final cipher = CBCBlockCipher(AESEngine());

  print(string);

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



// String cryptoHandler(String string, String key, String iv, {bool encrypt = false}) {
//   final cipher = CBCBlockCipher(AESEngine());

//   final keyParams = PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, CipherParameters?>(
//     ParametersWithIV<KeyParameter>(KeyParameter(Uint8List.fromList(utf8.encode(key))), Uint8List.fromList(utf8.encode(iv))),
//     null,
//   );

//   final paddingCipher = PaddedBlockCipherImpl(PKCS7Padding(), cipher);
//   paddingCipher.init(encrypt, keyParams);

//   final input = utf8.encode(string);
//   final output = paddingCipher.process(Uint8List.fromList(input));

//   return encrypt ? base64.encode(output) : utf8.decode(output);
// }
