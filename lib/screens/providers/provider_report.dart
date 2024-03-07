import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

class ProviderReport with ChangeNotifier {

  late Map<String, dynamic> jsonResponse;

  late String pid;
  late String text;
  late File? image;
  late DateTime selectedDate;

  late String correctedText;
  late String translatedText;
  late String imageUrl = '';

  late String changedText = '';
  late List<String> correctedTextList = [];
  late List<String> translatedTextList = [];

  // /report
  // 추후 수정 필요
  Future<Map<String, dynamic>> writeParentUpload(String pid, String text, File image, DateTime selectedDate) async {
    print("WriteParentUpload 요청");
    try {
      var url = Uri.parse('http://43.202.100.36:5000/home/parent');

      var request = http.MultipartRequest('POST', url);
      request.fields['pid'] = pid; // 사용자가 입력한 pid
      request.fields['text'] = text; // 사용자가 입력한 text
      request.fields['date'] = DateFormat('yyyy-MM-dd').format(selectedDate);

      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        image.path,
      );

      request.files.add(multipartFile);

      var response = await request.send().timeout(Duration(seconds: 2000));

      if (response.statusCode == 200) {
        print('Data uploaded successfully');

        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);

        return jsonResponse = convert.jsonDecode(responseString) as Map<String, dynamic>;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } on TimeoutException catch (e) {
      print('The request timed out: $e');
      throw e; // TimeoutException 다시 던지기
    } catch (e) {
      print('An error occurred: $e');
      throw e; // 다른 예외도 다시 던지기
    }
  }

  void setSelectedDate(DateTime selectedDate) {
    this.selectedDate = selectedDate;
  }

  Future<void> setInput(String pid, String text, File image, DateTime selectedDate) async {
    this.pid = pid;
    this.text = text;
    this.image = image;
    this.selectedDate = selectedDate;
    setData();
  }

  void setData() async {
    jsonResponse = await writeParentUpload(pid,text,image!,selectedDate);
    bool isDone = false;
    print("ParentResult용 데이터 받음!");

    correctedText = jsonResponse['correctedText'];
    imageUrl = jsonResponse['imageUrl'];
    translatedText = jsonResponse['translatedText'];

    notifyListeners();
    print("Provider_Parent_Upload notifyListeners() on");

    setChangedText(correctedText, translatedText);

    //값 바뀐다는 걸 알려줌
    print(correctedText);
    print(translatedText);
    print(imageUrl);
    print(text);
  }

  void setChangedText(String correctedText, String translatedText) async {
    changedText = '';
    correctedTextList = correctedText.split('.');
    translatedTextList = translatedText.split('.');

    for (int i = 0; i < translatedTextList.length ; i++) {
      changedText += correctedTextList[i];
      changedText += "\n";
      changedText += translatedTextList[i];
      changedText += "\n";
    }
    print(changedText);
    print('changedText 전처리 끝');
  }

  String? getChangedText() {
    return changedText;
  }

  String? getImageUrl() {
    return imageUrl;
  }
  String? getText() {
    return text;
  }

}


