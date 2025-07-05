import 'package:flutter_test/flutter_test.dart';
import 'package:meow/e2e/key_manager.dart';

void main() {
  test('RSAKeyManager encode/decode public key', () {
    RSAKeyManager keyManager = RSAKeyManager();
    final publicKeyPem = keyManager.encodeRSAPublicKeyToPem();
    final publicKey = keyManager.parseRsaPublicKeyFromPem(publicKeyPem);
    expect(publicKey, keyManager.getPublicKey());
  });
  test('E2E test', () {
    RSAKeyManager keyManagerUser1 = RSAKeyManager();
    RSAKeyManager keyManagerUser2 = RSAKeyManager();
    final plaintext = "Hello World!";
    final ciphertext = keyManagerUser1.encrypt(keyManagerUser2.getPublicKey(), plaintext);
    final finalMessage = keyManagerUser2.decrypt(ciphertext);
    expect(finalMessage,plaintext);
  });
}
