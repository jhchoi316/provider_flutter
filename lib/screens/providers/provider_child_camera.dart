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
  late String imageUrl='';

  late String changedText = '';
  late List<String> correctedTextList = [];
  late List<String> translatedTextList = [];

  // /home/parent
  Future<Map<String, dynamic>> writeChildCamera(String pid, File image, DateTime selectedDate) async {
    print("WriteChildUpload 요청");
    try {
      var url = Uri.parse('http://43.202.100.36:5000/home/child');

      // 해당 url로 pid, date를 POST
      var request = http.MultipartRequest('POST', url)
        ..fields['pid'] = pid // 사용자가 입력한 pid
        ..fields['date'] = DateFormat('yyyy-MM-dd').format(selectedDate); // 사용자가 입력한 text

      // 이미지 파일을 multipartfile로 변환
      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType('image', 'jpeg'), //서버가 요청된 이미지를 jpeg 형식으로 처리하도록
      );

      // 생성된 MultipartFile 객체를 요청에 추가
      request.files.add(multipartFile);

      var response = await request.send().timeout(Duration(seconds: 2000));

      if (response.statusCode == 200) {
        print('Data uploaded successfully');

        //요청이 성공적으로 처리되면, 서버에서 반환된 데이터를 읽어온다.
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);

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

  // ChildCamera 에서 작성완료 버튼 클릭 시 호출됨
  Future<void> setInput(String pid, File image, DateTime selectedDate) async {
    this.pid = pid;
    this.image = image;
    this.selectedDate = selectedDate;
    await setData();
  }

  Future<void> setData() async {
    jsonResponse = await writeChildCamera(pid,image!,selectedDate);
    print("ChildResult용 데이터 받음!");

    // jsonResponse에 있는 data를 각각 변수에 넣기
    correctedText = jsonResponse['correctedText'];
    imageUrl = jsonResponse['imageUrl'];
    translatedText = jsonResponse['translatedText'];

    notifyListeners();
    print("Provider_Child_Camera notifyListeners() on");

    // 변경된 일기 보여주기 위한 교정본과 번역본 교차 출력 전처리
    setChangedText(correctedText, translatedText);

    //값 바뀐다는 걸 알려줌
    // print(correctedText);
    // print(translatedText);
    // print(imageUrl);
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


