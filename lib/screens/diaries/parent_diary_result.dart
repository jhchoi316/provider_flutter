import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ParentResult extends StatefulWidget {
  @override
  _ParentResultState createState() => _ParentResultState();
}

class _ParentResultState extends State<ParentResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            "Parent Result 입니다.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
    );
  }
}
