import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meow/grpc/conn.dart';
import 'package:meow/generated/chat.pbgrpc.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  ChatBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    if (message != ""){
        return Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              
              color: isMe ? Colors.blueAccent : Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              message,
              style: TextStyle(color: isMe ? Colors.white : Colors.black87),
            ),
          ),
        );
      }
      return Container();
    
  }
}

class ChatScreen extends StatefulWidget {
  final Conversation conv;
  final List<Message> allMessages;
  const ChatScreen({super.key,required this.conv,required this.allMessages});
  @override
  _ChatScreenState createState() => _ChatScreenState(conv: conv,allMessages: allMessages);
}

class _ChatScreenState extends State<ChatScreen> {
  final Conversation conv;
  List<Message> allMessages = [];
  _ChatScreenState({required this.conv,required this.allMessages});
  List<Message> messages = [];

  final TextEditingController controller = TextEditingController();
  void sendMessage() {
    if (controller.text.trim().isEmpty) return;
    chatService.sendMessage(controller.text.trim(),conv.id);
    controller.clear();    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Column(
        children: [
          // StreamBuilder here
          Expanded(
            child: StreamBuilder<GetMessagesResponse>(
              stream: GetIt.I<ChatService>().getMessagesStream(conv.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  allMessages = snapshot.data!.messages.reversed.toList();
                }
                // Reverse the list to match chat order
                return ListView.builder(
                  reverse: true,
                  itemCount: allMessages.length,
                  itemBuilder: (ctx, index) {
                    final message = allMessages[index];
                    return ChatBubble(
                      message: message.content,
                      isMe: chatService.isMe(message.senderId),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: "Type a message"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
