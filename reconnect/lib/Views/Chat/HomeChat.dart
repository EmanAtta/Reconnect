import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reconnect/Views/Chat/Chat/Chat_service.dart';
import 'package:reconnect/Views/Chat/Model/message.dart';
import 'package:reconnect/Views/Chat/Pages/ChatPage.dart';
import 'package:reconnect/Views/authentications/usermodle.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({super.key});

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";


  Future<Map<String, dynamic>?> _fetchUserData(String userEmail) async {
    try {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        return userSnapshot.docs[0].data() as Map<String, dynamic>;
      } else {
        print('No user found with email: $userEmail');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFFFE8D6),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search . . .',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                    });
                  },
                )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: _searchQuery.isEmpty
                ? UserList(
              user: user,
              fetchUserData: _fetchUserData,
            )
                : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final users = snapshot.data!.docs
                    .map((doc) => UserModel.fromSnapshot(
                    doc as DocumentSnapshot<Map<String, dynamic>>))
                    .where((user) => user.fullName.toLowerCase().contains(_searchQuery))
                    .toList();

                if (users.isEmpty) {
                  return const Center(child: Text('No users found.'));
                }

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return FutureBuilder<Map<String, dynamic>?>(
                      future: _fetchUserData(user.email),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData && snapshot.data != null) {
                            var userData = snapshot.data!;
                            return ListTile(
                              title: Text(
                                '${userData['firstname']} ${userData['lastname']}',
                              ),
                              subtitle: Text(user.email),
                              leading: userData['imageUrl'] != null
                                  ? CircleAvatar(
                                backgroundImage:
                                NetworkImage(userData['imageUrl']),
                              )
                                  : CircleAvatar(
                                radius: 20,
                                child: Icon(Icons.person),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                      receivedUserID: user.id!,
                                      receivedUserEmail: user.email,
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return ListTile(
                              title: Text('User data not found'),
                              subtitle: Text(user.email),
                            );
                          }
                        } else {
                          return ListTile(
                            title: Text('Loading...'),
                            subtitle: Text(user.email),
                            leading: const CircularProgressIndicator(),
                          );
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserList extends StatefulWidget {
  final User? user;
  final Future<Map<String, dynamic>?> Function(String) fetchUserData;

  const UserList({super.key, required this.user, required this.fetchUserData});

  @override
  _UserListState createState() => _UserListState();
}


class _UserListState extends State<UserList> {
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Receiver_Emails')
          .doc(user?.email)
          .collection('Emails')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final users = snapshot.data!.docs
            .map((doc) => UserModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>))
            .toList();

        if (users.isEmpty) {
          return const Center(child: Text('No users found.'));
        }

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return FutureBuilder<Map<String, dynamic>?>(
              future: widget.fetchUserData(user.email),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data != null) {
                    var userData = snapshot.data!;
                    return StreamBuilder<Message?>(
                      stream: _chatService.getLastMessage(
                          FirebaseAuth.instance.currentUser!.email!,
                          user.email),
                      builder: (context, messageSnapshot) {
                        if (messageSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListTile(
                            title: Text('Loading...'),
                            subtitle: Text(user.email),
                          );
                        }

                        final lastMessage = messageSnapshot.data;
                        final messageText =
                            lastMessage?.message ?? 'No messages';
                        final messageTime = lastMessage != null
                            ? DateFormat('yyyy-MM-dd, HH-mm')
                            .format(lastMessage.timestamp.toDate())
                            : '';
                        // Determine if the last message is from the current user
                        final isLastMessageFromCurrentUser =
                            lastMessage?.senderEmail ==
                                FirebaseAuth.instance.currentUser!.email;

                        return ListTile(
                          title: Text(
                            '${userData['firstname']} ${userData['lastname']}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                messageText,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),


                              Spacer(),
                              Text(
                                messageTime,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          leading: userData['imageUrl'] != null
                              ? CircleAvatar(
                            radius: 22,
                            backgroundImage:
                            NetworkImage(userData['imageUrl']),
                          )
                              : CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  receivedUserID: user.id!,
                                  receivedUserEmail: user.email,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return ListTile(
                      title: Text('User data not found'),
                      subtitle: Text(user.email),
                    );
                  }
                } else {
                  return ListTile(
                    title: Text('Loading...'),
                    subtitle: Text(user.email),
                    leading: const CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
