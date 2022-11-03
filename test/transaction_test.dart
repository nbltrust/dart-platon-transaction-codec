library cosmos_codec_test.transaction_test;

import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:ethereum_codec/ethereum_codec.dart';
import 'package:platon_codec/platon_codec.dart';
import 'package:test/test.dart';

void main() {
  test("test transaction", () {
    final rawHex = 'ea0a843b9aca008252089486b39bb292dbfa24aff4e71cf0e86dba19dffcc587470de4df82000080808080';
    final tx = PlatonTransaction.deserialize(rawHex);

    String rawTo = tx['rawTo'];
    expect(rawTo.toLowerCase(), '0x86b39bb292dbfa24aff4e71cf0e86dba19dffcc5');
    expect(tx['amount'], '20000000000000000');
    expect(tx['gasLimit'], 21000);
    expect(tx['gasPrice'], 1000000000);
    expect(tx['nonce'], 10);

    final ethTx = EthereumTransaction.fromRlp(Uint8List.fromList(hex.decode(rawHex)));

    expect(hex.encode(tx.hashToSign()), 'ef14414f3deb6208d69443f0ed599c8ae091566313f9208274402a2c07ef0359');
  });
}
