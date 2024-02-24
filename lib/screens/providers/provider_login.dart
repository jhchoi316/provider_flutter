import 'dart:async';

import 'package:flutter/material.dart';

class Provider_LogIn with ChangeNotifier {
  StreamController<int> controller = StreamController.broadcast();

  late Map<String, dynamic> jsonResponse;
  late List<dynamic> completeList;
  late var parentDiaryPreview;
  late String parentCorrectedText;
  late String parentImageUrl;
  late var childDiaryPreview;
  late String childCorrectedText;
  late String childImageUrl;

  void setData(Map<String, dynamic> jsonResponse) {
    print("데이터 받음!");
    completeList = jsonResponse['completeList'];

    parentDiaryPreview = jsonResponse['get_parent_diary_preview'];
    parentCorrectedText = parentDiaryPreview['correctedText'];
    parentImageUrl = parentDiaryPreview['imageUrl'];

    childDiaryPreview = jsonResponse['get_child_diary_preview'];
    childCorrectedText = childDiaryPreview['correctedText'];
    childImageUrl = childDiaryPreview['imageUrl'];

    print(parentCorrectedText);
    print(parentImageUrl);
    print(childCorrectedText);
    print(childImageUrl);
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