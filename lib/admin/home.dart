import 'package:e_project/admin/productlist.dart';
import 'package:e_project/admin/profile.dart';
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
            title: Text('Watch Hub'),
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
                child: ProductList(),
              ),
              Center(child: Text('Messages Tab Content')),
              Center(child: Text('Search Tab Content')),
              Center(child: Text('My Cart Tab Content')),
              Container(
                child: Adminprofile(
                  uid: user!.uid,
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(top: 16.0), // Adjust the value as needed
            child: Container(
              decoration: BoxDecoration(
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
                    icon: Icon(Icons.message),
                    text: 'Messages',
                  ),
                  Tab(
                    icon: Icon(Icons.search),
                    text: 'Search',
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
