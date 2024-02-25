import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//통신 import
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../providers/provider_home.dart';


class Conversation extends StatefulWidget {
  const Conversation({super.key});

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> with TickerProviderStateMixin {

  late TabController diaryTabController; // 탭 컨트롤러 선언

  @override
  void initState() {
    super.initState();
    diaryTabController = TabController(length: 2, vsync: this);
    diaryTabController.addListener(_onTabChanged); // 탭 변경 이벤트 추가

  }

  // 탭 변경 이벤트
  void _onTabChanged() {
    setState(() {}); // 화면을 다시 그려줌
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // final DateTime? _selectedDate = context.read<Move>().getSeledtedDate();

    context.watch<ProviderHome>();


    // URL: /home/conversation
    // 프론트 -> 백: date = _selectedDate, pid = '0'
    // 백 -> 프론트: 부모+아이 일기 미리보기(교정본,이미지url) 캐릭터 url
    // showParentCorrectedText = ''
    // showParentTranslatedText = ''
    // parentCorrectedDiary[0]~parentCorrectedDiary.length
    // parentTranslatedDiary[0]~parentTranslatedDiary.length

    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBar(
              scrolledUnderElevation: 0,
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              backgroundColor: Colors.white,
              title: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(text: '일기장\nthống kê bố mẹ', style: TextStyle(color: Color(0xFF8DBFD2),fontSize: 17,fontFamily: 'KNU_TRUTH'),),
                ),
              ),
            ),

