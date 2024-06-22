import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reconnect/Views/Chat/Chat/Chat_service.dart';
import 'package:reconnect/Views/Chat/Model/message.dart';
import 'package:reconnect/Views/Chat/Pages/ChatPage.dart';
import 'package:reconnect/Views/authentications/usermodle.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({Key? key}) : super(key: key);

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool isChecked = false;

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

  void _clearSearchField() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
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
              key: UniqueKey(), // Ensure key is unique
              user: user,
              fetchUserData: _fetchUserData,
              isChecked: isChecked,
              toggleSearch: () {
                setState(() {
                  isChecked = !isChecked;
                });
              },
              clearSearchField: _clearSearchField,
            )
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                final users = snapshot.data!.docs
                    .map((doc) => UserModel.fromSnapshot(
                    doc as DocumentSnapshot<Map<String, dynamic>>))
                    .where((user) => user.fullName
                    .toLowerCase()
                    .contains(_searchQuery))
                    .toList();

                if (users.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/chat.png',
                          width: 100,
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "You don't have any chat messages yet , tap to connect with others",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                        ),
                        const Text(
                          'Your chat list will be shown here .. ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                      ],
                    ),
                  );
                }

                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return FutureBuilder<Map<String, dynamic>?>(
                            future: _fetchUserData(user.email),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  var userData = snapshot.data!;
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          '${userData['firstname']} ${userData['lastname']}',
                                        ),
                                        subtitle: Text(user.email),
                                        leading: userData['imageUrl'] != null
                                            ? CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    userData['imageUrl']),
                                              )
                                            : const CircleAvatar(
                                                radius: 20,
                                                child: Icon(Icons.person),
                                              ),
                                        onTap: () {
                                          _clearSearchField(); // Clear search field
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
                                      ),
                                      const Divider(
                                        height: 1,
                                        thickness: 0.7,
                                        color: Colors.grey,
                                        indent: 50,
                                        endIndent: 50,
                                      ),
                                    ],
                                  );
                                } else {
                                  return ListTile(
                                    title: const Text('User data not found'),
                                    subtitle: Text(user.email),
                                  );
                                }
                              } else {
                                return ListTile(
                                  title: const Text('Loading...'),
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
  final bool isChecked;
  final Function toggleSearch;
  final Function clearSearchField;
  final Future<Map<String, dynamic>?> Function(String) fetchUserData;

  const UserList({
    Key? key,
    required this.user,
    required this.isChecked,
    required this.toggleSearch,
    required this.clearSearchField,
    required this.fetchUserData,
  }) : super(key: key);

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
          return const Center(child: CircularProgressIndicator(color: AppColors.labelStyle));
        }

        final users = snapshot.data!.docs
            .map((doc) => UserModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>))
            .toList();

        if (users.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/chat.png',
                  width: 100,
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    " You don't have any chat messages yet , tap to connect with others ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
                const Text(
                  'Your chat list will be shown here .. ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontFamily: 'Times New Roman',
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Column(
              children: [
                ListTile(
                  title: FutureBuilder<Map<String, dynamic>?>(
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
                                  title: const Text('Loading...'),
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
                              final isLastMessageFromCurrentUser =
                                  lastMessage?.senderEmail ==
                                      FirebaseAuth.instance.currentUser!.email;

                              return ListTile(
                                title: Text(
                                  '${userData['firstname']} ${userData['lastname']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      messageText,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Spacer(),
                                    Text(
                                      messageTime,
                                      style: const TextStyle(
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
                                    : const CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.person),
                                ),
                                onTap: () {
                                  widget
                                      .clearSearchField(); // Clear search field
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
                            title: const Text('User data not found'),
                            subtitle: Text(user.email),
                          );
                        }
                      } else {
                        return ListTile(
                          title: const Text('Loading...'),
                          subtitle: Text(user.email),
                          leading: const CircularProgressIndicator(color: AppColors.labelStyle),
                        );
                      }
                    },
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 0.7,
                  color: Colors.grey,
                  indent: 50,
                  endIndent: 50,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
