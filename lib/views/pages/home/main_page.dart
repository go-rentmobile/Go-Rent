import 'package:flutter/material.dart';
import 'package:go_rent/views/pages/home/history_screen.dart';
import 'package:go_rent/views/pages/home/home_screen.dart';
import 'package:go_rent/views/pages/home/profile_screen.dart';
import 'package:go_rent/views/themes/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  Widget body() {
    switch (currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const HistoryScreen();
      case 2:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  Widget customBottomNav() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(30),
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10, // membuat margin
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.developer_board,
                size: 24.0,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.developer_board,
                size: 24.0,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.developer_board,
                size: 24.0,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
