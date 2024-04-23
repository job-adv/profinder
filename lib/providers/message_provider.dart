import 'package:flutter/material.dart';
import 'package:profinder/models/message/message.dart';
import 'package:profinder/services/message/message.dart';

class MessageProvider extends ChangeNotifier {
  final MessageService _messageService = MessageService();
  List<Message> _messages = [];
  List<Message> get messages => _messages;

  Future<void> fetchMessages(String otheruser) async {
    try {
      _messages = await _messageService.fetch(otheruser);
      notifyListeners();
    } catch (error) {
      print('Error fetching messages: $error');
    }
  }

  Future<void> sendMessage(
      Map<String, dynamic> messageData, String otherUser) async {
    try {
      await _messageService.post(messageData);
      fetchMessages(otherUser);
    } catch (error) {
      print('Error sending message: $error');
    }
  }
}
