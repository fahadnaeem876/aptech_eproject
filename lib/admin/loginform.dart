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
      TextEditingController(text: "admin@gmail.com");
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
      appBar: AppBar(
        title: Center(child: Text('Sign-in Form')),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "User Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              maxLength: 15,
              decoration: InputDecoration(
                labelText: "User Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: login,
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
