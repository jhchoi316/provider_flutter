import 'dart:io';
import 'package:Front_Flutter/screens/providers/provider_child_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'dart:async';
import 'package:provider/provider.dart';

import '../providers/provider_home.dart';
import '../providers/provider_loading.dart';
import '../providers/provider_parent_upload.dart';

class ParentUpload extends StatefulWidget {
  const ParentUpload({Key? key}) : super(key: key);

  @override
  State<ParentUpload> createState() => _ParentUploadState();
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
    // 갤러리에서 pick한 이미지 정보를 image에 넣음
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); // image의 path에 해당하는 파일을 _image에 저장
    });
    return _image;
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        getImage(ImageSource.gallery); // 이미지를 선택할 소스로 gallery 지정
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
                // !!!!!!!! InkWell 사용 안해도 될 거 같은데 나중에 테스트 해보기
                child: InkWell(
                  child: Image.asset("assets/gallery.png"),
                )
            )
        )
        //_image가 null이 아니면 pick한 이미지 보여주기
        : Image.file(
          File(_image!.path),
          fit: BoxFit.contain
        ),
      ),
    );
  }

  // 부모 일기 작성 부분 & 작성 완료 버튼
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

  // 실제 작성 부분
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
          // 작성된 텍스트는 _textController로 컨트롤
          controller: _textController,
          style: TextStyle(
            fontFamily: 'KNU_TRUTH',
          ),
          maxLines: maxLines,
          keyboardType: TextInputType.multiline, // 여러줄의 텍스트 입력
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

  // 작성 완료 버튼
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
        // 완료 버튼 누르면 ProviderParentUpload로 필요한 data 보내고 페이지 이동
        onPressed: () async {
          if (_image != null && _textController.text != '') {
            context.read<ProviderLoading>().setIsLoadingTrue();

            String pid = "0";
            String text = _textController.text;
            // 코드 수정 필요!!!!!! _image 타입이 File이라서 아래 코드 없이 그냥 _image사용해도 될 것 같음 ( cild camera에서는 _image사용)
            File image = File(_image!.path); // 사용자가 선택한 이미지 파일


            // ProviderParentUpload로 POST 해야할 data 보내기
            await context.read<ProviderParentUpload>().setInput(pid, text, image!, DateTime.now());
            context.read<ProviderLoading>().setIsLoadingFalse();
            context.go('/parentResult');
          }

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
    context.watch<ProviderParentUpload>();
    context.watch<ProviderLoading>();
    bool isLoading = context.read<ProviderLoading>().getIsLoading();
    context.watch<ProviderHome>();

    // print("isLoading Parent Upload $isLoading");

    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
        backgroundColor: const Color(0xff8DBFD2),
        body: isLoading ?
        Center(child: CircularProgressIndicator()) :
        SingleChildScrollView(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                showImage(), //이미지를 보여주는 위젯
                inputText(), // 부모 일기 작성 부분 & 작성 완료 버튼
              ],
            )
        )

    );
  }
}