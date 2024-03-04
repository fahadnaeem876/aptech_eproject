import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_project/admin/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class adminloginform extends StatefulWidget {
  const adminloginform({Key? key}) : super(key: key);

  @override
  _adminloginformState createState() => _adminloginformState();
}

class _adminloginformState extends State<adminloginform> {
  final TextEditingController emailController =
      TextEditingController(text: "admin1@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "12345678");

  void login() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    final String email = emailController.text;
    final String password = passwordController.text;

    try {
      // Authenticate user with Firebase Authentication
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user != null) {
        // Fetch admin document from Firestore
        final QuerySnapshot result = await db
            .collection("admin")
            .where("email", isEqualTo: email)
            .limit(1)
            .get();

        final List<DocumentSnapshot> documents = result.docs;

        if (documents.isNotEmpty) {
          // Admin with matching email found in Firestore
          // Navigator.of(context).pushNamed("/adminhome");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminHome()));
        } else {
          // No admin with matching email found in Firestore
          print("User is not authorized as an admin.");
        }
      } else {
        // User is null, login failed
        print("Login failed. User not found.");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Image.asset(
                "assets/images/loginbi.jpg",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Welcome Admin",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        margin: EdgeInsets.only(top: 60),
                        height: 380,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(22, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Positioned(
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextField(
                                controller: emailController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "User Name",
                                  labelStyle: TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                maxLength: 15,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "User Password",
                                  labelStyle: TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                width: 300,
                                child: ElevatedButton(
                                  onPressed: login,
                                  child: Text("Sign In"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
