import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProviderHome with ChangeNotifier {
  StreamController<int> controller = StreamController.broadcast();

  late Map<String, dynamic> jsonResponse;

  late var parentDiary;
  late String parentText = '';
  late String parentCorrectedText;
  late String parentTranslatedText;
  late String parentImageUrl;
  late String parentCharacterUrl;
  late String parentQuestion;

  late List<String> parentCorrectedTextList = [];
  late List<String> parentTranslatedTextList = [];

  late String parentChangedText = '';

  late var childDiary;
  late String childCorrectedText;
  late String childTranslatedText;
  late String childImageUrl;
  late String childCharacterUrl;
  late String childQuestion;

  late List<String> childCorrectedTextList = [];
  late List<String> childTranslatedTextList = [];

  late String childChangedText = '';

  late DateTime selectedDate;

  // home/conversation
  Future<Map<String, dynamic>> fetchConversation() async {
    var url = Uri.http('54.180.153.57:5000', '/home/conversation', {'pid': '0', 'date': DateFormat('yyyy-MM-dd').format(selectedDate)});
    // var url = Uri.http('54.180.153.57:5000', '/home/conversation', {'pid': '0', 'date': '2024-02-18'});
    print("fetchConversation get요청들어갑니다~");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('FetchConversation 에러다 ㅅㅂ~~~');
    }
  }

  void setSelectedDate(DateTime selectedDate) {
    this.selectedDate = selectedDate;
    print(this.selectedDate);
  }

  DateTime getSelectedDate() {
    return selectedDate;
  }

  void setData() async {
    jsonResponse = await fetchConversation();
    bool isDone = false;
    print("Conversation 데이터 받음!");

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


    //test용
    // parentCorrectedText = 'parentCorrectedTextparentCorrectedText1. parentCorrectedTextparentCorrectedText2.parentCorrectedTextparentCorrectedText3.';
    // parentTranslatedText = 'parentTranslatedTextparentTranslatedText1. parentTranslatedTextparentTranslatedText2. parentTranslatedTextparentTranslatedText3.';


    setParentChangedText(parentCorrectedText, parentTranslatedText);
    setChildChangedText(childCorrectedText, childTranslatedText);


    // //값 바뀐다는 걸 알려줌
    // print(parentText);
    // print(parentCorrectedText);
    // print(parentTranslatedText);
    // print(parentImageUrl);
    // print(parentCharacterUrl);
    // print(parentQuestion);
    // print(childCorrectedText);
    // print(childTranslatedText);
    // print(childImageUrl);
    // print(childCharacterUrl);
    // print(childQuestion);
    notifyListeners();
    print("Provider_Home notifyListeners() on");
    print('setData 끝');

  }

  String? getParentText() {
    return parentText;
  }

  String? getParentCorrectedText() {
    return parentCorrectedText;
  }

  String? getParentTranslatedText() {
    return parentTranslatedText;
  }

  void setParentChangedText(String parentCorrectedText, String parentTranslatedText) async {
    parentChangedText = '';
    parentCorrectedTextList = parentCorrectedText.split('.');
    parentTranslatedTextList = parentTranslatedText.split('.');

    for (int i = 0; i < parentCorrectedTextList.length ; i++) {
      parentChangedText += parentCorrectedTextList[i];
      parentChangedText += "\n";
      parentChangedText += parentTranslatedTextList[i];
      parentChangedText += "\n";
    }
    print(parentChangedText);
    print('setParentChangedText 전처리 끝');
  }

  String? getParentChangedText() {
    return parentChangedText;
  }

  String? getParentImageUrl() {
    // parentImageUrl = 'https://i.pinimg.com/736x/90/84/5c/90845c0ec45eba7c8c75d2b08a74a18f.jpg';
    return parentImageUrl;
  }

  String? getParentCharacterUrl() {
    return parentCharacterUrl;
  }

  String? getParentQuestion() {
    return parentQuestion;
  }


  void setChildChangedText(String childCorrectedText, String childTranslatedText) async {
    childChangedText = '';
    childCorrectedTextList = childCorrectedText.split('.');
    childTranslatedTextList = childTranslatedText.split('.');

    for (int i = 0; i < childCorrectedTextList.length ; i++) {
      childChangedText += childCorrectedTextList[i];
      childChangedText += "\n";
      childChangedText += childTranslatedTextList[i];
      childChangedText += "\n";
    }
    print(childChangedText);
    print('setChildChangedText 전처리 끝');

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