import 'package:profinder/models/message/conversation.dart';
import 'package:profinder/services/data.dart';

class ConversationService {
  final GenericDataService<Conversation> _genericService =
      GenericDataService<Conversation>('conversation', {
    'get': '',
  });

  Future<List<Conversation>> fetch() async {
    return _genericService.fetch((json) => Conversation.fromJson(json));
  }
}
