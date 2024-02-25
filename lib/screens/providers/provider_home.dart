import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProviderHome with ChangeNotifier {
  StreamController<int> controller = StreamController.broadcast();

  late Map<String, dynamic> jsonResponse;

  late var parentDiary;
  late String parentText;
  late String parentCorrectedText;
  late String parentTranslatedText;
  late String parentImageUrl;
  late String parentCharacterUrl;
  late String parentQuestion;

  late var childDiary;
  late String childCorrectedText;
  late String childTranslatedText;
  late String childImageUrl;
  late String childCharacterUrl;
  late String childQuestion;

  late DateTime selectedDate;

  // home/conversation
  Future<Map<String, dynamic>> fetchConversation() async {
    // var url = Uri.http('54.180.153.57:5000', '/home/conversation', {'pid': '0', 'date': DateFormat('yyyy-MM-dd').format(selectedDate)});
    var url = Uri.http('54.180.153.57:5000', '/home/conversation', {'pid': '0', 'date': '2024-02-18'});
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

    notifyListeners();
    print("Provider_Home notifyListers() on");

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

  }

  String? getParentCorrectedText() {
    return parentCorrectedText;
  }

  String? getParentTranslatedText() {
    return parentTranslatedText;
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