import 'package:flutter/material.dart';
import 'package:profinder/models/message/conversation.dart';
import 'package:profinder/services/message/conversation.dart';

class ConversationProvider extends ChangeNotifier {
  final ConversationService _conversationService = ConversationService();
  List<Conversation> _conversations = [];
  List<Conversation> get conversations => _conversations;

  Future<void> fetchConversations() async {
    try {
      _conversations = await _conversationService.fetch();
      notifyListeners();
    } catch (error) {
      print('Error fetching conversations: $error');
    }
  }
}
