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
  // 백 통신 위한 fetchHome 호출, reponse로 받음
  Future<Map<String, dynamic>> fetchHome() async {
    var url = Uri.http('43.202.100.36:5000', '/home', {'pid': '0', 'date': DateFormat('yyyy-MM-dd').format(_selectedDate)});
    // var url = Uri.http('54.180.153.57:5000', '/home', {'pid': '0', 'date': '2024-02-18'});
    print("fetchHome get요청들어갑니다~");

    var response = await http.get(url);
    print(response.statusCode);

    //json data를 decode해서 return
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    }
    else {
      throw Exception('FetchHome 에러다 ㅅㅂ~~~');
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
    print("Home을 위한 데이터 받음!");

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
    print("Provider_LogIn notifyListers() on");

    //값 바뀐다는 걸 알려줌
    print(completeList);
    print(parentCorrectedText);
    print(parentImageUrl);
    print(childCorrectedText);
    print(childImageUrl);
  }


  // 다른 페이지에서 각각의 data를 사용하고 싶을 때 get으로 호출할 수 있도록 설정하기
  List<dynamic>? getCompleteListData() {
    return completeList;
  }

  String? getParentCorrectedText() {
    return parentCorrectedText;
  }

  String? getParentImageUrl() {
    //parentImageUrl = 'https://i.pinimg.com/736x/90/84/5c/90845c0ec45eba7c8c75d2b08a74a18f.jpg';
    return parentImageUrl;
  }

  String? getChildCorrectedText() {
    //childCorrectedText = '선택된 날짜의 아이 일기';
    return childCorrectedText;
  }

  String? getChildImageUrl() {
    //childImageUrl = 'https://static.wixstatic.com/media/c8c1a9_94efe5e4d4c14411bf6221e7538e453a~mv2.png/v1/fill/w_560,h_606,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/favpng_shinnosuke-nohara-video-crayon-shin-chan-nene-sakurada-television-show.png';
    return childImageUrl;
  }

}