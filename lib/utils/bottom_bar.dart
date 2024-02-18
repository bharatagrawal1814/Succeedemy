import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:succeedemy/features/home/screens/home_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<Widget> pages = [
    const HomeScreen(),
    const Center(
      child: Text('Home2'),
    ),
    const Center(
      child: Text('Home3'),
    ),
    const Center(
      child: Text('Home4'),
    ),
    const Center(
      child: Text('Home5'),
    )
  ];
  int selectedIndex = 0;
  void _tabChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // color: Colors.black,
          boxShadow: [
            BoxShadow(
              spreadRadius: -10,
              blurRadius: 60,
              color: Colors.black.withOpacity(.20),
              offset: const Offset(0, 15),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 11),
          child: GNav(
            gap: 10,
            color: Colors.grey[600],
            activeColor: Colors.white,
            rippleColor: Colors.green[800]!,
            hoverColor: Colors.lightGreen[700]!,
            iconSize: 20,
            textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            tabBackgroundColor: Colors.green[900]!,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.5),
            duration: const Duration(milliseconds: 800),
            tabs: const [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: LineIcons.heart,
                text: 'Likes',
              ),
              GButton(
                icon: LineIcons.search,
                text: 'Search',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: _tabChanged,
          ),
        ),
      ),
    );
  }
}
