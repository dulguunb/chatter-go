package errors

import "fmt"

var ConversationIsNotFound = fmt.Errorf("Conversation is not found")
var ConversationAlreadyExists = fmt.Errorf("Conversation already exists")
