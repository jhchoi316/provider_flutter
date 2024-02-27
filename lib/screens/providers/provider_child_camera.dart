import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

class ProviderChildCamera with ChangeNotifier {

  late Map<String, dynamic> jsonResponse;

  late String pid;
  late File? image;
  late DateTime selectedDate;

  late String correctedText;
  late String translatedText;
  late String imageUrl;

  late String changedText = '';
  late List<String> correctedTextList = [];
  late List<String> translatedTextList = [];

  // /home/parent
  Future<Map<String, dynamic>> writeChildCamera(String pid, File image, DateTime selectedDate) async {
    print("WriteParentUpload 요청");
    try {
      var url = Uri.http('54.180.153.57:5000', '/home/child');

      var request = http.MultipartRequest('POST', url)
        ..fields['pid'] = pid // 사용자가 입력한 pid
        ..fields['selectedDate'] = DateFormat('yyyy-MM-dd').format(selectedDate); // 사용자가 입력한 text

      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType('image', 'jpeg'),
      );
      // 생성된 MultipartFile 객체를 요청에 추가
      request.files.add(multipartFile);

      var response = await request.send().timeout(Duration(seconds: 1000));

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
    print(this.selectedDate);
  }

  void setInput(String pid, File image, DateTime selectedDate) async {
    this.pid = pid;
    this.image = image;
    this.selectedDate = selectedDate;
    setData();
  }

  void setData() async {
    jsonResponse = await writeChildCamera(pid,image!,selectedDate);
    bool isDone = false;
    print("ChildResult용 데이터 받음!");

    correctedText = jsonResponse['correctedText'];
    imageUrl = jsonResponse['imageUrl'];
    translatedText = jsonResponse['translatedText'];


    notifyListeners();
    print("Provider_Child_Camera notifyListeners() on");

    setChangedText(correctedText, translatedText);

    //값 바뀐다는 걸 알려줌
    print(correctedText);
    print(translatedText);
    print(imageUrl);
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

}


