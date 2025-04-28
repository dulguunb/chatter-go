package singletons

import (
	"sync"

	chatterPb "github.com/dulguunb/go-chatter/gen"
)

var (
	EnvelopeInstance map[string]*chatterPb.Envelope
	onceMessage      sync.Once
)

func GetEnvelopeInstance() map[string]*chatterPb.Envelope {
	onceMessage.Do(func() {
		EnvelopeInstance = make(map[string]*chatterPb.Envelope)
	})
	return EnvelopeInstance
}
