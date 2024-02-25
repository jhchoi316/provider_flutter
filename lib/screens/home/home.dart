import 'package:Front_Flutter/screens/providers/provider_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // 날짜 형식을 사용하기 위한 패키지


//통신 import
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  DateTime _selectedDate = DateTime.now();
  // DateTime _selectedDate = DateTime(2024,02,18);
  final Map<DateTime, bool> _markedDates = {
    DateTime(2024,02,02) : true,
    DateTime(2024,02,04) : true,
    DateTime(2024,02,06) : true,
    DateTime(2024,02,08) : true,
    DateTime(2024,02,10) : true,
    DateTime(2024,02,12) : true,
    DateTime(2024,02,14) : true,
    DateTime(2024,02,16) : true,
    DateTime(2024,02,18) : true,
    DateTime(2024,02,20) : true,
    DateTime(2024,02,22) : true,
    DateTime(2024,02,24) : true,
    DateTime(2024,02,26) : true,
  };

  Widget calendar() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height* 0.55,
      //padding: EdgeInsets.all(width*0.05), // 위젯 내부 여백을 설정합니다.
      child: Column(
        children: [
          SizedBox(width: width,height: height*0.04),
          calendarHeader(),   //height: height* 0.07
          calendarWeekdays(),//height: height* 0.04
          calendarDays(), //height: height*0.4,

        ],
      ),
    );
  }

  Widget calendarHeader() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.07,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              setState(() {
                _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, 1);
              });
            },
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '${DateFormat('yyyy').format(_selectedDate)}\n${DateFormat('MMMM').format(_selectedDate)}',
              style: GoogleFonts.jua(
                fontSize: height * 0.03,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            color: Colors.white,
            onPressed: () {
              setState(() {
                _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget calendarWeekdays() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width*0.96,
      height: height * 0.04,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('S',
              style: GoogleFonts.jua(
                fontSize: height * 0.025,
                color: Colors.white,
              ),
            ),
            Text('M',
              style: GoogleFonts.jua(
                fontSize: height * 0.025,
                color: Colors.white,
              ),
            ),
            Text('T',
              style: GoogleFonts.jua(
                fontSize: height * 0.025,
                color: Colors.white,
              ),
            ),
            Text('W',
              style: GoogleFonts.jua(
                fontSize: height * 0.025,
                color: Colors.white,
              ),
            ),
            Text('T',
              style: GoogleFonts.jua(
                fontSize: height * 0.025,
                color: Colors.white,
              ),
            ),
            Text('F',
              style: GoogleFonts.jua(
                fontSize: height * 0.025,
                color: Colors.white,
              ),
            ),
            Text('S',
              style: GoogleFonts.jua(
                fontSize: height * 0.025,
                color: Colors.white,
              ),
            ),

          ]
      ),
    );
  }

  Widget calendarDays() {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // List<dynamic>? completedList = context.read<ProviderLogIn>().getCompleteListData();
    // print(completedList);

    return Container(
      width: width*0.96,
      height: height*0.4,

      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(), // 스크롤 x
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, // 한 줄에 7개의 요일을 표시
        ),
        itemCount: DateTime.daysPerWeek * 5, // 5주를 표시
        itemBuilder: (context, index) {

          final currentDate = DateTime(_selectedDate.year, _selectedDate.month, index + 1 - DateTime(_selectedDate.year, _selectedDate.month, 1).weekday);

          final isToday = currentDate.year == DateTime.now().year &&
              currentDate.month == DateTime.now().month &&
              currentDate.day == DateTime.now().day;

          // 선택된 날짜의 여부를 확인합니다.
          final isSelected = currentDate.year == _selectedDate.year &&
              currentDate.month == _selectedDate.month &&
              currentDate.day == _selectedDate.day;
          final writeDiary = _markedDates[currentDate] ?? false;

          // 전달과 다음달의 날짜인지 확인합니다.
          final isOutsideMonth = currentDate.month != _selectedDate.month;

          if (isOutsideMonth) {
            return Container(
              width: width*0.08,
              height: height*0.9,
            );
          }

          return GestureDetector(
            onTap: () {
              // print("날짜 선택");
              print(currentDate);
              setState(() {
                _selectedDate = currentDate;
              });
              // URL: /home/selectedDate
              // 프론트 -> 백: date = _selectedDate, pid = '0'
              // 백 -> 프론트: 해당 날짜 부모+아이 일기 미리보기(교정본,이미지url)
              print('GestureDector GET');
            },
            child: Container(
              width: width*0.08,
              //height: height*0.1,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // 일기를 작성한 날짜인 경우 다소리 표시하기
                  if (writeDiary)
                    Image.asset(
                      'assets/dasol.png',
                      width: width*0.07,
                      height: width*0.07,
                    ),
                  if (!writeDiary)
                    Container(
                      width: width*0.07,
                      height: width*0.07,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                    ),
                  Text(
                    '${currentDate.day}',
                    style: GoogleFonts.jua(
                        fontSize: width*0.025,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white :Colors.black
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }




  Widget diaryCard() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        // 선택된 날짜 넘겨주기
        // context.read<Move>().setSelectedDate(_selectedDate);
        // context.read<Move>().moveTo(1);
      },
      child: Container(
        height: height * 0.45,
        //padding: EdgeInsets.symmetric(vertical:height*0.01, horizontal: width*0.04),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: height*0.005, horizontal: width*0.05),
              width: width,
              height: height*0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Diary",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.jua(
                          color: Color(0xFF8DBFD2),
                          fontSize: height * 0.028,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    DateFormat('yyyy / MM / dd (E) ').format(_selectedDate ?? DateTime.now()),
                    textAlign: TextAlign.end,
                    style: GoogleFonts.jua(
                      color: Color(0xFF8DBFD2),
                      fontSize:20,
                    ),
                  ),
                ],
              ),
            ),
            parentDiaryCard(), // height: height*0.2,
            childDiaryCard() // height: height*0.2,
          ],
        ),
      ),
    );
  }

  // 부모 일기 카드
  Widget parentDiaryCard() {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final selectedDateInfo = DateFormat('yyyy년 MM월 dd일').format(_selectedDate); // 선택된 날짜의 정보를 포맷합니다.
    final isDiaryWritten = _markedDates[_selectedDate] ?? false; // 선택된 날짜에 일기가 쓰여있는지 확인합니다.
    print(_markedDates);
    print(isDiaryWritten);

    return Container(
      width: width*0.96,
      height: height*0.15,

      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Color(0xFF8DBFD2), width: 2),
        ),
        child: Padding(
          padding: EdgeInsets.all(height*0.01,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(height*0.01,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(
                      '부모의 일기',
                      style: GoogleFonts.jua(
                        color: Color(0xff3B3B3B),
                        fontSize:  height*0.023,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      isDiaryWritten ? '일기가 쓰여 있는 날' : '일기가 쓰여 있지 않아요',
                      style: GoogleFonts.jua(
                        fontSize: height*0.02,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * 0.25,
                height: width * 0.25,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.network(
                  'https://as1.ftcdn.net/v2/jpg/04/22/49/54/1000_F_422495424_AkP6hAHiYBhNxZ3kZUBuYouedhej37a3.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 아이 일기 카드
  Widget childDiaryCard() {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final selectedDateInfo = DateFormat('yyyy년 MM월 dd일').format(_selectedDate);
    final isDiaryWritten = _markedDates[_selectedDate] ?? false;

    return Container(
      width: width*0.96,
      height: height*0.15,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Color(0xFF8DBFD2), width: 2),
        ),

        child: Padding(
          padding: EdgeInsets.all(height*0.01,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(height*0.01,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '아이의 일기',
                      style: GoogleFonts.jua(
                        color: Color(0xff3B3B3B),
                        fontSize:  height*0.023,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      isDiaryWritten ? '일기가 쓰여 있는 날' : '일기가 쓰여 있지 않아요',
                      style: GoogleFonts.jua(
                        fontSize: height*0.02,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * 0.25,
                height: width * 0.25,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqEo0dR9xci_ZoDCV1ldW1EEft0TlZZo5zcg&usqp=CAU.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //URL: /home
    // 프론트 -> 백: date = _selectedDate, pid = '0'
    // 백 -> 프론트: 작성된 날짜 리스트(completeList), 부모+아이 일기 미리보기(교정본,이미지url)
    // _selectedDate 형식 확인 필요

    // final currentDate = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());
    // print('first');
    // print(currentDate);
    // context.read<Move>().controller.stream.listen((int index){
    //   print(index);
    // });
    context.watch<ProviderLogIn>();
    print('아빠 안잔다~');


    final selectedDate = DateFormat('yyyy / MM / dd (E) ').format(_selectedDate); // 선택된 날짜의 정보를 포맷합니다.
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor: Color(0xFF8DBFD2),
      body: Column(
        children: [
          calendar(),
          diaryCard(),
        ],
      ),
    );
  }
}
