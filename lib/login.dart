import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_project/register.dart';
import 'package:e_project/user/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController emailController =
      TextEditingController(text: "muhammadfahadnaeem4@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "12345678");

  void login() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    final String email = emailController.text;
    final String password = passwordController.text;

    try {
      final UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final DocumentSnapshot snapshot =
          await db.collection("users").doc(user.user!.uid).get();

      final data = snapshot.data();

      // Navigator.of(context).pushNamed("/home");
      Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Sigin Form')),
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
            SizedBox(height: 5),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Text("signup if you don't have an account")),
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
