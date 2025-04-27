package usernames

import (
	"math/rand"
	"strings"
)

// words is a list of words to choose from.
// This variable is not exported (starts with a lowercase letter).
var words = []string{
	"apple", "banana", "cherry", "date", "elderberry",
	"fig", "grape", "honeydew", "kiwi", "lemon",
	"mango", "nectarine", "orange", "papaya", "quince",
	"raspberry", "strawberry", "tangerine", "ugli", "vanilla",
	"watermelon", "xigua", "yellow passion fruit", "zucchini",
}

func GenerateWords(count int) string {
	generatedWordsSlice := make([]string, count)

	for i := 0; i < count; i++ {

		randomIndex := rand.Intn(len(words))

		generatedWordsSlice[i] = words[randomIndex]
	}
	singleString := strings.Join(generatedWordsSlice, " ")

	return singleString
}
