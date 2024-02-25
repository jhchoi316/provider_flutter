import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ProviderLogIn with ChangeNotifier {
  StreamController<int> controller = StreamController.broadcast();

  late Map<String, dynamic> jsonResponse;
  late List<dynamic> completeList;
  late var parentDiaryPreview;
  late String parentCorrectedText;
  late String parentImageUrl;
  late var childDiaryPreview;
  late String childCorrectedText;
  late String childImageUrl;

  // /home
  Future<Map<String, dynamic>> fetchHome() async {
    // var url = Uri.http('52.79.242.219:8000', '/home', {'pid': '0', 'date': '${DateFormat('yyyy-MM-dd').format(_selectedDate)}'});
    var url = Uri.http('54.180.153.57:5000', '/home', {'pid': '0', 'date': '2024-02-18'});
    print("fetchHome get요청들어갑니다~");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    }
    else {
      throw Exception('FetchHome 에러다 ㅅㅂ~~~');
    }
  }

  void setData() async {
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
    // print(completeList);
    // print(parentCorrectedText);
    // print(parentImageUrl);
    // print(childCorrectedText);
    // print(childImageUrl);
  }

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