            //부모 일기 아이 일기 탭
            Container(
              color: Colors.white,
              child: TabBar(
                controller: diaryTabController,

                onTap: (index) {
                  setState(() {});
                },

                labelColor: Colors.black,
                unselectedLabelColor: Color(0xff8B8B8B),
                tabs: const [
                  Tab(
                    child: Text(
                      '부모\nhật ký của bố',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'KNU_TRUTH'
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      '아이\nnhật ký trẻ con',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'KNU_TRUTH'
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(

              child: Container(
                color: Color(0xFF8DBFD2),
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      SizedBox(height: height * 0.01,),
                      //오늘 날짜
                      Text(
                          DateFormat('yyyy년 MM월 dd일 EEEE').format(DateTime.now()),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:15,
                              fontFamily: 'KNU_TRUTH'
                          )
                      ),
                      SizedBox(height: height * 0.01,),

                      //일기 보여줄 부분
                      Container(
                          padding: EdgeInsets.only(top: height * 0.02),
                          width:  width * 0.9,
                          height: height * 0.85,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),


                          child: TabBarView(
                            controller: diaryTabController,
                            children: <Widget>[

                              //부모 탭 일기
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    //사진
                                    // SizedBox(height: height * 0.02,),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: height * 0.02),
                                      // 사진 크기 조절
                                      width: width * 0.75,
                                      height: width * 0.6,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          // 여기에 parentImageUrl 표시
                                          // '${parentImageUrl}',
                                          'https://as1.ftcdn.net/v2/jpg/04/22/49/54/1000_F_422495424_AkP6hAHiYBhNxZ3kZUBuYouedhej37a3.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02,),
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(width: width * 0.05),
                                              Icon(
                                                Icons.arrow_drop_down,
                                                color: Color(0xFF8DBFD2),
                                              ),

                                              Text(
                                                '변경된 일기',
                                                style: TextStyle(fontSize: height * 0.02, color: Color(0xFF8DBFD2),fontFamily: 'KNU_TRUTH'),
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
                                                      width: width * 0.75,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(width * 0.05),
                                                        border: Border.all(color: Color(0xFF8DBFD2)),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          // 박스 내부 위 간격
                                                          SizedBox(height: height * 0.02),
                                                          Row(
                                                            children: [
                                                              SizedBox(width: width * 0.05),
                                                              Container(
                                                                width: width * 0.645,
                                                                // Text 박스 사이즈 변경
                                                                height: 6 * (height * 0.02 * 1.2),
                                                                child: SingleChildScrollView(
                                                                  child: Text(
                                                                    // 여기에 parentCorrectedText + parentTranslatedText 표시
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
                                          // 작성된 일기 보여주는 Container 부분
                                          SizedBox(height: height * 0.02,),
                                          Row(
                                            children: [
                                              SizedBox(width: width * 0.05),
                                              Icon(
                                                Icons.arrow_drop_down,
                                                color: Color(0xFF8DBFD2),
                                              ),

                                              Text(
                                                '작성한 일기',
                                                style: TextStyle(fontSize: height * 0.02, color: Color(0xFF8DBFD2),fontFamily: 'KNU_TRUTH'),
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
                                                      width: width * 0.75,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(width * 0.05),
                                                        border: Border.all(color: Color(0xFF8DBFD2)),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          // 박스 내부 위 간격
                                                          SizedBox(height: height * 0.02),
                                                          Row(
                                                            children: [
                                                              SizedBox(width: width * 0.05),
                                                              Container(
                                                                width: width * 0.645,
                                                                // Text 박스 사이즈 변경
                                                                height: 6 * (height * 0.02 * 1.2),
                                                                child: SingleChildScrollView(
                                                                  child: Text(
                                                                    // 여기에 childCorrectedText + childTranslatedText 표시
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
                                          SizedBox(height: height * 0.03),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //아이 탭 일기
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  //사진
                                  SizedBox(height: height * 0.02,),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: height * 0.02),
                                    // 사진 크기 조절
                                    width: width * 0.7,
                                    height: width * 0.9,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        // 여기에 childImageUrl 표시
                                        'https://as1.ftcdn.net/v2/jpg/04/22/49/54/1000_F_422495424_AkP6hAHiYBhNxZ3kZUBuYouedhej37a3.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02,),
                                  Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: width * 0.05),
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color: Color(0xFF8DBFD2),
                                            ),

                                            Text(
                                              '변경된 일기',
                                              style: TextStyle(fontSize: height * 0.02, color: Color(0xFF8DBFD2),fontFamily: 'KNU_TRUTH'),
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
                                                    width: width * 0.75,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(width * 0.05),
                                                      border: Border.all(color: Color(0xFF8DBFD2)),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        // 박스 내부 위 간격
                                                        SizedBox(height: height * 0.02),
                                                        Row(
                                                          children: [
                                                            SizedBox(width: width * 0.05),
                                                            Container(
                                                              width: width * 0.645,
                                                              // Text 박스 사이즈 변경
                                                              height: 9 * (height * 0.02 * 1.2),
                                                              child: SingleChildScrollView(
                                                                child: Text(
                                                                  // 여기에 childCorrectedText + childTranslatedText 표시
                                                                  // 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트, 줄 바꿈 테스트,
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
                                        SizedBox(height: height * 0.03,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),

                      // 생성된 캐릭터
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _showImagePopupParent(context);
                            },
                            child: Image.asset(
                              // 여기에 parentCharacterUrl 표시
                            'assets/imageP.png',
                              width: 150,
                              height: 250,
                            ),
                          ),

                          SizedBox(width: 50),

                          InkWell(
                            onTap: () {
                              _showImagePopupChild(context);
                            },
                            child: Image.asset(
                              // 여기에 childCharacterUrl 표시
                            'assets/imageC.png',
                              width: 150,
                              height: 250,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}

void _showImagePopupParent(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      //수정: 캐릭터 위치에 맞춰서 말풍선 위치 설정되도록 변경해보기
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Stack(
          children: [
            Image.asset(
            'assets/conv_parent_question.png',
            ),
            Positioned.fill(
                child: Center(
                  // 여기에 parentQuestion 표시
                child: Text('어떤 요리를 가장 좋아해?',
                    style: TextStyle(fontSize: 20,fontFamily: 'KNU_TRUTH'),
                  ),
                )
            )
          ],
        ),
      );
    },
  );
}

void _showImagePopupChild(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Stack(
          children: [
            Image.asset(
              'assets/conv_child_question.png',
            ),
            Positioned.fill(
                child: Center(
                  child: Text(
                    // 여기에 childQuestion 표시
                  '뭘 만들었는지 말해줘!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20,fontFamily: 'KNU_TRUTH'),
                  ),
                )
            )
          ],
        ),
      );
    },
  );
}