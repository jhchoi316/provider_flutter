import 'package:Front_Flutter/screens/providers/provider_child_camera.dart';
import 'package:Front_Flutter/screens/providers/provider_parent_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/provider_home.dart';


class ChildResult extends StatefulWidget {
  const ChildResult({Key? key}) : super(key: key);

  @override
  _ChildResultState createState() => _ChildResultState();
}

class _ChildResultState extends State<ChildResult> {
  bool _isLoading = false; // Add this line to track loading state

  Widget showImage() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    late String? imageUrl = context.read<ProviderChildCamera>().getImageUrl();

    return Container(
      width: width,
      height: height * 0.45,
      child: Container(
        child: Image.network(
          '$imageUrl',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget showDiary() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    late String? changedText = context.read<ProviderChildCamera>().getChangedText();

    context.read<ProviderParentUpload>().getChangedText();
    return Container(
      color: Colors.white,
      width: width,
      height: height * 0.55,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.02),
          Row(
            children: [
              SizedBox(width: width * 0.05),
              Text(
                  DateFormat('yyyy년 MM월 dd일 EEEE').format(DateTime.now()),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xff787B7D),
                      fontSize: height * 0.02,
                      fontFamily: 'KNU_TRUTH'
                  )
              ),
            ],
          ),
          Row(
              children: [
                SizedBox(width: width * 0.05),
                Text(
                    "아이의 일기",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color(0xff787B7D),
                        fontSize: height * 0.04,
                        fontFamily: 'KNU_TRUTH'
                    )
                ),
              ]
          ),
          SizedBox(height: height * 0.02),

          // 변경된 일기 보여주는 Container 부분
          Container(
            // 위아래 height * 0.02, 옆 width * 0.05
            padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width * 0.05),
            width: width * 0.865,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.05),
              border: Border.all(color: Color(0xff8DBFD2)),
            ),
            child: Container(
              //width: width * 0.76,
              // Text 박스 사이즈 변경
              height: 8 * (height * 0.02 * 1.2),
              child: SingleChildScrollView(
                child: Text(
                  // 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트,
                      '$changedText',
                      style: TextStyle(
                      color: Colors.black,
                      fontSize: height * 0.02,
                      fontFamily: 'KNU_TRUTH'
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: width * 0.02),
              writeDone(),
              SizedBox(width: width * 0.02),
            ],
          ),
        ],
      ),

    );
  }

  Widget writeDone() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.8,
      height: height * 0.08,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xff8DBFD2),
        borderRadius: BorderRadius.circular(60.0),
      ),
      child: TextButton(
        onPressed: () async {
          setState(() {
            _isLoading = true; // Set isLoading to true when login button is pressed
          });
          context.read<ProviderHome>().setSelectedDate(DateTime.now());
          await context.read<ProviderHome>().setData();
          print("Child Result $_isLoading");

          setState(() {
            context.go('/conversation');
            _isLoading = false; // Set isLoading to false after setData finishes
          });
        },

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '소통하러 가기',
              style: TextStyle(color: Colors.white, fontSize: height * 0.023,fontFamily: 'KNU_TRUTH'),
            ),
            SizedBox(width: 0),
            Text(
              'Quay hình xong',
              style: TextStyle(color: Colors.white, fontSize: height * 0.013,fontFamily: 'KNU_TRUTH'),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    context.watch<ProviderChildCamera>();
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      // 키보드 overflow 방지
      // resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfff4f3f9),
        body: _isLoading ?
        Center(child: CircularProgressIndicator()) :
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              showImage(),
              showDiary(),
            ],
          ),
        )
    );
  }
}
