import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChildCamera extends StatefulWidget {
  @override
  _ChildCameraState createState() => _ChildCameraState();
}

class _ChildCameraState extends State<ChildCamera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            "Child Camera 입니다.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
    );
  }
}
