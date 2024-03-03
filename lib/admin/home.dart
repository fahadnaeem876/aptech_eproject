import 'package:e_project/admin/admins.dart';
import 'package:e_project/admin/orders.dart';
import 'package:e_project/admin/productlist.dart';
import 'package:e_project/admin/profile.dart';
import 'package:e_project/admin/users.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: Image.asset(
              "assets/images/watchhub1.png",
              height: 120,
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            ],
          ),
          body: TabBarView(
            children: [
              Container(
                child: const ProductList(),
              ),
              Container(
                child: const Users(),
              ),
              Container(
                child: const Orders(),
              ),
              Container(
                child: const Admins(),
              ),
              Container(
                child: Profile(
                  uid: user!.uid,
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.only(top: 16.0), // Adjust the value as needed
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey),
                ),
              ),
              child: const TabBar(
                labelPadding: EdgeInsets.zero,
                labelStyle: TextStyle(fontSize: 10),
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                    text: 'Home',
                  ),
                  Tab(
                    icon: Icon(Icons.dashboard_customize),
                    text: 'Users',
                  ),
                  Tab(
                    icon: Icon(Icons.book),
                    text: 'Order',
                  ),
                  Tab(
                    icon: Icon(Icons.admin_panel_settings),
                    text: 'Admin',
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                    text: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
