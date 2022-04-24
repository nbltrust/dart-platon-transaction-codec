library cosmos_codec.transaction;

import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:ethereum_codec/ethereum_codec.dart';
import 'package:platon_codec/src/util.dart';
import 'package:pointycastle/digests/sha3.dart';
import 'package:quiver/collection.dart';

import 'bech32.dart';

class PlatonTransaction extends DelegatingMap {
  final delegate = new Map<String, dynamic>();

  PlatonTransaction(String rawHex) {
    this.delegate['rawHex'] = rawHex;
  }

  factory PlatonTransaction.deserialize(String rawHex, [bech32Hrp = 'lat', chainId = 210309]) {
    final ethTx = EthereumTransaction.fromRlp(hex.decode(strip0x(rawHex)));
    ethTx.chainId = chainId;

    PlatonTransaction tx = new PlatonTransaction(rawHex);
    tx['rawTo'] = ethTx.to.toChecksumAddress();
    tx['to'] = Bech32Encoder.encode(bech32Hrp, hex.decode(strip0x(tx['rawTo'])));
    tx['amount'] = ethTx.value.toString();
    tx['gasLimit'] = ethTx.gas;
    tx['gasPrice'] = ethTx.gasPrice;
    tx['nonce'] = ethTx.nonce;
    tx['input'] = ethTx.input;
    tx['chainId'] = ethTx.chainId;
    tx['_inner'] = ethTx;

    return tx;
  }

  Uint8List hashToSign() {
    return this.delegate['_inner'].hashToSign();
  }
}
