import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProviderLogIn with ChangeNotifier {
  StreamController<int> controller = StreamController.broadcast();

  late Map<String, dynamic> jsonResponse;
  late List<dynamic> completeList = [];

  late var parentDiaryPreview;
  late String parentCorrectedText;
  late String parentImageUrl;
  late var childDiaryPreview;
  late String childCorrectedText;
  late String childImageUrl;

  late DateTime _selectedDate = DateTime.now();

  // /home
  Future<Map<String, dynamic>> fetchHome() async {
     var url = Uri.http('54.180.153.57:5000', '/home', {'pid': '0', 'date': DateFormat('yyyy-MM-dd').format(_selectedDate)});
    //var url = Uri.http('54.180.153.57:5000', '/home', {'pid': '0', 'date': '2024-02-18'});
    print("fetchHome get요청들어갑니다~");

    var response = await http.get(url);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    }
    else {
      throw Exception('FetchHome 에러다 ㅅㅂ~~~');
    }
  }

  void setSelectedDate(DateTime selectedDate) async {
    _selectedDate = selectedDate;
    print(_selectedDate);
  }

  void setData() async {
    print("setData()시작!");
    jsonResponse = await fetchHome();
    bool isDone = false;
    print("Home을 위한 데이터 받음!");
    completeList = jsonResponse['completeList'];

    parentDiaryPreview = jsonResponse['get_parent_diary_preview'];
    parentCorrectedText = parentDiaryPreview['correctedText'];
    parentImageUrl = parentDiaryPreview['imageUrl'];

    childDiaryPreview = jsonResponse['get_child_diary_preview'];
    childCorrectedText = childDiaryPreview['correctedText'];
    childImageUrl = childDiaryPreview['imageUrl'];

    notifyListeners();
    print("Provider_LogIn notifyListers() on");

    //값 바뀐다는 걸 알려줌
    print(completeList);
    print(parentCorrectedText);
    print(parentImageUrl);
    print(childCorrectedText);
    print(childImageUrl);
  }

  List<dynamic>? getCompleteListData() {

    return completeList;
  }

  String? getParentCorrectedText() {
    parentCorrectedText = '선택된 날짜의 부모 일기된 날짜의 부모 된 날짜의 부모 된 날짜의 부모 된 날짜의 부모 된 날짜의 부모 ';
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