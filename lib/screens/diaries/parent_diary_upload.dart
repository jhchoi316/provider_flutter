import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ParentUpload extends StatefulWidget {
  @override
  _ParentUploadState createState() => _ParentUploadState();
}

class _ParentUploadState extends State<ParentUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            "Parent Upload 입니다.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
    );
  }
}
