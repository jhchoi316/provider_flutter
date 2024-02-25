import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF8DBFD2),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                navigationShell.goBranch(0); // Go to the first indexedStack item
              },
            ),
            IconButton(
              icon: Icon(Icons.menu_book),
              onPressed: () {
                navigationShell.goBranch(1); // Go to the first indexedStack item
              },
            ),
            IconButton(
              icon: Icon(Icons.bar_chart),
              onPressed: () {
                navigationShell.goBranch(2); // Go to the first indexedStack item
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                navigationShell.goBranch(3); // Go to the first indexedStack item
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    color: Colors.transparent,
                    height: height * 0.33,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Image.asset('assets/write_button.png'),
                        Positioned(
                          top: height * 0.03,
                          child: Container(
                            width: width * 0.4,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xFF8DBFD2),
                              ),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: '부모 일기 작성\nViết nhật ký',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                context.go("/parentUpload");
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Image.asset(
              'assets/dasol.png',
              width: MediaQuery.of(context).size.height * 0.08,
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            backgroundColor: Colors.transparent,
            shape: CircleBorder(),
          );
        },
      ),
      extendBody: true,

    );
  }
}
