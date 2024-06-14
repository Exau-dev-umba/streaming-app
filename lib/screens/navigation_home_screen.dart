import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';
import '../utils/kcolors.dart';
import '../values/app_colors.dart';
import 'home_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({super.key});

  @override
  State<NavigationHomeScreen> createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {

  int _currentIndex = 0;
  final pages= <Widget>[
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  Widget _bottomNav(){
    return BottomNavigationBar(
      backgroundColor: KColors.bgColor,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.white,
      unselectedLabelStyle: TextStyle(fontSize: 12),
      selectedLabelStyle: TextStyle(fontSize: 13),
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _currentIndex == 0
                ? Constants.homeAlt
                : Constants.home,
            height: 25,
            color:
            _currentIndex == 0 ? Colors.white : Colors.grey,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _currentIndex == 1
                ? Constants.searchAlt
                : Constants.search,
            height: 25,
            color:
            _currentIndex == 1 ? Colors.white : Colors.grey,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _currentIndex == 1
                ? Constants.setting
                : Constants.setting,
            height: 25,
            color:
            _currentIndex == 1 ? Colors.white : Colors.grey,
          ),
          label: 'Setting',
        ),
      ],
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

}
