import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChildResult extends StatefulWidget {
  @override
  _ChildResultState createState() => _ChildResultState();
}

class _ChildResultState extends State<ChildResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Child Result 입니다.",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      )
    );
  }
}
