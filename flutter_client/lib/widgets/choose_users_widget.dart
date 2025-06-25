import 'package:flutter/material.dart';
import 'package:meow/models/data.dart';

class UserListings extends StatefulWidget {
  const UserListings({super.key});
  @override
  State<UserListings> createState() => _UserListingsState();
}


class _UserListingsState extends State<UserListings> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(title: const Text('Choose users to chat')),  
    body: Center(
          child: Column(          
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              ...List.generate(users.length,(index) {
                final listTile = Card(child: _ChooseUserCard(avatarUrl: users[index].avatarUrl, username: users[index].name.fullName));
                return listTile;
            }),
        ])
      )
    );
  }
}

class _ChooseUserCard extends StatelessWidget {
  const _ChooseUserCard({required this.avatarUrl,required this.username});
  final String avatarUrl;
  final String username;

  @override
  Widget build(BuildContext context) {
    return 
    Row(
      children: [
        SizedBox(width: 400, height: 80, child: 
        ListTile(leading: CircleAvatar(backgroundImage: AssetImage(avatarUrl)), title: Text(username))),
        Row(
            mainAxisAlignment: MainAxisAlignment.end, 
            children: <Widget>[ElevatedButton(child: const Text('chat'),onPressed: () {
            },),
          ]
        ),
      ],
    );
    
    
  }
}

