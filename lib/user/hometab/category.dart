import 'package:flutter/material.dart';
import 'package:e_project/user/hometab/watchCart.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    child: Text(
                      "Top Models",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  Container(
                    width: 130,
                    height: 210,
                    color: Color.fromARGB(255, 228, 226, 226),
                    child: Image.asset("assets/images/model5.png"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 130,
                    height: 210,
                    color: Color.fromARGB(255, 228, 226, 226),
                    child: Image.asset("assets/images/model6.png"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 130,
                    height: 210,
                    color: Color.fromARGB(255, 228, 226, 226),
                    child: Image.asset("assets/images/model7.png"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 210,
                    width: 150,
                    color: Color.fromARGB(255, 228, 226, 226),
                    child: Image.asset(
                      "assets/images/model8.png",
                      width: 200,
                      height: 300,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "Available Watches",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                WatchCart(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
