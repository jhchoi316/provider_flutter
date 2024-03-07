import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProviderParentUpload with ChangeNotifier {

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

  // /home/parent
  Future<Map<String, dynamic>> writeParentUpload(String pid, String text, File image, DateTime selectedDate) async {
    // print("WriteParentUpload 요청");

    try {
      var url = Uri.parse('http://43.202.100.36:5000/home/parent');

      // 해당 url로 pid, text, date를 POST
      var request = http.MultipartRequest('POST', url);
      request.fields['pid'] = pid; // 사용자가 입력한 pid
      request.fields['text'] = text; // 사용자가 입력한 text
      request.fields['date'] = DateFormat('yyyy-MM-dd').format(selectedDate); // 사용자가 입력한 text

      // 이미지 파일을 multipartfile로 변환
      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        image.path,
      );

      request.files.add(multipartFile); // POST 요청에 추가

      var response = await request.send().timeout(Duration(seconds: 2000));

      if (response.statusCode == 200) {
        // print('Data uploaded successfully');

        // 요청이 성공적으로 처리되면, 서버에서 반환된 데이터를 읽어온다.
        // 스트림으로 읽어와서 바이트로 변환
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData); //문자열로 디코딩

        // json 형식으로 decode해서 return
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

  // ParentUpload 에서 작성완료 버튼 클릭 시 호출됨
  // 실질적으로 호출될 때 받을 인자값들을 Provider를 통해 공유하기 위함
  Future<void> setInput(String pid, String text, File image, DateTime selectedDate) async {
    this.pid = pid;
    this.text = text;
    this.image = image;
    this.selectedDate = selectedDate;
    await setData(); // 데이터 받기 위한 setData() 호출
  }

  // 서버에 POST 요청을 보내고, 다시 받은 데이터를 사용하기 위한 포멧으로 만들어주기 위함
  Future<void> setData() async {
    jsonResponse = await writeParentUpload(pid,text,image!,selectedDate);
    // print("ParentResult용 데이터 받음!");

    // jsonResponse에 있는 data를 각각 변수에 넣기
    correctedText = jsonResponse['correctedText'];
    imageUrl = jsonResponse['imageUrl'];
    translatedText = jsonResponse['translatedText'];

    // 이 데이터를 사용해야하는 부분에 작업이 끝났음을 알림
    notifyListeners();
    // print("Provider_Parent_Upload notifyListeners() on");

    // 변경된 일기 보여주기 위한 교정본과 번역본 교차 출력 전처리
    setChangedText(correctedText, translatedText);

    // 확인용 print문
    // print(correctedText);
    // print(translatedText);
    // print(imageUrl);
    // print(text);
  }

  // 변경된 일기 보여주기 위한 교정본과 번역본 교차 출력 전처리
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

    // print(changedText);
    // print('changedText 전처리 끝');
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


