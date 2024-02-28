import 'dart:io';
import 'package:Front_Flutter/screens/providers/provider_parent_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/provider_child_camera.dart';
import '../providers/provider_loading.dart';

class ChildCamera extends StatefulWidget {
  const ChildCamera({Key? key}) : super(key: key);

  @override
  State<ChildCamera> createState() => _ChildCameraState();
}

class _ChildCameraState extends State<ChildCamera> {
  File? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);
    // 통신(image): 선택된 이미지에 대해서 서버에 url 요청
    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
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
        color: const Color(0xFF8DBFD2),
        width: width,
        height: height * 0.45,
        child: _image == null
            ? Center(
            child: Container(
                width: width * 0.35,
                height: height * 0.35,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: InkWell(
                  child: Image.asset("assets/gallery.png"),
                )
            )
        ) : Image.file(
            File(_image!.path), fit: BoxFit.contain),
      ),
    );
  }

  Widget cameraGuide() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      color: const Color(0xFFFFFFFF),
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
                      color: Color(0xff787B7D),
                      fontSize: height * 0.02,
                      fontFamily: 'KNU_TRUTH'
                  )
              ),
            ],
          ),
          Row(
              children: [
                SizedBox(width: width * 0.05),
                Text(
                    "아이의 일기",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color(0xff787B7D),
                        fontSize: height * 0.04,
                        fontFamily: 'KNU_TRUTH'
                    )
                ),
              ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: width * 0.02),
              Container( height:1.0,
                width: width * 0.25,
                color:Color(0xff6B6B6B),
              ),
              Text(
                  "촬영 가이드",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff787B7D),
                      fontSize: height * 0.025,
                      fontFamily: 'KNU_TRUTH'
                  )
              ),
              Container( height:1.0,
                width: width * 0.25,
                color:Color(0xff6B6B6B),
              ),
              SizedBox(width: width * 0.02),
            ],
          ),

          SizedBox(height: height * 0.002),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: width * 0.08),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '1. 글씨가 잘 보이도록 밝은 곳에서 촬영해주세요. \n',
                      style: TextStyle(color: Color(0xff787B7D), fontSize: height * 0.02, fontFamily: 'KNU_TRUTH'),
                    ),
                    TextSpan(
                      text: 'Hãy quay ở nơi sáng để thấy rõ chữ nhé. \n',
                      style: TextStyle(color: Color(0xff8DBFD2), fontSize: height * 0.02, fontFamily: 'KNU_TRUTH'),
                    ),
                    TextSpan(
                      text: '2. 아이 일기를 촬영 영역에 맞춰주세요.\n',
                      style: TextStyle(color: Color(0xff787B7D), fontSize: height * 0.02,fontFamily: 'KNU_TRUTH'),
                    ),
                    TextSpan(
                      text: 'Hãy điều chỉnh nhật ký cho phù hợp với \nlĩnh vực ghi hình.\n',
                      style: TextStyle(color: Color(0xff8DBFD2), fontSize: height * 0.02,fontFamily: 'KNU_TRUTH'),
                    ),
                    TextSpan(
                      text: '3. 표시된 빨간선이 그림과 글씨 사이에 위치하도록\n맞추고 촬영해주세요. \n',
                      style: TextStyle(color: Color(0xff787B7D), fontSize: height * 0.02,fontFamily: 'KNU_TRUTH'),
                    ),
                    TextSpan(
                      text: 'Hãy điều chỉnh và chụp sao cho đường màu\nđỏ được hiển  thị nằm giữa hình ảnh và chữ\nviết. \n',
                      style: TextStyle(color: Color(0xff8DBFD2), fontSize: height * 0.02,fontFamily: 'KNU_TRUTH'),
                    ),
                  ],

                ),
              ),
              SizedBox(width: width * 0.08),
            ],
          ),
          writeDone(),
        ],
      ),
    );
  }

  Widget writeDone() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.8,
      height: height * 0.08,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff8DBFD2)),
        borderRadius: BorderRadius.circular(60.0),
      ),
      child: TextButton(
        onPressed: () async {
          if (_image != null) {
            context.read<ProviderLoading>().setIsLoadingTrue();
            String pid = "0";
            File image = File(_image!.path); // 사용자가 선택한 이미지 파일

            await context.read<ProviderChildCamera>().setInput(pid, _image!, DateTime.now());
            context.read<ProviderLoading>().setIsLoadingFalse();
            context.go('/childResult');
          }

        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '촬영 완료',
              style: TextStyle(color: Color(0xff8DBFD2), fontSize: height * 0.023,fontFamily: 'KNU_TRUTH'),
            ),
            SizedBox(width: 0),
            Text(
              'Quay hình xong',
              style: TextStyle(color: Color(0xff8DBFD2), fontSize: height * 0.013,fontFamily: 'KNU_TRUTH'),
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
                showImage(),
                cameraGuide(),
              ],
            )
        )

    );
  }
}