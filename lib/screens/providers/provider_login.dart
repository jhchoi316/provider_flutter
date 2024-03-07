import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProviderLogIn with ChangeNotifier {

  // 필요한 변수 선언
  late Map<String, dynamic> jsonResponse;
  late List<dynamic> completeList = [];
  late var parentDiaryPreview;
  late String parentCorrectedText;
  late String parentImageUrl;
  late var childDiaryPreview;
  late String childCorrectedText;
  late String childImageUrl;

  late DateTime _selectedDate;

  // /home
  Future<Map<String, dynamic>> fetchHome() async {
    var url = Uri.http('43.202.100.36:5000', '/home', {'pid': '0', 'date': DateFormat('yyyy-MM-dd').format(_selectedDate)});
    // print("!!fetchHome get!!");

    var response = await http.get(url);
    // print(response.statusCode);

    //json data를 decode해서 return
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    }
    else {
      throw Exception('!!FetchHome 에러!!');
    }
  }


  // 로그인 버튼 클릭시 _selectedDate가 다른 페이지(홈페이지)에서도 사용되어야하기 때문에 ProviderLogIn에 오늘 날짜를 넘겨줌
  void setSelectedDate(DateTime selectedDate) async {
    _selectedDate = selectedDate;
  }

  // 로그인 버튼 클릭시 호출되어서 홈페이지 구성에 필요한 data 받음
  Future<void> setData() async {
    print("Provider Login setData()시작!");
    // 백 통신 위한 fetchHome 호출
    jsonResponse = await fetchHome();
    // print("Home을 위한 데이터 받음!");

    // jsonResponse에 있는 data를 각각 변수에 넣기
    completeList = jsonResponse['completeList'];

    parentDiaryPreview = jsonResponse['get_parent_diary_preview'];
    parentCorrectedText = parentDiaryPreview['correctedText'];
    parentImageUrl = parentDiaryPreview['imageUrl'];

    childDiaryPreview = jsonResponse['get_child_diary_preview'];
    childCorrectedText = childDiaryPreview['correctedText'];
    childImageUrl = childDiaryPreview['imageUrl'];

    // data 다 받았다고 알려주기
    notifyListeners();
    // print("Provider_LogIn notifyListers() on");

    // // 확인용 print문
    // print(completeList);
    // print(parentCorrectedText);
    // print(parentImageUrl);
    // print(childCorrectedText);
    // print(childImageUrl);
  }


  // 다른 페이지에서 각각의 data를 사용하고 싶을 때 get으로 호출할 수 있도록 설정하기
  List<dynamic>? getCompleteListData() {
    return completeList;
  }

  String? getParentCorrectedText() {
    return parentCorrectedText;
  }

  String? getParentImageUrl() {
    return parentImageUrl;
  }

  String? getChildCorrectedText() {
    return childCorrectedText;
  }

  String? getChildImageUrl() {
    return childImageUrl;
  }

}