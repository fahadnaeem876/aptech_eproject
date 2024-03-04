import 'package:e_project/login.dart';
import 'package:e_project/user/hometab/allbrand.dart';
import 'package:e_project/user/hometab/mycart.dart';
import 'package:e_project/user/hometab/userprofile.dart';
import 'package:e_project/user/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_project/user/hometab/category.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Image.asset(
                  "assets/images/watchhub1.png",
                  height: 120,
                ),
                Spacer(), // Adds space between text and icons
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Add functionality for search icon
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Contents for the home tab
              Container(
                child: Home(),
              ),
              Container(
                child: Order(),
              ),
              // Contents for the messages tab
              // Contents for the search tab
              // Contents for the favorites tab
              Container(
                child: MyCart(),
              ),
              Container(
                child: Profile(
                  uid: user!.uid,
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(top: 16.0), // Adjust the value as needed
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Updated length to 5 for 5 tabs
      initialIndex: 0, // Set initial index to 1 for "Categories" tab
      child: Scaffold(
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Categories'),
                Tab(text: 'All Brands'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    child: Category(),
                  ),
                  Container(
                    child: AllBrandsScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
