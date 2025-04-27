package tui

import (
	"fmt"
	"log"

	"github.com/dulguunb/chatter-go/client/client_grpc"
	chatterPb "github.com/dulguunb/go-chatter/gen"
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
	clientService client_grpc.ClientService
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
	clientService := client_grpc.New(t.UserInfo.Username, t.UserInfo.ServerIp)
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
			title := fmt.Sprintf("User: %s", username)
			t.userList.AddItem(title, "Press enter to chat", rune(0), func() {
			})
		}
	})
}

func (t *TUI) CreateLandingPage() {
	t.createFormPage()
}
