import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProviderHome with ChangeNotifier {

  late Map<String, dynamic> jsonResponse;

  late var parentDiary;
  late String parentText = '';
  late String parentCorrectedText;
  late String parentTranslatedText;
  late String parentImageUrl = '';
  late String parentCharacterUrl = '';
  late String parentQuestion;

  late List<String> parentCorrectedTextList = [];
  late List<String> parentTranslatedTextList = [];

  late String parentChangedText = '';

  late var childDiary;
  late String childCorrectedText;
  late String childTranslatedText;
  late String childImageUrl = '';
  late String childCharacterUrl = '';
  late String childQuestion;

  late List<String> childCorrectedTextList = [];
  late List<String> childTranslatedTextList = [];

  late String childChangedText = '';

  late DateTime selectedDate;

  // home/conversation
  Future<Map<String, dynamic>> fetchConversation() async {
    var url = Uri.http('43.202.100.36:5000', '/home/conversation', {'pid': '0', 'date': DateFormat('yyyy-MM-dd').format(selectedDate)});
    // print("!!fetchConversation get!!");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('FetchConversation 에러다 ㅅㅂ~~~');
    }
  }

  // 요청에 필요한 날짜 정보 받아오기
  void setSelectedDate(DateTime selectedDate) {
    this.selectedDate = selectedDate;
  }

  DateTime getSelectedDate() {
    return selectedDate;
  }

  // Conversation 요청의 결과를 사용하기 위한 데이터로 바꿔주는 과정
  Future<void> setData() async {
    jsonResponse = await fetchConversation();
    // print("Conversation 데이터 받음!");

    parentDiary = jsonResponse['parent_diary'];
    parentText = parentDiary['text'];
    parentCorrectedText = parentDiary['correctedText'];
    parentTranslatedText = parentDiary['translatedText'];
    parentImageUrl = parentDiary['imageUrl'];
    parentCharacterUrl = parentDiary['characterUrl'];
    parentQuestion = parentDiary['question'];

    childDiary = jsonResponse['child_diary'];
    childCorrectedText = childDiary['correctedText'];
    childTranslatedText = childDiary['translatedText'];
    childImageUrl = childDiary['imageUrl'];
    childCharacterUrl = childDiary['characterUrl'];
    childQuestion = childDiary['question'];

    // 변경된 일기 보여주기 위한 교정본과 번역본 교차 출력 전처리
    setParentChangedText(parentCorrectedText, parentTranslatedText);
    setChildChangedText(childCorrectedText, childTranslatedText);

    // // 확인용 print문
    // print(parentText);
    // print(parentCorrectedText);
    // print(parentTranslatedText);
    // print(parentImageUrl);
    // print("ParentCharacter $parentCharacterUrl");
    // print("ParentQuestion $parentQuestion");
    // print(childCorrectedText);
    // print(childTranslatedText);
    // print(childImageUrl);
    // print("ChildCharacter $childCharacterUrl");
    // print("ChildlQuestion $childQuestion");

    // data 다 받았다고 알려주기
    notifyListeners();

    // print("Provider_Home notifyListeners() on");
    // print('setData 끝');

  }

  // 다른 페이지에서 각각의 data를 사용하고 싶을 때 get으로 호출할 수 있도록 설정하기
  String? getParentText() {
    return parentText;
  }

  String? getParentCorrectedText() {
    return parentCorrectedText;
  }

  String? getParentTranslatedText() {
    return parentTranslatedText;
  }

  // 변경된 일기 보여주기 위한 교정본과 번역본 교차 출력 전처리
  void setParentChangedText(String parentCorrectedText, String parentTranslatedText) async {
    parentChangedText = '';
    parentCorrectedTextList = [];
    parentTranslatedTextList = [];

    parentCorrectedTextList = parentCorrectedText.split('.');
    parentTranslatedTextList = parentTranslatedText.split('.');

    for (int i = 0; i < parentCorrectedTextList.length ; i++) {
      parentChangedText += parentCorrectedTextList[i];
      parentChangedText += "\n";
      parentChangedText += parentTranslatedTextList[i];
      parentChangedText += "\n";
    }

    // print(parentChangedText);
    // print('setParentChangedText 전처리 끝');
  }

  String? getParentChangedText() {
    return parentChangedText;
  }

  String? getParentImageUrl() {
    return parentImageUrl;
  }

  String? getParentCharacterUrl() {
    return parentCharacterUrl;
  }

  String? getParentQuestion() {
    return parentQuestion;
  }

  // 변경된 일기 보여주기 위한 교정본과 번역본 교차 출력 전처리
  void setChildChangedText(String childCorrectedText, String childTranslatedText) async {
    childChangedText = '';
    childCorrectedTextList = [];
    childTranslatedTextList = [];
    childCorrectedTextList = childCorrectedText.split('.');
    childTranslatedTextList = childTranslatedText.split('.');

    for (int i = 0; i < childCorrectedTextList.length ; i++) {
      childChangedText += childCorrectedTextList[i];
      childChangedText += "\n";
      childChangedText += childTranslatedTextList[i];
      childChangedText += "\n";
    }
    // print(childChangedText);
    // print('setChildChangedText 전처리 끝');
  }

  String? getChildChangedText() {
    return childChangedText;
  }

  String? getChildCorrectedText() {
    return childCorrectedText;
  }

  String? getChildTranslatedText() {
    return childTranslatedText;
  }

  String? getChildImageUrl() {
    return childImageUrl;
  }

  String? getChildCharacterUrl() {
    return childCharacterUrl;
  }

  String? getChildQuestion() {
    return childQuestion;
  }


}