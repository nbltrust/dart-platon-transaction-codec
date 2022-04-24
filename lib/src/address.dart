library cosmos_codec.address;

import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pointycastle/digests/sha3.dart';

import 'bech32.dart';
import 'util.dart';

String toChecksumAddress(String hexAddress) {
  hexAddress = strip0x(hexAddress);

  var digest = SHA3Digest(256, true).process(Uint8List.fromList(hexAddress.toLowerCase().codeUnits));
  var hexStr = hex.encode(digest);
  var checksumAddr = '';
  for (var i = 0; i < hexAddress.length; i++) {
    if (int.parse(hexStr[i], radix: 16) >= 8) {
      checksumAddr += hexAddress[i].toUpperCase();
    } else {
      checksumAddr += hexAddress[i];
    }
  }
  return '0x' + checksumAddr;
}

String publicKeyToAddress(String hexX, String hexY, [bech32Hrp = 'lat']) {
  final plainKey = my_hexdecode(hexX) + my_hexdecode(hexY);
  final digest = SHA3Digest(256, true).process(Uint8List.fromList(plainKey));
  final hexDigest = hex.encode(digest);
  final ethAddr = toChecksumAddress(hexDigest.substring(hexDigest.length - 40));

  return Bech32Encoder.encode(bech32Hrp, hex.decode(strip0x(ethAddr)));
}
