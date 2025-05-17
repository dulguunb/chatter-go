package encryption

import (
	"strings"
	"testing"

	"filippo.io/age"
)

func Test_EncryptDecryptCycle(t *testing.T) {
	type testCase struct {
		name    string
		message string
		wantErr bool
	}

	testCases := []testCase{
		{"short message", "hello", false},
		{"long message", "this is a much longer message to test the encryption and decryption cycle", false},
		{"message with numbers and symbols", "message 123 !@#$", false},
		{"empty message", "", false},
		{"message with unicode", "你好世界", false},
	}

	for _, tc := range testCases {
		t.Run(tc.name, func(t *testing.T) {
			ourIdentity, err := age.GenerateX25519Identity()
			if err != nil {
				t.Fatalf("Failed to generate our identity: %v", err)
			}
			ourRecipient := ourIdentity.Recipient()

			otherIdentity, err := age.GenerateX25519Identity()
			if err != nil {
				t.Fatalf("Failed to generate other identity: %v", err)
			}
			othersRecipient := otherIdentity.Recipient()

			ourKeyMaterial := &KeyMaterial{
				myIdentity:     ourIdentity,
				myRecipient:    ourRecipient,
				othersRecipent: othersRecipient,
			}

			othersKeyMaterial := &KeyMaterial{
				myIdentity:     otherIdentity,
				myRecipient:    othersRecipient,
				othersRecipent: ourRecipient,
			}

			messageEncrypted, err := ourKeyMaterial.EncryptMessage(tc.message)
			if err != nil && !tc.wantErr {
				t.Fatal(err)
			}

			if messageEncrypted == "" && tc.message != "" {
				t.Fatal("EncryptMessage returned empty string for non-empty input")
			}
			if tc.message != "" && !strings.HasPrefix(messageEncrypted, "age-encryption.org/v1") {
				t.Errorf("Encrypted message does not start with expected age header, got: %q", messageEncrypted)
			}

			decryptedMessage, err := othersKeyMaterial.DecryptMessage(messageEncrypted)
			if err != nil && !tc.wantErr {
				t.Fatal(err)
			}
			if decryptedMessage != tc.message {
				t.Errorf("Decryption failed: got %q, want %q", decryptedMessage, tc.message)
			}
		})
	}
}
