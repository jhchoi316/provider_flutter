import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'screens/conversation/conversation.dart';
import 'screens/diaries/child_diary_camera.dart';
import 'screens/diaries/child_diary_result.dart';
import 'screens/diaries/parent_diary_result.dart';
import 'screens/diaries/parent_diary_upload.dart';
import 'screens/home/home.dart';
import 'screens/logIn/login.dart';
import 'screens/providers/provider_child_camera.dart';
import 'screens/providers/provider_home.dart';
import 'screens/providers/provider_loading.dart';
import 'screens/providers/provider_login.dart';
import 'screens/providers/provider_parent_upload.dart';
import 'screens/providers/provider_report.dart';
import 'screens/report/report.dart';
import 'screens/settings/setting.dart';
import 'screens/widgets/scaffold_with_nav_bar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderLogIn()),
        ChangeNotifierProvider(create: (_) => ProviderHome()),
        ChangeNotifierProvider(create: (_) => ProviderParentUpload()),
        ChangeNotifierProvider(create: (_) => ProviderChildCamera()),
        ChangeNotifierProvider(create: (_) => ProviderReport()),
        ChangeNotifierProvider(create: (_) => ProviderLoading()),

        // ChangeNotifierProvider(create: (_) => ProviderSettings()),

      ],
      // MyApp()을 child로 해서 위의 provider들이 앱 전체에서 사용되도록 함
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    //앱의 페이지 관리를 위한 router 등록
    return MaterialApp.router(
      title: 'Go Router',
      routerConfig: _router,
    );
  }

  // 각 페이지로 이동할 수 있는 GoRoute
  final GoRouter _router = GoRouter(
    // 처음에 띄워지는 화면 -> 현재는 LogIn
    initialLocation: "/logIn",
    routes: [
      GoRoute(
        name: 'LogIn',
        path: "/logIn",
        builder: (context, state) => LogIn(),
      ),
      //StatefulShellRoute 사용해서 bottomNavigationBar를 이용한 페이지 관리 설정
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell:navigationShell),
        branches: [
          StatefulShellBranch(
            routes: <RouteBase> [
              GoRoute(
                name: 'Home',
                path: "/home",
                builder: (context, state) => Home(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase> [
              GoRoute(
                name: 'Conversation',
                path: "/conversation",
                builder: (context, state) => Conversation(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase> [
              GoRoute(
                name: 'Report',
                path: "/report",
                builder: (context, state) => Report(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase> [
              GoRoute(
                name: 'Settings',
                path: "/settings",
                builder: (context, state) => Settings(),
              ),
            ],
          )
        ],
      ),
      GoRoute(
        name: 'ParentUpload',
        path: "/parentUpload",
        builder: (context, state) => ParentUpload(),
      ),
      GoRoute(
        name: 'ParentResult',
        path: "/parentResult",
        builder: (context, state) => ParentResult(),
      ),
      GoRoute(
        name: 'ChildCamera',
        path: "/childCamera",
        builder: (context, state) => ChildCamera(),
      ),
      GoRoute(
        name: 'ChildResult',
        path: "/childResult",
        builder: (context, state) => ChildResult(),
      ),
    ],
  );
}

