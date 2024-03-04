import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // 날짜 형식을 사용하기 위한 패키지
import 'package:fl_chart/fl_chart.dart' ;


//통신용 import
import 'package:http/http.dart' as http;
import 'dart:convert';

// 전달 받을 데이터 : 부모 한국어 사용 비율 30일치, 부모 한국어 교정 비율 30일치, 아이 감정 분석 수치 7일치, 아이 맞춤법 교정 비율 30일치
class Report extends StatefulWidget {
  const Report({super.key});

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> with TickerProviderStateMixin {

  late TabController reportTabController;


  @override

  void _onTabChanged() {
    setState(() {}); // 화면을 다시 그려줌
  }

  void initState() {
    super.initState();
    reportTabController = TabController(length: 2, vsync: this);
    reportTabController.addListener(_onTabChanged); // 탭 변경

    fetchData(); // 데이터 불러오기

  }

  Future<void> fetchData() async {
    //통신 URL: /home/reports
    //통신: pid
    final response = await http.post(
      Uri.parse(''), // 서버 URL 입력
      body: {
        //'pid': Variable.pid,
      },
    );

    if (response.statusCode == 200) {
      // JSON 데이터 파싱하여 변수에 저장
      final data = jsonDecode(response.body);
      //Variable.pdDay1Report = Map<String, int>.from(data['pd_day1_report']);
      //Variable.pdDay7Report = Map<String, dynamic>.from(data['pd_day7_report']);
      //Variable.pdDay30Report = Map<String, dynamic>.from(data['pd_day30_report']);

      setState(() {}); // 화면 갱신
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          AppBar(
            scrolledUnderElevation: 0,
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            backgroundColor: Color(0xFF8DBFD2),
            title: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(text: '일기 통계\nthống kê bố mẹ', style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: 'KNU_TRUTH'),),
              ),
            ),
          ),

