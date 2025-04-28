package tui

import (
	"fmt"
	"log"
	"strings"

	"github.com/dulguunb/chatter-go/client/client_grpc/list_client"
	chatterPb "github.com/dulguunb/go-chatter/gen"
	"github.com/gdamore/tcell/v2"
	"github.com/rivo/tview"
)

type UserInterface interface {
	CreateLandingPage()
}
type UserInfo struct {
	Username string
	ServerIp string
}
type TUI struct {
	app           *tview.Application
	pages         *tview.Pages
	UserInfo      UserInfo
	userList      *tview.List
	clientService list_client.ListUsersService
}

var _ UserInterface = (*TUI)(nil)

func New() *TUI {
	app := tview.NewApplication()
	pages := tview.NewPages()
	return &TUI{
		UserInfo: UserInfo{
			Username: "",
			ServerIp: "",
		},
		app:      app,
		pages:    pages,
		userList: tview.NewList(),
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
		t.listUsers()
	}).AddButton("Quit", func() {
		t.app.Stop()
	})
	form.SetBorder(true).SetTitle("Enter some data").SetTitleAlign(tview.AlignLeft)
	if err := t.app.SetRoot(form, true).EnableMouse(true).Run(); err != nil {
		panic(err)
	}
	return form
}

func (t *TUI) listUsers() {
	clientService := list_client.New(t.UserInfo.Username, t.UserInfo.ServerIp)
	valid, err := clientService.ValidateTheConnection()
	if err != nil && valid {
		t.app.Stop()
		log.Fatal("IP address is wrong")
	}
	go clientService.ListUsersRequest()
	go func() {
		for {
			select {
			case resp := <-clientService.ListUserChan:
				newUsers := make(map[string]*chatterPb.UserInfo)
				for username, info := range resp.Users {
					user := t.clientService.Users[username]
					if user == nil {
						newUsers[username] = info
					}
				}
				t.clientService.Users = resp.Users
				go t.Redraw(newUsers)
			}
		}
	}()
	t.app.SetRoot(t.userList, true).EnableMouse(true).Run()
}

func (t *TUI) Redraw(users map[string]*chatterPb.UserInfo) {
	t.app.QueueUpdateDraw(func() {
		for username, _ := range users {
			t.userList.AddItem(username, "Press enter to chat", rune(0), func() {
				t.clientService.Partner = username
			})
		}
	})
}

func (t *TUI) CreateMessengerPage() {
	messageView := tview.NewTextView().
		SetDynamicColors(true).
		SetScrollable(true)
	messageView.SetBorder(true).SetTitle("Messages")
	inputField := tview.NewInputField().
		SetLabel("Enter message: ").
		SetFieldWidth(0) // Make the input field take up available width
	inputField.SetBorder(true)
	flex := tview.NewFlex().
		SetDirection(tview.FlexRow).
		AddItem(messageView, 0, 1, false). // Message view takes priority in height
		AddItem(inputField, 3, 1, true)    // Input field has a fixed height of 3 rows
	inputField.SetDoneFunc(func(key tcell.Key) {
		if key == tcell.KeyEnter {
			message := inputField.GetText()
			if strings.TrimSpace(message) != "" {
				// Append the message to the message view
				fmt.Fprintf(messageView, "%s\n", message)
				// Clear the input field
				inputField.SetText("")
				// Scroll to the bottom of the message view
				messageView.ScrollToEnd()
			}
		}
	})
	inputField.SetDoneFunc(func(key tcell.Key) {
		if key == tcell.KeyEnter {
			message := inputField.GetText()
			if strings.TrimSpace(message) != "" {
				// Append the message to the message view
				fmt.Fprintf(messageView, "%s\n", message)
				// Clear the input field
				inputField.SetText("")
				// Scroll to the bottom of the message view
				messageView.ScrollToEnd()
			}
		}
	})
	if err := t.app.SetRoot(flex, true).SetFocus(inputField).Run(); err != nil {
		panic(err)
	}
}

func (t *TUI) CreateLandingPage() {
	t.createFormPage()
}
