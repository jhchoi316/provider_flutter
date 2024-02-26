import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

class ProviderParentUpload with ChangeNotifier {

  late Map<String, dynamic> jsonResponse;

  late String pid;
  late String text;
  late File? image;
  late DateTime selectedDate;


  late String correctedText;
  late String translatedText;
  late String imageUrl;

  // /home/parent
  Future<Map<String, dynamic>> writeParentUpload(String pid, String text, File image, DateTime selectedDate) async {
    print("WriteParentUpload 요청");
    try {
      var url = Uri.http('54.180.153.57:5000', '/home/parent');

      var request = http.MultipartRequest('POST', url)
        ..fields['pid'] = pid // 사용자가 입력한 pid
        ..fields['text'] = text// 사용자가 입력한 text
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

  void setInput(String pid, String text, File image, DateTime selectedDate) async {
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

    //값 바뀐다는 걸 알려줌
    print(correctedText);
    print(translatedText);
    print(imageUrl);
    print(text);
  }

  String? getCorrectedText() {
    return correctedText;
  }
  String? getTranslatedText() {
    return translatedText;
  }
  String? getImageUrl() {
    return imageUrl;
  }
  String? getText() {
    return text;
  }

}


