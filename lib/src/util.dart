import 'dart:typed_data';

import 'package:convert/convert.dart';

String strip0x(String s) {
  if (s.startsWith('0x')) return s.substring(2);
  return s;
}

String append0x(String s) {
  if (s.startsWith('0x')) return s;
  return '0x' + s;
}

Uint8List my_hexdecode(String hexStr) {
  return hex.decode((hexStr.length.isOdd ? '0' : '') + hexStr);
}
