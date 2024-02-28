import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

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


