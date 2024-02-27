import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';

import '../providers/provider_parent_upload.dart';

class ParentUpload extends StatefulWidget {
  const ParentUpload({Key? key}) : super(key: key);

  @override
  _ParentUploadState createState() => _ParentUploadState();
}

class _ParentUploadState extends State<ParentUpload> {
  File? _image;
  final picker = ImagePicker();


  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _textController = TextEditingController();

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
    return _image;
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        getImage(ImageSource.gallery);
      },
      child: Container(
        color: const Color(0xffffffff),
        width: width,
        height: height * 0.45,
        child: _image == null
            ? Center(
            child: Container(
                width: width * 0.35,
                height: height * 0.35,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffEAEAEA),
                ),
                child: InkWell(
                  child: Image.asset("assets/gallery.png"),
                )
            )
        ) : Image.file(
            File(_image!.path), fit: BoxFit.contain), //통신: image
      ),
    );
  }

  Widget inputText() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      color: const Color(0xff8DBFD2),
      width: width,
      height: height * 0.55,
      child: Column(
        children: [
          SizedBox(height: height * 0.02),
          Row(
            children: [
              SizedBox(width: width * 0.05),
              Text(
                  DateFormat('yyyy년 MM월 dd일 EEEE').format(DateTime.now()),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.02,
                    fontFamily: 'KNU_TRUTH',
                  )
              ),
            ],
          ),
          Row(
              children: [
                SizedBox(width: width * 0.05),
                Text(
                    "엄마의 일기",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.04,
                        fontFamily: 'KNU_TRUTH'

                    )
                ),
              ]
          ),
          diaryWrite(),
          writeDone()
        ],
      ),
    );
  }

  Widget diaryWrite() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final maxLines = 8;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.01),
      // TextField 스크롤 되도록 바꾸기
      child: Container(
        width: width, // <-- TextField width
        height: height * 0.3, // <-- TextField height
        child: TextField(
          controller: _textController,
          style: TextStyle(
            fontFamily: 'KNU_TRUTH',
          ),
          maxLines: maxLines,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "오늘의 일기를 작성하세요. \nHãy viết nhật ký hôm nay.",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * 0.05),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget writeDone() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.8,
      height: height * 0.08,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(60.0),
      ),
      child: TextButton(
        onPressed: () async {
          if (_image != null && _textController.text != '') { // 작성한 text가 null인지 아닌지 확인) {
          // if (_image != null) { // 작성한 text가 null인지 아닌지 확인) {
            String pid = "0";
            //   String text = _textController.text;
            String text = "$_textController.text";
            File image = File(_image!.path); // 사용자가 선택한 이미지 파일

            print(image);
           context.read<ProviderParentUpload>().setInput(pid, text, image!, DateTime.now());
          }
          context.go('/ParentResult');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '작성 완료',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.023,
                  fontFamily: 'KNU_TRUTH'
              ),
            ),
            SizedBox(width: 0),
            Text(
              'Hoàn thành việc',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.012,
                  fontFamily: 'KNU_TRUTH'
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      // 키보드 overflow 방지
      // resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfff4f3f9),
        body: SingleChildScrollView(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                showImage(),
                inputText(),
              ],
            )
        )

    );
  }
}