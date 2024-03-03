import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const BottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0), // Adjust the value as needed
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
        child: TabBar(
          labelPadding: EdgeInsets.zero,
          labelStyle: TextStyle(fontSize: 10),
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: 'Home',
            ),
            Tab(
              icon: Icon(Icons.book),
              text: 'Order',
            ),
            Tab(
              icon: Icon(Icons.shopping_cart),
              text: 'My Cart',
            ),
            Tab(
              icon: Icon(Icons.person),
              text: 'Profile',
            ),
          ],
          // currentIndex: currentIndex,
          onTap: onTap,
        ),
      ),
    );
  }
}
