import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/provider_loading.dart';
import '../providers/provider_login.dart';

// 언어 선택 Dropdown 클래스 -> statefulWidget 클래스로
class NationDropdown extends StatefulWidget {
  const NationDropdown({super.key});

  //createState(): 최초로 생성
  @override
  NationDropdownState createState() => NationDropdownState();
}

class NationDropdownState extends State<NationDropdown> {

  // 국가 선언
  final _nation = ['Vietnam', 'Philippines','China'];
  String _selectedNation = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedNation = _nation.first;
    });
  }

  @override
  Widget build(BuildContext context) {

    //사용자 디바이스의 width와 height
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      child: DropdownButton(
        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
        hint: Text('Language',
        ),
        value: _selectedNation,
        style: TextStyle(
          color: Colors.white,
          fontSize: height * 0.025,
        ),
        underline: Container(), //underline에 빈 Container를 넣어서 밑줄 없애기
        dropdownColor: Color(0xff8DBFD2), //dropdown 되었을 때 배경색
        items: _nation
            .map((e) => DropdownMenuItem(
          value: e,
          child: Text(e,
            style: TextStyle(color: Colors.white),
          ),
        ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedNation = value!;
          });
        },
      ),
    );
  }
}


// 로그인 화면 -> statefulWidget 클래스로
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();

}

class _LogInState extends State<LogIn> {

  // 사용자에게 입력받은 id와 pw를 컨트롤 하기 위한 TextEditingController클래스 인스턴스 생성
  // _idController 변수를 사용해 TextEditingController 클래스의 메서드 및 속성에 접근 가능
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  // 언어 선택 widget
  Widget nationSelect(BuildContext context){

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.2,
      padding: EdgeInsets.fromLTRB(width*0.08,height * 0.05,0,0),

      // icon 과 dropdown 클래스를 가지고 있는 container를 Row로 정렬
      child: Row(
        children: <Widget>[
          Icon(
            Icons.language,
            size: height * 0.04,
            color: Colors.white,
          ),
          SizedBox(width: width*0.02,), // 빈공간
          Container(
            //color: Colors.white,
            width: width*0.4,
            height: height*0.05,
            child: NationDropdown(),
          ),
        ],
      ),
    );
  }

  //id 입력 부분
  Widget id(BuildContext context){
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: width*0.05),
      width: width*0.9,
      height: height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.04),
        border: Border.all(
          width: width * 0.006,
          color: Colors.white,
        ),
      ),
      child: TextField(
        controller: _idController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          prefixIconColor:Colors.white,
          hintText: 'ID',
          hintStyle: GoogleFonts.jua(
              color: Colors.white,
              fontSize: height * 0.023
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  //pw 입력 부분
  Widget password(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: width*0.05),
      width: width*0.9,
      height: height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.04),
        border: Border.all(
          width: width * 0.006,
          color: Colors.white,
        ),
      ),
      child: TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.key),
          prefixIconColor:Colors.white,
          hintText: 'Password',
          hintStyle: GoogleFonts.jua(
              color: Colors.white,
              fontSize: height * 0.023
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // 로그인 버튼
  Widget loginButton(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    return Container(
      width: width*0.9,
      height: height * 0.08,

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(height * 0.04)
      ),
      child: TextButton(
        onPressed: () async {
          //isLoading을 true로
          context.read<ProviderLoading>().setIsLoadingTrue();
          //_selectedDate가 다른 페이지(홈페이지)에서도 사용되어야하기 때문에 ProviderLogIn에 오늘 날짜를 넘겨줌
          context.read<ProviderLogIn>().setSelectedDate(DateTime.now());
          //홈페이지 구성에 필요한 data 받음 (ProviderLogIn의 setData에서)
          await context.read<ProviderLogIn>().setData();
          //isLoading을 false로
          context.read<ProviderLoading>().setIsLoadingFalse();
          //home으로 고!!
          context.go('/home');
        },
        child: Text(
          '로그인',
          style: TextStyle(
            fontFamily: 'KNU_TRUTH',
            color: Color(0xff8DBFD2),
            fontSize: height * 0.024,
          ),
        ),
      ),
    );
  }

  //아이디찾기, 비밀번호찾기, 회원가입 텍스트,,,ㅎ
  Widget sign(BuildContext context){
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: width * 0.3,),
          Text(
            '아이디 찾기',
            style: TextStyle(
              fontFamily: 'KNU_TRUTH',
              color: Colors.white,
              fontSize: height * 0.017,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
            ),
          ),
          Text(
            '비밀번호 찾기',
            style: TextStyle(
              fontFamily: 'KNU_TRUTH',
              color: Colors.white,
              fontSize: height * 0.017,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => signup()),
              // );
            },
            child: Text(
              '회원가입',
              style: TextStyle(
                fontFamily: 'KNU_TRUTH',
                color: Colors.white,
                fontSize: height * 0.017,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
            ),
          ),
          SizedBox(width: width * 0.017),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ProviderLoading>();
    bool isLoading = context.read<ProviderLoading>().getIsLoading();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return
      Scaffold(
        backgroundColor: Color(0xff8DBFD2),
        body: isLoading ?
        // isLoading이 true이면 CircularProgressIndicator -> 로딩 화면
        Center(child: CircularProgressIndicator()) :

        // isLoading이 false이면 로그인 화면, 키보드 올라오면 올라가기 위해 SingleChildScrollView로 스크롤 가능
        SingleChildScrollView(
          //국가 선택(nationSelect), 다소리 로고, id입력(id), pw입력(password), 로그인 버튼(loginButton) column으로 정렬
          child: Column(
            children: <Widget>[
              nationSelect(context),
              SizedBox(height: height * 0.05),
              Container(
                //padding: const EdgeInsets.only(top: 80.0),
                child: Center(
                  child: Container(
                      width: width * 0.5,
                      height: width * 0.5,
                      child: Image.asset('assets/login_dasol.png')),
                ),
              ),
              SizedBox(height: height * 0.03),
              id(context),
              SizedBox(height: height * 0.01),
              password(context),
              SizedBox(height: height * 0.02),
              loginButton(context),
              sign(context),


              SizedBox(height: height * 0.01),

            ],
          ),
        ),
    );
  }
}