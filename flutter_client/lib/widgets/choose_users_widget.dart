import 'package:flutter/material.dart';
import 'package:meow/generated/chat.pbgrpc.dart';
import 'package:meow/grpc/conn.dart';
import 'package:get_it/get_it.dart';
import 'package:meow/widgets/chatting_page_widget.dart';

class UserListings extends StatefulWidget {
  const UserListings({super.key});
  @override
  State<UserListings> createState() => _UserListingsState();
}

class _UserListingsState extends State<UserListings> {
  @override
  Widget build(BuildContext context) {
    final chatService = GetIt.I<ChatService>();
    final userUpdateStream = chatService.getUsersStream();
    return  StreamBuilder(stream: userUpdateStream, builder: (context,snapshot){
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData) {
        return Text('No data yet.');
      }

      final response = snapshot.data!;
      final users = response.users;
      return Scaffold(
      appBar: AppBar(title: const Text('Choose users to chat')),  
      body: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                ...List.generate(users.length,(index) {
                  final listTile = Card(child: _ChooseUserCard(user: users[index]));
                  return listTile;
              }),
          ])
        )
      );
    });
  }
}

class _ChooseUserCard extends StatelessWidget {
  const _ChooseUserCard({required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return 
    Row(
      children: [
        SizedBox(width: 400, height: 80, child: 
        // leading: CircleAvatar(backgroundImage: AssetImage(user.avatarUrl)),
        ListTile( title: Text(user.username))),
        Row(
            mainAxisAlignment: MainAxisAlignment.end, 
            children: <Widget>[ElevatedButton(child: const Text('chat'), 
            onPressed: () async {
                final conv = await chatService.createConversation(user);
                final messageStream = await GetIt.I<ChatService>().getMessages(conv.id);
                final allMessages = messageStream!.messages;
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(conv: conv,allMessages: allMessages)
                ));
            },),
          ]
        ),
      ],
    ); 
  }
}

