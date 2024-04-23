class MessageCreationRequest {
  final int recipientId;
  final String content;

  MessageCreationRequest({
    required this.recipientId,
    required this.content,
  });

  factory MessageCreationRequest.fromJson(Map<String, dynamic> json) {
    return MessageCreationRequest(
      recipientId: json['recipient_id'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipient_id': recipientId,
      'content': content,
    };
  }
}
