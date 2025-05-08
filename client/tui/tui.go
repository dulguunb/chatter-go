package tui

import (
	"fmt"
	"log"
	"strings"
	"time"

	"github.com/dulguunb/chatter-go/client/client_grpc/chat_client"
	"github.com/dulguunb/chatter-go/client/client_grpc/list_client"
	"github.com/dulguunb/chatter-go/client/conn"
	"github.com/dulguunb/chatter-go/client/logging"
	chatterPb "github.com/dulguunb/go-chatter/gen"
	"github.com/gdamore/tcell/v2"
	"github.com/rivo/tview"
)

type UserInterface interface {
	CreateLandingPage()
}
type UserInfo struct {
	Username   string
	ServerIp   string
	PortNumber int
}
type TUI struct {
	app         *tview.Application
	pages       *tview.Pages
	UserInfo    UserInfo
	userList    *tview.List
	messageView *tview.TextView
	inputField  *tview.InputField
	listClient  *list_client.ListUsersService
	chatClient  *chat_client.ChatService
}

var _ UserInterface = (*TUI)(nil)

func New() *TUI {
	app := tview.NewApplication()
	pages := tview.NewPages()
	messageView := tview.NewTextView().
		SetDynamicColors(true).
		SetScrollable(true)
	messageView.SetBorder(true).SetTitle("Messages")
	inputField := tview.NewInputField().
		SetLabel("Enter message: ").
		SetFieldWidth(0) // Make the input field take up available width
	inputField.SetBorder(true)
	return &TUI{
		UserInfo: UserInfo{
			Username:   "",
			ServerIp:   "",
			PortNumber: 50051,
		},
		app:         app,
		pages:       pages,
		userList:    tview.NewList(),
		messageView: messageView,
		inputField:  inputField,
	}
}

func (t *TUI) createFormPage() *tview.Form {
	form := tview.NewForm().
		AddInputField("Name", "", 20, nil, nil)
	form.AddInputField("Server IP", "", 20, nil, nil)
	form.AddButton("Connect", func() {
		// Extract values when the "Submit" button is pressed
		t.UserInfo.Username = form.GetFormItemByLabel("Name").(*tview.InputField).GetText()
		t.UserInfo.ServerIp = form.GetFormItemByLabel("Server IP").(*tview.InputField).GetText()
		conn, err := conn.CreateServerConnection(t.UserInfo.ServerIp, int64(t.UserInfo.PortNumber))
		if err != nil {
			log.Fatal(err)
		}
		t.listClient = list_client.New(t.UserInfo.Username, conn)
		t.chatClient = chat_client.New(t.listClient.Conn, t.listClient.Me)
		usersChan, err := t.listClient.GetAvailableUsers()
		go t.listAvailableUsers(usersChan)
		go t.listenOnActiveConversation()
	}).AddButton("Quit", func() {
		t.app.Stop()
	})
	form.SetBorder(true).SetTitle("Enter some data").SetTitleAlign(tview.AlignLeft)
	if err := t.app.SetRoot(form, true).EnableMouse(true).Run(); err != nil {
		panic(err)
	}
	return form
}

func (t *TUI) listenOnActiveConversation() {
	conversationChan, err := t.chatClient.GetConversations()
	if err != nil {
		logging.Logger.Sugar().Error(err)
	}
	for {
		select {
		case conversation := <-conversationChan:
			logging.Logger.Sugar().Info("listen on active convo: ")
			logging.Logger.Sugar().Info(conversation)
			t.userList.Clear()
			t.CreateMessengerPage()
		}
	}
}

func (t *TUI) listAvailableUsers(usersChan chan map[string]*chatterPb.User) {
	go func() {
		for {
			select {
			case resp := <-usersChan:
				go t.Redraw(resp)
			}
		}
	}()
	t.app.SetRoot(t.userList, true).EnableMouse(true).Run()
}

func (t *TUI) Redraw(users map[string]*chatterPb.User) {
	t.app.QueueUpdateDraw(func() {
		for _, user := range users {
			username := user.Username
			indices := t.userList.FindItems(username, "", true, true)
			if len(indices) == 0 && user.Id != t.listClient.Me.Id {
				t.userList.AddItem(user.Username, "Press enter to chat", rune(0), func() {
					t.chatClient.CreateConversation(user)
					t.CreateMessengerPage()
				})
			}
		}
	})
}

func (t *TUI) CreateMessengerPage() {
	flex := tview.NewFlex().
		SetDirection(tview.FlexRow).
		AddItem(t.messageView, 0, 1, false). // Message view takes priority in height
		AddItem(t.inputField, 3, 1, true)    // Input field has a fixed height of 3 rows

	go func() {
		ticker := time.NewTicker(100 * time.Millisecond)
		for {
			select {
			case <-ticker.C:
				messages, _ := t.chatClient.ReceiveMessage(t.chatClient.Sender.Id)
				if strings.TrimSpace(messages) != "" {
					fmt.Fprintf(t.messageView, "%s\n", messages)
				}
			}
		}
	}()

	logging.Logger.Sugar().Infof("user_name: %s , conversation_id: %s", t.chatClient.Sender.Username, t.chatClient.Conversation.Id)
	t.inputField.SetDoneFunc(func(key tcell.Key) {
		if key == tcell.KeyEnter {
			message := t.inputField.GetText()
			if strings.TrimSpace(message) != "" {
				// Append the message to the message view
				t.chatClient.SendMessage(t.chatClient.Sender.Id, message)
				t.inputField.SetText("")
				t.messageView.ScrollToEnd()
			}
		}
	})

	if err := t.app.SetRoot(flex, true).SetFocus(t.inputField).Run(); err != nil {
		panic(err)
	}
}

func (t *TUI) CreateLandingPage() {
	t.createFormPage()
}
