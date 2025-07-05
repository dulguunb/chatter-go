import 'dart:typed_data';
import 'dart:convert';
import 'package:pointycastle/export.dart';
import 'package:asn1lib/asn1lib.dart';

// TODO: Extend this
abstract class KeyManager {
  // Uint8List encrypt(PublicKey publicKey, String plaintext);
  // Uint8List decrypt(Uint8List ciphertext);
}

class RSAKeyManager implements KeyManager {
  late AsymmetricKeyPair key;

  RSAKeyManager() {
    final keyParams = RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 64);
    final secureRandom = FortunaRandom()
      ..seed(KeyParameter(Uint8List.fromList(List.generate(32, (_) => 1))));
    final generator = RSAKeyGenerator()
      ..init(ParametersWithRandom(keyParams, secureRandom));
    key = generator.generateKeyPair();
  }

  RSAPublicKey getPublicKey() {
    return key.publicKey as RSAPublicKey;
  }

  // https://github.com/bcgit/pc-dart/blob/master/tutorials/rsa.md
  Uint8List _processInBlocks(AsymmetricBlockCipher engine, Uint8List input) {
    final numBlocks =
        input.length ~/ engine.inputBlockSize +
        ((input.length % engine.inputBlockSize != 0) ? 1 : 0);

    final output = Uint8List(numBlocks * engine.outputBlockSize);

    var inputOffset = 0;
    var outputOffset = 0;
    while (inputOffset < input.length) {
      final chunkSize = (inputOffset + engine.inputBlockSize <= input.length)
          ? engine.inputBlockSize
          : input.length - inputOffset;

      outputOffset += engine.processBlock(
        input,
        inputOffset,
        chunkSize,
        output,
        outputOffset,
      );

      inputOffset += chunkSize;
    }

    return (output.length == outputOffset)
        ? output
        : output.sublist(0, outputOffset);
  }

  String encrypt(RSAPublicKey publicKey, String plaintext) {
    final encryptor = RSAEngine()
      ..init(true, PublicKeyParameter<RSAPublicKey>(publicKey));
    final result = _processInBlocks(encryptor, utf8.encode(plaintext));
    return toHex(result);
  }

  String toHex(Uint8List bytes) =>
      bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

  Uint8List fromHex(String hex) {
    // Remove any 0x prefix if present
    hex = hex.replaceAll(RegExp(r'^0x'), '');
    // Make sure it's even-length
    if (hex.length % 2 != 0) {
      throw FormatException("Invalid hex string length");
    }
    final bytes = <int>[];
    for (int i = 0; i < hex.length; i += 2) {
      final byteStr = hex.substring(i, i + 2);
      final byte = int.parse(byteStr, radix: 16);
      bytes.add(byte);
    }

    return Uint8List.fromList(bytes);
  }

  String decrypt(String ciphertextHex) {
    final ciphertext = fromHex(ciphertextHex);
    final decryptor = RSAEngine()
      ..init(false, PrivateKeyParameter<RSAPrivateKey>(key.privateKey));
    return utf8.decode(_processInBlocks(decryptor, ciphertext));
  }

  String encodeRSAPublicKeyToPem() {
    final publicKey = key.publicKey as RSAPublicKey;
    final asn1Seq = ASN1Sequence();
    asn1Seq.add(ASN1Integer(publicKey.modulus!));
    asn1Seq.add(ASN1Integer(publicKey.exponent!));
    final derBytes = asn1Seq.encodedBytes;
    final base64Encoded = base64.encode(derBytes);
    // Add PEM headers/footers
    final pem = StringBuffer();
    pem.writeln('-----BEGIN RSA PUBLIC KEY-----');
    // Split into 64-character lines
    for (var i = 0; i < base64Encoded.length; i += 64) {
      pem.writeln(
        base64Encoded.substring(
          i,
          i + 64 > base64Encoded.length ? base64Encoded.length : i + 64,
        ),
      );
    }
    pem.writeln('-----END RSA PUBLIC KEY-----');
    return pem.toString();
  }

  RSAPublicKey parseRsaPublicKeyFromPem(String pemString) {
    // Remove the header/footer and newlines
    final cleaned = pemString
        .replaceAll('-----BEGIN RSA PUBLIC KEY-----', '')
        .replaceAll('-----END RSA PUBLIC KEY-----', '')
        .replaceAll('\n', '')
        .replaceAll('\r', '');
    // Decode Base64 to get DER bytes
    final derBytes = base64.decode(cleaned);
    final asn1Parser = ASN1Parser(derBytes);
    final topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;
    final modulus = (topLevelSeq.elements![0] as ASN1Integer).valueAsBigInteger;
    final exponent =
        (topLevelSeq.elements![1] as ASN1Integer).valueAsBigInteger;
    // Create the RSAPublicKey
    return RSAPublicKey(modulus!, exponent!);
  }
}
