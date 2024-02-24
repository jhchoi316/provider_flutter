import 'package:Front_Flutter/screens/providers/provider_login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'screens/home/home.dart';
import 'screens/logIn/login.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Provider_LogIn()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Go Router',
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
    // 처음에 띄워지는 화면 -> 현재는 LogIn 테스트중
    initialLocation: "/logIn",
    routes: [
      GoRoute(
        name: 'LogIn',
        path: "/logIn",
        builder: (context, state) => LogIn(),
      ),
      GoRoute(
        name: 'Home',
        path: "/home",
        builder: (context, state) => Home(),
      ),
    ],
  );
}

