import 'package:flutter/material.dart';
import 'package:e_project/user/hometab/category.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5, // Updated length to 5 for 5 tabs
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Add functionality for search icon
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        // Add functionality for shopping icon
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'User Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    // Add functionality for Item 1
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Add functionality for Item 2
                  },
                ),
                // Add more ListTiles for additional items
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Contents for the home tab
              Container(
                child: Home(),
              ),
              // Contents for the messages tab
              Center(child: Text('Messages Tab Content')),
              // Contents for the search tab
              Center(child: Text('Search Tab Content')),
              // Contents for the favorites tab
              Center(child: Text('Favorites Tab Content')),
              // Contents for the profile tab
              Center(child: Text('Profile Tab Content')),
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
                    icon: Icon(Icons.favorite),
                    text: 'Favorites',
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
      length: 3, // Updated length to 5 for 5 tabs
      initialIndex: 1, // Set initial index to 1 for "Categories" tab
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Feed'),
                Tab(text: 'Categories'),
                Tab(text: 'Watch Scanner'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('Feed Tab Content')),
                  Container(
                    child: Category(),
                  ),
                  Center(child: Text('Watch Scanner Tab Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
