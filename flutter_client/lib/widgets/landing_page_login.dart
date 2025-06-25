import 'package:flutter/material.dart';
import 'package:meow/widgets/choose_users_widget.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(image, width: 600, height: 240, fit: BoxFit.cover);
  }
}

class LandingPageForum extends StatefulWidget {
  const LandingPageForum({super.key});
  @override
  State<LandingPageForum> createState() => _LandingPageForumState();
}

class _LandingPageForumState extends State<LandingPageForum> {
  final ipAddressController = TextEditingController();
  final usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ImageSection(image: 'images/avatar_1.jpg'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: ipAddressController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter IP address',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
            child: FloatingActionButton(
              onPressed: () {
                String combinedText = ipAddressController.text + usernameController.text;
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UserListings()));
              },
              child: const Icon(Icons.save)
            ),
        )
      ],
    );
  }
}