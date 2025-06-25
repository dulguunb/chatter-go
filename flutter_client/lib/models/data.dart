import 'models.dart';

User user_0 = User(
  name: const Name(first: 'Me', last: ''),
  avatarUrl: 'images/avatar_1.jpg',
  lastActive: DateTime.now(),
);
User user_1 = User(
  name: const Name(first: 'kittie1', last: 'kittie'),
  avatarUrl: 'images/avatar_2.jpg',
  lastActive: DateTime.now().subtract(const Duration(minutes: 10)),
);
User user_2 = User(
  name: const Name(first: 'kittie2', last: 'kittie'),
  avatarUrl: 'images/avatar_3.jpg',
  lastActive: DateTime.now().subtract(const Duration(minutes: 20)),
);
User user_3 = User(
  name: const Name(first: 'kittie3', last: 'kittie'),
  avatarUrl: 'images/avatar_4.jpg',
  lastActive: DateTime.now().subtract(const Duration(hours: 2)),
);
User user_4 = User(
  name: const Name(first: 'kittie4', last: 'kittie'),
  avatarUrl: 'images/avatar_5.jpg',
  lastActive: DateTime.now().subtract(const Duration(hours: 6)),
);
List<User> users  = [user_0,user_1,user_2,user_3,user_4];
