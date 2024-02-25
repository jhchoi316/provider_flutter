import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Conversation extends StatefulWidget {
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            "Converstaion 입니다.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
    );
  }
}
