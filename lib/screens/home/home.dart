import 'package:Front_Flutter/screens/providers/provider_loading.dart';
import 'package:Front_Flutter/screens/providers/provider_login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // 날짜 형식을 사용하기 위한 패키지


import 'package:provider/provider.dart';

import '../providers/provider_home.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState(); //createState(): 최초로 생성
}

class _HomeState extends State<Home> {

  // State 객체 초기화
  @override
  void initState() {
    super.initState();
  }

  // State 객체 정리 작업 수행
  @override
  void dispose() {
    super.dispose();
  }

  // 처음 선택된 날짜(_selectedDate)에 오늘 날짜로 초기화
  // markedDates : completeList에 대한 boolean값 대입을 위한 map 선언
  DateTime _selectedDate = DateTime.now();
  var markedDates = <DateTime, bool>{};


  // 달력부분에 해당하는 Widget
  Widget calendar() {

    //사용자 디바이스의 width와 height
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height* 0.55,

      child: Column(
        children: [
          SizedBox(width: width,height: height*0.04),
          calendarHeader(), // 달력의 Year, Month 표시 & 월간 이동 아이콘
          calendarWeekdays(),// SMTWTFS 표시
          calendarDays(), // 달력 Days 표시
        ],
      ),
    );
  }

  // 달력의 Year, Month 표시 & 월간 이동 아이콘
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
            onPressed: () async {
                //isLoading을 true로
                context.read<ProviderLoading>().setIsLoadingTrue();
                //_selectedDate = 원래 _selectedDate의 (같은 연도, 이전달, 1일)
                _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, 1);
                //_selectedDate가 다른 페이지(소통페이지)에서도 사용되어야하기 때문에 ProviderLogIn에 넘겨줌
                context.read<ProviderLogIn>().setSelectedDate(_selectedDate);
                //홈페이지 구성에 필요한 data 받음 (ProviderLogIn의 setData에서)
                await context.read<ProviderLogIn>().setData();
                //isLoading을 false로
                context.read<ProviderLoading>().setIsLoadingFalse();
            },
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              // 선택된 날짜의 년월 표시 (ex. 2024 January)
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
            onPressed: () async {
              context.read<ProviderLoading>().setIsLoadingTrue();
              _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
              context.read<ProviderLogIn>().setSelectedDate(_selectedDate);
              await context.read<ProviderLogIn>().setData();
              context.read<ProviderLoading>().setIsLoadingFalse();
            },

          ),
        ],
      ),
    );
  }

  // SMTWTFS 표시
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

  // 달력 Days 표시
  Widget calendarDays() {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // 추후 코드 수정 필요!!!!!!!!!!
    // ProviderLogIn에서 getCompleteListData() 호출해서 completeList 받기
    late List<dynamic>? completeList = context.read<ProviderLogIn>().getCompleteListData();
    // print("홈에서 comp $completeList");

    markedDates= {};
    //completeList가 null이 아닐 때 각 문자열을 DateTime으로 변환하고
    completeList?.forEach( (dateString) {
      DateTime date = DateFormat('E, dd MMM yyyy HH:mm:ss').parse(dateString);
      markedDates[date] = true; // 해당하는 날짜의 markedDates를 true로 설정
    });
    // print("calendarDays에서 mark $markedDates");


    return Container(
      width: width*0.96,
      height: height*0.4,

      // GridView.builder를 사용해서 날짜를 하나씩 그릴거임
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(), // 스크롤 x
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, // 한 줄에 7개의 요일을 표시
        ),
        itemCount: DateTime.daysPerWeek * 5, // 5주를 표시
        itemBuilder: (context, index) {

          // index가 0부터 시작해서 grid에서 그리는 부분의 날짜를 currentDate에 대입
          final currentDate = DateTime(_selectedDate.year, _selectedDate.month, index + 1 - DateTime(_selectedDate.year, _selectedDate.month, 1).weekday);

          // 선택된 날짜의 여부를 확인 (흰색 동그라미 그릴 때 필요)
          final isSelected = currentDate.year == _selectedDate.year &&
              currentDate.month == _selectedDate.month &&
              currentDate.day == _selectedDate.day;

          // grid가 그리고 있는 날짜의 markedDates의 값을 writeDiary에 넣기!
          final writeDiary = markedDates[currentDate] ?? false;

          // grid가 그리려는 날짜가 이번달인지 아닌지 확인 (제일 처음 _selectedDate는 오늘날짜임!)
          final isOutsideMonth = currentDate.month != _selectedDate.month;

          // 이번달에 해당하는 날짜가 아니면 빈 container 그리기
          if (isOutsideMonth) {
            return Container(
              width: width*0.08,
              height: height*0.9,
            );
          }

          // 아니면 사용자 gesture 감지할 수 있도록 GestureDetector로 감싼 Container 그리기
          return GestureDetector(
            // onTap 되면 _selectedDate가 바뀌기 때문에 위에서와 마찬가지로 Provider 처리 (loading, 선택 날짜 넘기기)
            onTap: () async {
              context.read<ProviderLoading>().setIsLoadingFalse();
              _selectedDate = currentDate;
              context.read<ProviderLogIn>().setSelectedDate(_selectedDate);
              await context.read<ProviderLogIn>().setData();
            },

            child: Container(
              width: width*0.08,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  // grid가 그리려는 날짜가 사용자가 선택한 날짜이면 흰색 테두리, 아니면 투명 테두리그리기
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
                  // 아니면 회색 동그라미 표시
                  if (!writeDiary)
                    Container(
                      width: width*0.07,
                      height: width*0.07,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                    ),
                  // grid가 그리려는 currentDate의 day를 표시
                  Text(
                    '${currentDate.day}',
                    style: GoogleFonts.jua(
                        fontSize: width*0.025,
                        fontWeight: FontWeight.bold,
                        // 테두리와 마찬가지로 isSelected이면 white 아니면 블랙
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


  // 일기 미리보기 보여주는 부분
  Widget diaryCard() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // 선택된 날짜의 markedDate 값을 isDiaryWritten값에 대입
    final isDiaryWritten = markedDates[_selectedDate] ?? false;

    // 사용자의 동작 감지 InkWell은 동작시 클릭되었다는 애니메이션효과가 있다.
    return InkWell(
      onTap: () async {
        //isLoading을 true로
        context.read<ProviderLoading>().setIsLoadingTrue();
        if(isDiaryWritten) {
          //_selectedDate가 다른 페이지(소통페이지)에서도 사용되어야하기 때문에 ProviderHome에 오늘 날짜를 넘겨줌
          context.read<ProviderHome>().setSelectedDate(_selectedDate);
          //소통페이지 구성에 필요한 data 받음 (ProviderHome의 setData에서)
          await context.read<ProviderHome>().setData();
          //isLoading을 false로
          context.read<ProviderLoading>().setIsLoadingFalse();
          //소통페이지로 고!!
          context.go('/conversation');
        }
      },
      // 일기 보여주는 흰색 container
      child: Container(
        height: height * 0.45,
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


    // 코드 수정 필요 !!!!!!!!!!!
    // 현재는 markedDates 이용해서 일기 작성 여부 확인하고 있음.
    // Provider에서 get한 값이 null 인지 아닌지로 확인해야 할 것 같음.
    final isDiaryWritten = markedDates[_selectedDate] ?? false; // 선택된 날짜에 일기가 쓰여있는지 확인합니다.

    // ProviderLogIn의 getParentCorrectedText()와 getParentImageUrl() 호출해서 string 변수에 넣기
    late String? parentCorrectedText = context.read<ProviderLogIn>().getParentCorrectedText();
    late String? parentImageUrl = context.read<ProviderLogIn>().getParentImageUrl();

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
          child:
          isDiaryWritten?
          Row(
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
                    Container(
                      width: width * 0.58,
                      height: height * 0.062,
                      child: Text(
                        // parentCorrectedText 보여줌.
                        '$parentCorrectedText',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis, // overflow인 일기 ,,,으로
                        style: GoogleFonts.jua(
                          fontSize: height*0.02,
                        ),
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
                  '$parentImageUrl',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
              :Center(
                child: Text(
                  '일기가 쓰여 있지 않아요!',
                  style: TextStyle(
                    fontFamily: 'KNU_TRUTH',
                    fontSize: width * 0.05,
              ),
            ),
          )
        ),
      ),
    );
  }

  // 아이 일기 카드
  Widget childDiaryCard() {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // 코드 수정 필요 !!!!!!!!!!!
    // 현재는 markedDates 이용해서 일기 작성 여부 확인하고 있음.
    // Provider에서 get한 값이 null 인지 아닌지로 확인해야 할 것 같음.
    final isDiaryWritten = markedDates[_selectedDate] ?? false;

    // ProviderLogIn의 getParentCorrectedText()와 getParentImageUrl() 호출해서 string 변수에 넣기
    late String? childCorrectedText = context.read<ProviderLogIn>().getChildCorrectedText();
    late String? childImageUrl = context.read<ProviderLogIn>().getChildImageUrl();

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
          child:
          isDiaryWritten?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(height*0.01,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(
                      '아이의 일기',
                      style: GoogleFonts.jua(
                        color: Color(0xff3B3B3B),
                        fontSize:  height*0.023,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Container(
                      width: width * 0.58,
                      height: height * 0.062,
                      child: Text(
                        '$childCorrectedText',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.jua(
                          fontSize: height*0.02,
                        ),
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
                  '$childImageUrl',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
              :Center(
                child: Text(
                  '일기가 쓰여 있지 않아요!',
                  style: TextStyle(
                    fontFamily: 'KNU_TRUTH',
                    fontSize: width * 0.05,
                  ),
            ),
          )
        ),
      ),
    );
  }

  // Home() 클래스가 호출되면 build 시작
  @override
  Widget build(BuildContext context) {
    context.watch<ProviderLogIn>();
    context.watch<ProviderLoading>();
    bool isLoading = context.read<ProviderLoading>().getIsLoading();

    return
    Scaffold(
      backgroundColor: Color(0xFF8DBFD2),
      body: isLoading ?
      Center(child: CircularProgressIndicator()) :
      Column(
        children: [
          calendar(),
          diaryCard(),
        ],
      ),
    );
  }
}
