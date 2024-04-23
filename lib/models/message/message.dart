class Message {
  final int? messageId;
  final String content;
  final String senderId;
  final String receiverId;
  final int? conversationId;
  final DateTime? createdAt;

  Message({
    this.messageId,
    required this.content,
    required this.senderId,
    required this.receiverId,
    this.conversationId,
    this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['message_id'],
      content: json['content'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      conversationId: json['conversation_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'content': content,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'conversation_id': conversationId,
      'created_at': createdAt!.toIso8601String(),
    };
  }
}