          //부모 일기 아이 일기 탭
          Container(
            color: Color(0xFF8DBFD2),
            child: TabBar(
              controller: reportTabController,

              onTap: (index) {
                setState(() {});
              },

              labelColor: Colors.white,
              unselectedLabelColor: Color(0xff8B8B8B),
              tabs: [
                Tab(
                  child: Text(
                    '부모\nnhật ký của bố',
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
            child: TabBarView(
              controller: reportTabController,
              children: <Widget>[

                //부모탭 리포트 결과
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

                        //TODAY
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                            Container( height:1.0,
                              width:MediaQuery.of(context).size.width * 0.25,
                              color:Color(0xff6B6B6B),),
                            Text(
                              'TODAY',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.jua(
                                fontSize: 20,
                                color: Color(0xff6B6B6B),
                              ),
                            ),
                            Container( height:1.0,
                              width:MediaQuery.of(context).size.width * 0.25,
                              color:Color(0xff6B6B6B),),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                        Text(
                          DateFormat('yyyy년 MM월 dd일 EEEE').format(DateTime.now()),
                          style: GoogleFonts.jua(
                            color: Color(0xff6B6B6B),
                            fontSize:15,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      height: MediaQuery.of(context).size.width * 0.3,
                                      child: PieChart(
                                        PieChartData(
                                          sections: [
                                            PieChartSectionData(
                                              //통신(variable.dart) : day1_lang
                                              value: 0.63,
                                              radius: MediaQuery.of(context).size.width *0.05,
                                              color: Colors.blue,
                                              showTitle: false,
                                            ),
                                            PieChartSectionData(
                                              //통신(variable.dart) : day1_lang
                                              value: 1-0.63,
                                              radius: MediaQuery.of(context).size.width *0.1,
                                              color: Colors.transparent,
                                              showTitle: false,
                                            ),
                                          ],
                                          centerSpaceRadius: MediaQuery.of(context).size.width *0.13,
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/dasol.png',
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      height: MediaQuery.of(context).size.width * 0.25,
                                    ),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                                Text(
                                    '일별 한국어 사용 비율',
                                    style: TextStyle(
                                      color: Color(0xff6B6B6B),
                                      fontFamily: 'KNU_TRUTH',
                                      fontSize:15,
                                    )
                                ),
                                //추후 비율 변수 값 대입(일별 한국어 사용 비울)
                                Text('63%',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize:20,
                                    fontFamily: 'KNU_TRUTH',
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      height: MediaQuery.of(context).size.width * 0.3,
                                      child: PieChart(
                                        PieChartData(
                                          sections: [
                                            PieChartSectionData(
                                              //통신(variable.dart) : day1_correct
                                              value: 0.76,
                                              radius: MediaQuery.of(context).size.width *0.05,
                                              color: Colors.grey,
                                              showTitle: false,
                                            ),
                                            PieChartSectionData(
                                              //통신(variable.dart) : day1_correct
                                              value: 1-0.76,
                                              radius: MediaQuery.of(context).size.width *0.1,
                                              color: Colors.transparent,
                                              showTitle: false,
                                            ),
                                          ],
                                          centerSpaceRadius: MediaQuery.of(context).size.width *0.13,
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/sad.png',
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      height: MediaQuery.of(context).size.width * 0.25,
                                    ),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                                Text(
                                    '일별 한국어 교정 비율',
                                    style: TextStyle(
                                      color: Color(0xff6B6B6B),
                                      fontSize:15,
                                      fontFamily: 'KNU_TRUTH',
                                    )
                                ),
                                //추후 비율 변수 값 대입(일별 한국어 사용 비울)
                                Text('76%',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:20,
                                    fontFamily: 'KNU_TRUTH',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.06,),

                        //최근 일기 7개
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                            Container( height:1.0,
                              width:MediaQuery.of(context).size.width * 0.2,
                              color:Color(0xff6B6B6B),),
                            Text(
                              '최근 일기 7개',
                              textAlign: TextAlign.center,
                              style:GoogleFonts.jua(
                                fontSize: 20,
                                color: Color(0xff6B6B6B),
                              ),
                            ),
                            Container( height:1.0,
                              width:MediaQuery.of(context).size.width * 0.2,
                              color:Color(0xff6B6B6B),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                        Text(
                          '한국어 사용 비율',
                          style:GoogleFonts.jua(
                            color: Color(0xff6B6B6B),
                            fontSize:15,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01,),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.55,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF8DBFD2),),
                              borderRadius:BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: MediaQuery.of(context).size.width * 0.4,
                                child: BarChart(
                                  BarChartData(
                                    barGroups: barGroups_use([50, 60, 55, 65, 70, 80, 90]),
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    ),
                                    minY: 0,
                                    maxY: 100,
                                    borderData: FlBorderData(show: false),
                                    gridData: FlGridData(show: false),
                                    alignment: BarChartAlignment.spaceBetween,
                                  ),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // 통신(서버->클):
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 6))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),fontSize:11,
                                    ),

                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 5))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 4))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 3))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 2))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 1))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    'TODAY',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),fontSize:11,
                                    ),
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                        Text(
                          '한국어 교정 비율',
                          style:GoogleFonts.jua(
                            color: Color(0xff6B6B6B),
                            fontSize:15,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01,),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.55,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF8DBFD2),),
                              borderRadius:BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: MediaQuery.of(context).size.width * 0.4,
                                child: BarChart(
                                  BarChartData(
                                    barGroups: barGroups_correct([50, 60, 55, 65, 70, 80, 90]),
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    ),
                                    minY: 0,
                                    maxY: 100,
                                    borderData: FlBorderData(show: false),
                                    gridData: FlGridData(show: false),
                                    alignment: BarChartAlignment.spaceBetween,
                                  ),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // 통신(서버->클):
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 6))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 5))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 4))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 3))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 2))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 1))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    'TODAY',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

                        //최근 일기 30개
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                            Container( height:1.0,
                              width:MediaQuery.of(context).size.width * 0.2,
                              color:Color(0xff6B6B6B),),
                            Text('최근 일기 30개',
                              textAlign: TextAlign.center,
                              style:GoogleFonts.jua(
                                fontSize: 20,
                                color: Color(0xff6B6B6B),
                              ),
                            ),
                            Container( height:1.0,
                              width:MediaQuery.of(context).size.width * 0.2,
                              color:Color(0xff6B6B6B),),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                        Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01,),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF8DBFD2),),
                              borderRadius:BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              Text(
                                '일별 한국어 사용 비율',
                                style:GoogleFonts.jua(
                                  color: Color(0xff6B6B6B),
                                  fontSize:15,
                                ),

                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.74,
                                height: MediaQuery.of(context).size.height * 0.25,
                                child: LineChart(
                                  LineChartData(
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: spots(),
                                        isCurved: true,
                                        color: Colors.lightBlueAccent,
                                        dotData: FlDotData(show: false),
                                        barWidth: MediaQuery.of(context).size.height * 0.008,
                                      ),
                                    ],
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(sideTitles:SideTitles(showTitles: false),                                        ),
                                      rightTitles: AxisTitles(sideTitles:SideTitles(showTitles: false)),
                                      topTitles: AxisTitles(sideTitles:SideTitles(showTitles: false)),
                                      bottomTitles: AxisTitles(sideTitles:SideTitles(showTitles: false)),
                                    ),
                                    minY: 0,
                                    maxY: 100,
                                    borderData: FlBorderData(show: false), // 테두리를 숨김
                                    gridData: FlGridData(show: false),
                                  ),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '30일 전',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:15,
                                    ),
                                  ),
                                  Text(
                                    '20일 전',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:15,
                                    ),

                                  ),
                                  Text(
                                    '10일 전',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:15,
                                    ),
                                  ),
                                  Text(
                                    'TODAY',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:15,
                                    ),
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                        Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01,),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF8DBFD2),),
                              borderRadius:BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              Text(
                                '일별 한국어 교정 비율',
                                style:GoogleFonts.jua(
                                  color: Color(0xff6B6B6B),
                                  fontSize:15,
                                ),

                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.74,
                                height: MediaQuery.of(context).size.height * 0.25,
                                child: LineChart(
                                  LineChartData(
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: spots(),
                                        isCurved: true,
                                        color: Colors.green,
                                        dotData: FlDotData(show: false),
                                        barWidth: MediaQuery.of(context).size.height * 0.008,
                                      ),
                                    ],
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(sideTitles:SideTitles(showTitles: false),                                        ),
                                      rightTitles: AxisTitles(sideTitles:SideTitles(showTitles: false)),
                                      topTitles: AxisTitles(sideTitles:SideTitles(showTitles: false)),
                                      bottomTitles: AxisTitles(sideTitles:SideTitles(showTitles: false)),
                                    ),
                                    minY: 0,
                                    maxY: 100,
                                    borderData: FlBorderData(show: false), // 테두리를 숨김
                                    gridData: FlGridData(show: false),
                                  ),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '30일 전',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:15,
                                    ),
                                  ),
                                  Text(
                                    '20일 전',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:15,
                                    ),
                                  ),
                                  Text(
                                    '10일 전',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:15,
                                    ),
                                  ),
                                  Text(
                                    'TODAY',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:15,
                                    ),
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                      ],
                    ),
                  ),
                ),

                //아이탭 리포트 결과
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

                        //TODAY
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                            Container( height:1.0,
                              width:MediaQuery.of(context).size.width * 0.25,
                              color:Color(0xff6B6B6B),),
                            Text(
                              'TODAY',
                              textAlign: TextAlign.center,
                              style:GoogleFonts.jua(
                                color: Color(0xff6B6B6B),
                                fontSize:20,
                              ),
                            ),
                            Container( height:1.0,
                              width:MediaQuery.of(context).size.width * 0.25,
                              color:Color(0xff6B6B6B),),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                        Text(
                          DateFormat('yyyy년 MM월 dd일 EEEE').format(DateTime.now()),
                          style:GoogleFonts.jua(
                            color: Color(0xff6B6B6B),
                            fontSize:15,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      height: MediaQuery.of(context).size.width * 0.3,
                                      child: PieChart(
                                        PieChartData(
                                          sections: [
                                            PieChartSectionData(
                                              //통신(variable.dart) : day1_mood
                                              value: 0.83,
                                              radius: MediaQuery.of(context).size.width *0.05,
                                              color: Colors.blue,
                                              showTitle: false,
                                            ),
                                            PieChartSectionData(
                                              //통신(variable.dart) : day1_mood
                                              value: 1-0.83,
                                              radius: MediaQuery.of(context).size.width *0.1,
                                              color: Colors.transparent,
                                              showTitle: false,
                                            ),
                                          ],
                                          centerSpaceRadius: MediaQuery.of(context).size.width *0.13,
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/happy.png',
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      height: MediaQuery.of(context).size.width * 0.25,
                                    ),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                                Text(
                                  '아이의 오늘 기분',
                                  style:GoogleFonts.jua(
                                    color: Color(0xff6B6B6B),
                                    fontSize:15,
                                  ),
                                ),
                                Text('83%',
                                  style:GoogleFonts.jua(
                                    color: Colors.blue,
                                    fontSize:20,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      height: MediaQuery.of(context).size.width * 0.3,
                                      child: PieChart(
                                        PieChartData(
                                          sections: [
                                            PieChartSectionData(
                                              //통신(variable.dart) : day1_correct
                                              value: 0.52,
                                              radius: MediaQuery.of(context).size.width *0.05,
                                              color: Colors.grey,
                                              showTitle: false,
                                            ),
                                            PieChartSectionData(
                                              //통신(variable.dart) : 1 - day1_correct
                                              value: 1-0.52,
                                              radius: MediaQuery.of(context).size.width *0.1,
                                              color: Colors.transparent,
                                              showTitle: false,
                                            ),
                                          ],
                                          centerSpaceRadius: MediaQuery.of(context).size.width *0.13,
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/dasol.png',
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      height: MediaQuery.of(context).size.width * 0.25,
                                    ),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                                Text(
                                  '교정 비율',
                                  style:GoogleFonts.jua(
                                    color: Color(0xff6B6B6B),
                                    fontSize:15,
                                  ),
                                ),
                                //통신(서버->클) 비율 변수 값 대입(일별 한국어 사용 비울)
                                Text('52%',
                                  style:GoogleFonts.jua(
                                    color: Colors.grey,
                                    fontSize:20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.06,),

                        //최근 일기 7개
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                            Container( height:1.0,
                              width:MediaQuery.of(context).size.width * 0.2,
                              color:Color(0xff6B6B6B),),
                            Text(
                              '최근 일기 7개',
                              textAlign: TextAlign.center,
                              style:GoogleFonts.jua(
                                fontSize: 20,
                                color: Color(0xff6B6B6B),
                              ),
                            ),
                            Container( height:1.0,
                              width:MediaQuery.of(context).size.width * 0.2,
                              color:Color(0xff6B6B6B),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                        Text(
                          '감정 기록',
                          style:GoogleFonts.jua(
                            color: Color(0xff6B6B6B),
                            fontSize:15,
                          ),

                        ),
                        Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF8DBFD2),),
                              borderRadius:BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/happy.png',
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 6))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/sad.png',
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 5))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/dasol.png',
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  Text(
                                      DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 4))),
                                      style: TextStyle(color: Color(0xff6B6B6B),fontSize:11,)
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/dasol.png',
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  Text(
                                      DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 3))),
                                      style: TextStyle(color: Color(0xff6B6B6B),fontSize:11,)
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/happy.png',
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 2))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/sad.png',
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 1))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/happy.png',
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  Text('TODAY',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                        Text(
                          '한국어 교정 비율',
                          style:GoogleFonts.jua(
                            color: Color(0xff6B6B6B),
                            fontSize:15,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF8DBFD2),),
                              borderRadius:BorderRadius.circular(20)
                          ),
                          child:  Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: MediaQuery.of(context).size.width * 0.4,
                                child: BarChart(
                                  BarChartData(
                                    //통신(variable.dart) : day7_correct
                                    barGroups: barGroups_correct([50, 60, 55, 65, 70, 80, 90]),
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    ),
                                    minY: 0,
                                    maxY: 100,
                                    borderData: FlBorderData(show: false),
                                    gridData: FlGridData(show: false),
                                    alignment: BarChartAlignment.spaceBetween,
                                  ),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // 통신(서버->클):
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 6))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 5))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 4))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 3))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 2))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('M/dd').format(DateTime.now().subtract(Duration(days: 1))),
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),),
                                  Text('TODAY',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:11,
                                    ),),

                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

                        //최근 일기 30개
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                            Container( height:1.0,
                              width:MediaQuery.of(context).size.width * 0.2,
                              color:Color(0xff6B6B6B),),
                            Text(
                              '최근 일기 30개',
                              textAlign: TextAlign.center,
                              style:GoogleFonts.jua(
                                color: Color(0xff6B6B6B),
                                fontSize:20,
                              ),
                            ),
                            Container( height:1.0,
                              width:MediaQuery.of(context).size.width * 0.2,
                              color:Color(0xff6B6B6B),),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                        Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01,),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF8DBFD2),),
                              borderRadius:BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              Text(
                                '일별 교정 비율',
                                style:GoogleFonts.jua(
                                  color: Color(0xff6B6B6B),
                                  fontSize:15,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.74,
                                height: MediaQuery.of(context).size.height * 0.25,
                                child: LineChart(
                                  LineChartData(
                                    lineBarsData: [
                                      LineChartBarData(
                                        //통신(variable.dart) : day30_correct
                                        spots: spots(),
                                        isCurved: true,
                                        color: Colors.green,
                                        dotData: FlDotData(show: false),
                                        barWidth: MediaQuery.of(context).size.height * 0.008,
                                      ),
                                    ],
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(sideTitles:SideTitles(showTitles: false),                                        ),
                                      rightTitles: AxisTitles(sideTitles:SideTitles(showTitles: false)),
                                      topTitles: AxisTitles(sideTitles:SideTitles(showTitles: false)),
                                      bottomTitles: AxisTitles(sideTitles:SideTitles(showTitles: false)),
                                    ),
                                    minY: 0,
                                    maxY: 100,
                                    borderData: FlBorderData(show: false), // 테두리를 숨김
                                    gridData: FlGridData(show: false),
                                  ),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '30일 전',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:15,
                                    ),

                                  ),
                                  Text(
                                    '20일 전',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:15,
                                    ),
                                  ),
                                  Text(
                                    '10일 전',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:15,
                                    ),
                                  ),
                                  Text(
                                    'TODAY',
                                    style:GoogleFonts.jua(
                                      color: Color(0xff6B6B6B),
                                      fontSize:15,
                                    ),
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.13,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 통신(서버->클):
List<BarChartGroupData> barGroups_use(List<double> data) {
  List<BarChartGroupData> result = [];

  for (int i = 0; i < data.length; i++) {
    result.add(
      BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: data[i],
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  return result;
}

List<BarChartGroupData> barGroups_correct(List<double> data) {
  List<BarChartGroupData> result = [];

  for (int i = 0; i < data.length; i++) {
    result.add(
      BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: data[i],
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  return result;
}


//통신(서버->클):
List<FlSpot> spots() {
  List<FlSpot> result = [];

  // 30개의 FlSpot을 생성합니다.
  for (int i = 0; i < 30; i++) {
    double y = Random().nextInt(71).toDouble()+30; // 0부터 100 사이의 랜덤한 값
    result.add(FlSpot(i.toDouble(), y)); // FlSpot을 리스트에 추가합니다.
  }

  return result;
}