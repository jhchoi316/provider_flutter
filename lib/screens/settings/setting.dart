import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart' ;

class Settings extends StatelessWidget {
  const Settings({super.key});


  Widget userInfo (BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.25,
      decoration: ShapeDecoration(
        color: Color(0xFF8DBFD2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            )
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: height*0.01,
          ),
          Text(
            'My profile',
            style: GoogleFonts.jua(
              color: Color(0xff6B6B6B),
              fontSize: height * 0.028,
            ),
          ),
          SizedBox(
            height: height*0.01,
          ),
          Container(
            width: width*0.85,
            height: height*0.15,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(width * 0.05)
            ),
            child : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: height* 0.1,
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: '무너\n자녀 이름 : 다솔이',
                    style: TextStyle(
                        fontFamily: 'KNU_TRUTH',
                        color: Colors.black,
                        fontSize: height * 0.03,
                        height: height* 0.002
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

  Widget setApp(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          Text(
            '앱 설정',
            textAlign: TextAlign.left,
            style: GoogleFonts.jua(
                fontSize: height * 0.023,
                color: Color(0xff6B6B6B),
                fontWeight: FontWeight.bold
            ),
          ),
          Container(
            width: width * 0.9,
            height: height * 0.08,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF8DBFD2),),
                borderRadius:BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.cloud_queue,
                  color: Color(0xff8DBFD2),
                  size: height* 0.04,
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    "데이터 백업",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    "sao lưu dữ liệu",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.017,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff8DBFD2),
                  size: height* 0.03,
                ),

              ],
            ),
          ),
          Container(
            width: width * 0.9,
            height: height * 0.08,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF8DBFD2),),
                borderRadius:BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.notifications,
                  color: Color(0xff8DBFD2),
                  size: height* 0.04,
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    "알림 설정하기",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    "cài đặt thông báo",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.017,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff8DBFD2),
                  size: height* 0.03,
                ),

              ],
            ),
          ),
          Container(
            width: width * 0.9,
            height: height * 0.08,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF8DBFD2),),
                borderRadius:BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.light_mode,
                  color: Color(0xff8DBFD2),
                  size: height* 0.04,
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    "화면 설정하기",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    "Cài đặt màn hình",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.017,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff8DBFD2),
                  size: height* 0.03,
                ),

              ],
            ),
          ),
          Container(
            width: width * 0.9,
            height: height * 0.08,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF8DBFD2),),
                borderRadius:BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.language,
                  color: Color(0xff8DBFD2),
                  size: height* 0.04,
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    "언어 설정하기",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    "thiết lập ngôn ngữ",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.017,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff8DBFD2),
                  size: height* 0.03,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customerService(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          Text(
            '고객센터',
            textAlign: TextAlign.left,
            style: GoogleFonts.jua(
                fontSize: 20,
                color: Color(0xff6B6B6B),
                fontWeight: FontWeight.bold
            ),
          ),
          Container(
            width: width * 0.9,
            height: height * 0.08,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF8DBFD2),),
                borderRadius:BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.share,
                  color: Color(0xff8DBFD2),
                  size: height* 0.04,
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    "앱 공유하기",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    "Chia sẻ ứng dụng",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.017,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff8DBFD2),
                  size: height* 0.03,
                ),

              ],
            ),
          ),
          Container(
            width: width * 0.9,
            height: height * 0.08,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF8DBFD2),),
                borderRadius:BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.message_outlined,
                  color: Color(0xff8DBFD2),
                  size: height* 0.04,
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    "의견 보내기 ",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    "Gửi ý kiến",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.017,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff8DBFD2),
                  size: height* 0.03,
                ),

              ],
            ),
          ),
          Container(
            width: width * 0.9,
            height: height * 0.08,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF8DBFD2),),
                borderRadius:BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.thumb_up_alt,
                  color: Color(0xff8DBFD2),
                  size: height* 0.04,
                ),
                Container(
                  width: width * 0.33,
                  child: Text(
                    "개발자 응원하기",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.27,
                  child: Text(
                    "Sự ủng hộ của nhà phát triển",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.017,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff8DBFD2),
                  size: height* 0.03,
                ),

              ],
            ),
          ),
          Container(
            width: width * 0.9,
            height: height * 0.08,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF8DBFD2),),
                borderRadius:BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.message_outlined,
                  color: Color(0xff8DBFD2),
                  size: height* 0.04,
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    "유저 인터뷰",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.3,
                  child: Text(
                    "phỏng vấn người dùng",
                    textAlign: TextAlign.left,
                    style:GoogleFonts.jua(
                      fontSize: height* 0.017,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff8DBFD2),
                  size: height* 0.03,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          AppBar(
            scrolledUnderElevation: 0,
            toolbarHeight: height * 0.1,
            backgroundColor: Color(0xFF8DBFD2),
            title: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '설정\nsự dàn cảnh',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: height*0.023,
                      fontFamily: 'KNU_TRUTH'
                  ),
                ),
              ),
            ),
          ),
          userInfo(context),
          Expanded(
              child:SingleChildScrollView(
                child: Column(
                  children: [
                    setApp(context),
                    customerService(context),
                    SizedBox(height: height * 0.1,)
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}

