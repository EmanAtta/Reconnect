
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reconnect/Views/Chat/Chat/Chat_service.dart';
import 'package:reconnect/Views/Chat/Component/chat_bubble.dart';
import 'package:reconnect/Views/Chat/Model/message.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/user_profile_screen.dart';

class ChatPage extends StatefulWidget {
  final String receivedUserID;
  final String receivedUserEmail;

  const ChatPage({
    Key? key,
    required this.receivedUserID,
    required this.receivedUserEmail,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? _receiverName;
  String? _receiverImageUrl;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchReceiverData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchReceiverData() async {
    try {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.receivedUserEmail)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        setState(() {
          _receiverName =
          '${userSnapshot.docs[0]['firstname']} ${userSnapshot.docs[0]['lastname']}';
          _receiverImageUrl = userSnapshot.docs[0]['imageUrl'];
        });
      }
    } catch (e) {
      print('Error fetching receiver data: $e');
    }
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      try {
        await _chatService.sendMessage(
          widget.receivedUserID,
          _messageController.text,
          widget.receivedUserEmail,
        );
        _messageController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send message: $e')));
      }
    }
  }

  Widget _buildMessageList() {
    final String currentUserEmail =
    _firebaseAuth.currentUser!.email.toString();
    return StreamBuilder<List<Message>>(
      stream: _chatService.getMessages(
          currentUserEmail, widget.receivedUserEmail),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No messages yet'));
        }

        WidgetsBinding.instance!.addPostFrameCallback((_) {
          // Scroll to the bottom of the list when it's built
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });

        return ListView.builder(
          controller: _scrollController,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return _buildMessageItem(snapshot.data![index]);
          },
        );
      },
    );
  }

  Widget _buildMessageItem(Message message) {
    final String currentUserEmail =
    _firebaseAuth.currentUser!.email.toString();

    bool isCurrentUserSender = message.senderEmail == currentUserEmail;
    var alignment = isCurrentUserSender
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          ChatBubble(
            message: message.message,
            senderEmail: message.senderEmail,
            receiverEmail: message.receiverEmail,
            isCurrentUser: isCurrentUserSender,
            timestamp: message.timestamp,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'Enter Message',
              ),
              maxLines: null, // Allows for multiple lines
              keyboardType: TextInputType.multiline, // Sets the keyboard type to multiline
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.send, size: 30, color: AppColors.secondaryColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        iconTheme: IconThemeData(
          color: AppColors.primaryColor,
        ),
        title: Row(
          children: [
            _receiverImageUrl != null
                ? CircleAvatar(
              backgroundImage: NetworkImage(_receiverImageUrl!),
              radius: 20,
            )
                : CircleAvatar(
              radius: 20,
              child: Icon(Icons.person),
            ),
            SizedBox(width: 8),
            TextButton(
              onPressed: () async {
                // Fetch user data again
                QuerySnapshot userSnapshot = await FirebaseFirestore.instance
                    .collection('users')
                    .where('email', isEqualTo: widget.receivedUserEmail)
                    .get();
                if (userSnapshot.docs.isNotEmpty) {
                  // Navigate to user profile screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfileScreen(
                        userPhotoUrl: _receiverImageUrl ?? '',
                        firstName: '${userSnapshot.docs[0]['firstname']}',
                        lastName: '${userSnapshot.docs[0]['lastname']}',
                        userEmail: widget.receivedUserEmail,
                      ),
                    ),
                  );
                }
              },
              child: Text(
                _receiverName ?? 'Loading...',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
