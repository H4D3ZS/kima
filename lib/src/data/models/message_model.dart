class Message {
  final String senderId;
  final String senderName;
  final String message;
  final String receiverId;
  final String receiverName;
  final String timestamp;
  final bool isHiddenUser1;
  final bool isHiddenUser2;
  final bool isReadUser1;
  final bool isReadUser2;

  Message({
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.receiverId,
    required this.receiverName,
    required this.timestamp,
    required this.isHiddenUser1,
    required this.isHiddenUser2,
    required this.isReadUser1,
    required this.isReadUser2,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'message': message,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'timestamp': timestamp,
      'isHiddenUser1': isHiddenUser1,
      'isHiddenUser2': isHiddenUser2,
      'isReadUser1': isReadUser1,
      'isReadUser2': isReadUser2,
    };
  }
}
