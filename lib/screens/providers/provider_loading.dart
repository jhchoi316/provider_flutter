import 'package:flutter/material.dart';

// 로딩 페이지를 위한 변수 설정 및 반환하는 Provider
class ProviderLoading with ChangeNotifier {

  bool isLoading = false;

  void setIsLoadingTrue(){
    isLoading = true;
    notifyListeners();

  }
  void setIsLoadingFalse(){
    isLoading = false;
    notifyListeners();

  }

  bool getIsLoading() {
    return isLoading;
  }
}


