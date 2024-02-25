import 'package:e_project/admin/loginform.dart';
import 'package:e_project/login.dart';
import 'package:flutter/material.dart';

class selectrole extends StatefulWidget {
  const selectrole({super.key});

  @override
  State<selectrole> createState() => _selectroleState();
}

class _selectroleState extends State<selectrole> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => adminloginform()));
                    },
                    child: Text(
                      "ADMIN",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
              ),
              Container(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => login()));
                    },
                    child: Text(
                      "USER",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
