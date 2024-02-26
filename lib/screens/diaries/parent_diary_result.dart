import 'package:Front_Flutter/screens/providers/provider_parent_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class ParentResult extends StatefulWidget {
  const ParentResult({Key? key}) : super(key: key);

  @override
  _ParentResultState createState() => _ParentResultState();
}

class _ParentResultState extends State<ParentResult> {


  Widget showImage() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.45,
      child: Container(
        child: Image.asset(
            'assets/example0.png',
            fit: BoxFit.cover
          // 클릭하면 이미지만 확인하게 하는 코드 추가
        ),
      ),
    );
  }

  Widget showDiary() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      // color: const Color(0xFF8DBFD2),
      child: Column(
        children: [
          Container(
            color: const Color(0xFF8DBFD2),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: height * 0.02),
                    Row(
                      children: [
                        SizedBox(width: width * 0.05),
                        Text(
                            DateFormat('yyyy년 MM월 dd일 EEEE').format(DateTime.now()),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
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
                              "엄마의 일기",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height * 0.04,
                                  fontFamily: 'KNU_TRUTH'
                              )
                          ),
                        ]
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      children: [
                        SizedBox(width: width * 0.05),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),

                        Text(
                          '변경된 일기',
                          style: TextStyle(fontSize: height * 0.02, color: Colors.white, fontFamily: 'KNU_TRUTH'
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.01),
                    // 변경된 일기 보여주는 Container 부분
                    Row(
                        children: [
                          SizedBox(width: width * 0.05),
                          Row(
                            children: [
                              SizedBox(width: width * 0.02),
                              Container(
                                width: width * 0.86,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(width * 0.05),
                                ),
                                child: Column(
                                  children: [
                                    // 박스 내부 위 간격
                                    SizedBox(height: height * 0.02),
                                    Row(
                                      children: [
                                        SizedBox(width: width * 0.05),
                                        Container(
                                          width: width * 0.76,
                                          // Text 박스 사이즈 변경
                                          height: 7 * (height * 0.02 * 1.2),
                                          child: SingleChildScrollView(
                                            child: Text(
                                              //
                                              '줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트,',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.02,
                                                  fontFamily: 'KNU_TRUTH'

                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: width * 0.05), // 오른쪽 간격
                                      ],
                                    ),
                                    // 박스 내부 아래 간격
                                    SizedBox(height: height * 0.02),
                                  ],
                                ),

                              ),
                              SizedBox(width: width * 0.02),
                            ],
                          ),
                          SizedBox(width: width * 0.05)
                        ]
                    ),

                    SizedBox(height: height * 0.02),
                    Row(
                      children: [
                        SizedBox(width: width * 0.05),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),

                        Text(
                          '작성한 일기',
                          style: TextStyle(fontSize: height * 0.02, color: Colors.white,fontFamily: 'KNU_TRUTH'),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.01),
                    // 변경된 일기 보여주는 Container 부분
                    Row(
                        children: [
                          SizedBox(width: width * 0.05),
                          Row(
                            children: [
                              SizedBox(width: width * 0.02),
                              Container(
                                width: width * 0.86,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(width * 0.05),
                                ),
                                child: Column(
                                  children: [
                                    // 박스 내부 위 간격
                                    SizedBox(height: height * 0.02),
                                    Row(
                                      children: [
                                        SizedBox(width: width * 0.05),
                                        Container(
                                          width: width * 0.76,
                                          // Text 박스 사이즈 변경
                                          height: 7 * (height * 0.02 * 1.2),
                                          child: SingleChildScrollView(
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.02,
                                                  fontFamily: 'KNU_TRUTH'
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: width * 0.05), // 오른쪽 간격
                                      ],
                                    ),
                                    // 박스 내부 아래 간격
                                    SizedBox(height: height * 0.02),
                                  ],
                                ),
                              ),
                              SizedBox(width: width * 0.02),
                            ],
                          ),
                          SizedBox(width: width * 0.05)
                        ]
                    ),
                    SizedBox(height: height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: width * 0.02),
                        goToHome(),
                        writeDone(),
                        SizedBox(width: width * 0.02),
                      ],
                    ),
                    SizedBox(height: height * 0.05),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }

  Widget writeDone() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.4,
      height: height * 0.08,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(60.0),
      ),
      child: TextButton(
        onPressed: () {
          context.go('/childCamera');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '아이 일기 작성',
              style: TextStyle(color: Colors.white, fontSize: height * 0.023,fontFamily: 'KNU_TRUTH'),
            ),
            SizedBox(width: 0),
            Text(
              'Viết nhật ký',
              style: TextStyle(color: Colors.white, fontSize: height * 0.015,fontFamily: 'KNU_TRUTH'),
            ),
          ],
        ),
      ),
    );
  }

  Widget goToHome() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.4,
      height: height * 0.08,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(60.0),
      ),
      child: TextButton(
        onPressed: () {
          context.go('/home');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '홈으로 가기',
              style: TextStyle(color: Colors.white, fontSize: height * 0.023,fontFamily: 'KNU_TRUTH'),
            ),
            SizedBox(width: 0),
            Text(
              'Đi đến trang chủ',
              style: TextStyle(color: Colors.white, fontSize: height * 0.015,fontFamily: 'KNU_TRUTH'),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    context.watch<ProviderParentUpload>();

    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      // 키보드 overflow 방지
      // resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfff4f3f9),
        body: Expanded(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  showImage(),
                  showDiary(),
                ],
              ),
            ),
          ),

        )
    );
  }
}
