import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.content,
    required this.isMe,
    required this.username,
  });
  final String content;
  final bool isMe;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Text(
              username,
              style: const TextStyle(color: Color(0xFFF57F17)),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 2, offset: Offset(0, 1)),
              ],
              color: isMe ? const Color(0xFF1565C0) : Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(isMe ? 0 : 15),
                topLeft: Radius.circular(isMe ? 15 : 0),
                bottomLeft: const Radius.circular(15),
                bottomRight: const Radius.circular(15),
              ),
            ),
            child: Text(content,
                style: TextStyle(color: isMe ? Colors.white : Colors.black54)),
          ),
        ],
      ),
    );
  }
}
