package encryption

import (
	"bytes"
	"io"
	"sync"

	"filippo.io/age"
	"github.com/dulguunb/chatter-go/client/logging"
)

type KeyMaterial struct {
	myIdentity     *age.X25519Identity  // my private key
	myRecipient    *age.X25519Recipient // my public key
	othersRecipent *age.X25519Recipient
}

var (
	Key  *KeyMaterial
	once sync.Once
)

func New() *KeyMaterial {
	identity, err := age.GenerateX25519Identity()
	if err != nil {
		logging.Logger.Sugar().Fatal(err)
	}
	recipient := identity.Recipient()
	return &KeyMaterial{
		myIdentity:     identity,
		myRecipient:    recipient,
		othersRecipent: nil,
	}
}

func (k *KeyMaterial) SetOthersKey(pubKey string) error {
	recipient, err := age.ParseX25519Recipient(pubKey)
	if err != nil {
		return err
	}
	k.othersRecipent = recipient
	return nil
}

func (k *KeyMaterial) GetMyPublicKey() string {
	return k.myRecipient.String()
}

func (k *KeyMaterial) GetOtherPublicKey() string {
	if k.othersRecipent != nil {
		return k.othersRecipent.String()
	}
	return ""
}

func (k *KeyMaterial) EncryptMessage(messagePlain string) (string, error) {
	var encrypted bytes.Buffer
	w, err := age.Encrypt(&encrypted, k.othersRecipent)
	if err != nil {
		return "", err
	}
	_, err = w.Write([]byte(messagePlain))
	if err != nil {
		return "", err
	}
	err = w.Close()
	if err != nil {
		return "", err
	}
	return encrypted.String(), nil
}

func (k *KeyMaterial) DecryptMessage(messageEncrypted string) (string, error) {
	var encrypted bytes.Buffer
	_, err := encrypted.Write([]byte(messageEncrypted))

	if err != nil {
		return "", err
	}

	w, err := age.Decrypt(&encrypted, k.myIdentity)
	if err != nil {
		return "", err
	}
	plainMessage, err := io.ReadAll(w)
	if err != nil {
		return "", err
	}
	return string(plainMessage), nil
}
