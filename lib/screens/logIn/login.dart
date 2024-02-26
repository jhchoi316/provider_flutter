import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../providers/provider_login.dart';
import 'package:provider/provider.dart';

// nation dropdown
class NationDropdown extends StatefulWidget {
  const NationDropdown({super.key});

  @override
  NationDropdownState createState() => NationDropdownState();
}

class NationDropdownState extends State<NationDropdown> {

  final _nation = ['Vietnam', 'Philippines','China'];
  String _selectedNation = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedNation = _nation[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      child: DropdownButton(
        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
        hint: Text('Language',
          //style: TextStyle(color: Colors.white),
        ),
        value: _selectedNation,
        style: TextStyle(
          color: Colors.white,
          fontSize: height * 0.025,
        ),
        underline: Container(),
        dropdownColor: Color(0xff8DBFD2),
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

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget nationSelect(BuildContext context){

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.2,
      padding: EdgeInsets.fromLTRB(width*0.08,height * 0.05,0,0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.language,
            size: height * 0.04,
            color: Colors.white,
          ),
          SizedBox(width: width*0.02,),
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
          print('로그인 슈웃~');
          context.read<ProviderLogIn>().setSelectedDate(DateTime.now());
          context.read<ProviderLogIn>().setData();
          //context.read<ProviderLogIn>(listen: false).controller.sink.add(0);

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
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff8DBFD2),
      body: SingleChildScrollView(
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