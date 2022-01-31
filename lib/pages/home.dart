import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taneo/pages/tabs/home_tab.dart';
import 'package:taneo/pages/tabs/search_tab.dart';
import 'package:taneo/util/style.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    Style.height = MediaQuery.of(context).size.height;
    Style.width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: PageView(
          controller: pageController,
          onPageChanged: (page){
            setState(() {
              _selectedIndex=page;
            });
          },
          children: [
            const HomeTab(),
            const SearchTab(),
            Container(color: Colors.blue),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.square_stack_3d_up), label: 'Library'),
        ],
        currentIndex: _selectedIndex,
        onTap: onTapped,
      ),
    );
  }
}
