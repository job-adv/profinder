import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/models/message/message.dart';
import 'package:profinder/providers/conversations_provider.dart';
import 'package:profinder/services/message/message.dart';
import 'package:profinder/utils/constants.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/pages/messages/widgets/message_appbar.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatRoom extends StatefulWidget {
  final String user_id;
  final String firstname;
  final String lastname;
  final String pictureUrl;
  final bool available;
  final VoidCallback? onMessageSentOrReceived;

  const ChatRoom({
    Key? key,
    required this.user_id,
    required this.firstname,
    required this.lastname,
    required this.pictureUrl,
    required this.available,
    this.onMessageSentOrReceived,
  }) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late Future<List<Message>> _messages;

  final MessageService _messageService = MessageService();

  final TextEditingController _messageController = TextEditingController();
  String currentUserId = '';

  late Socket socket;

  @override
  void initState() {
    super.initState();
    loadUserId();
    _messages = _messageService.fetch(widget.user_id);
  }

  @override
  void dispose() {
    socket.disconnect();
    if (widget.onMessageSentOrReceived != null) {
      widget.onMessageSentOrReceived!();
    }
    super.dispose();
  }

  updateConversions() {
    final conversationsProvider =
        Provider.of<ConversationProvider>(context, listen: false);
    conversationsProvider.fetchConversations();
  }

  void loadUserId() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? jwtToken = await secureStorage.read(key: 'userId');

    setState(() {
      currentUserId = jwtToken ?? '';
    });

    initializeSocket();
  }

  void initializeSocket() {
    final String url = Constants.apiUrl;
    socket = io(
      url,
      OptionBuilder()
          .setQuery({'user_id': "$currentUserId"})
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    connectSocket();
  }

  void connectSocket() {
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      socket.on('newMessage', (data) {
        print('Received new message: $data');
        if (data != null && mounted) {
          setState(() {
            updateConversions();
            _messages = _addMessageToList(data);
          });
        }
      });
    });
    socket.onConnectError((error) {
      print('Connection error: $error');
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  Future<List<Message>> _addMessageToList(dynamic data) async {
    final List<Message> currentMessages = await _messages;
    final Message newMessage = Message(
      content: data['content'],
      senderId: data['sender_id'],
      receiverId: data['recipient_id'],
    );
    final List<Message> updatedMessages = List.from(currentMessages);
    updatedMessages.insert(
        0, newMessage); // Insert new message at the beginning
    return updatedMessages;
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    try {
      await _messageService.post({
        'recipient_id': widget.user_id,
        'content': content,
      });
      _messageController.clear();
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        userName: '${widget.firstname} ${widget.lastname}',
        profilePicUrl: '${widget.pictureUrl}',
        userStatus: widget.available,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Message>>(
              future: _messages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final messages = snapshot.data!;
                  return ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Align(
                        alignment: message.senderId != widget.user_id
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: message.senderId != widget.user_id
                                ? AppTheme.primaryColor
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            message.content,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  Expanded(
                    child: RoundedTextField(
                      controller: _messageController,
                      hintText: 'Message...',
                    ),
                  ),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: Icon(Icons.send),
                    color: AppTheme.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
