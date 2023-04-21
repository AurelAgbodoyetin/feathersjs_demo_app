import 'package:feathersjs_demo_app/global.dart';

class Message {
  final String content;
  final bool isMe;
  final int? id;
  Message({
    required this.content,
    required this.isMe,
    this.id,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      content: map['message'] as String,
      isMe: random.nextBool(),
      id: map['id'] as int,
    );
  }

  @override
  String toString() => 'Message(id: $id, content: $content, isMe: $isMe)';
}
