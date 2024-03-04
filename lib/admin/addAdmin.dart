import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateAdmin extends StatefulWidget {
  const CreateAdmin({Key? key}) : super(key: key);

  @override
  _CreateAdminState createState() => _CreateAdminState();
}

class _CreateAdminState extends State<CreateAdmin> {
  final TextEditingController adminnameController = TextEditingController();
  final TextEditingController adminemailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _createAdmin() async {
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: adminemailController.text.trim(),
              password: passwordController.text.trim());

      // Save user's information in admin collection in Firestore
      await FirebaseFirestore.instance
          .collection('admin')
          .doc(userCredential.user!.uid)
          .set({
        'admin_name': adminnameController.text.trim(),
        'email': adminemailController.text.trim(),
        'phone': phoneController.text.trim(),
        'address': addressController.text.trim(),
        'uid': userCredential.user!.uid,
      });

      // Clear text controllers after successful creation
      adminnameController.clear();
      adminemailController.clear();
      phoneController.clear();
      addressController.clear();
      passwordController.clear();

      // Show a success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Admin created successfully'),
        ),
      );
    } catch (error) {
      // Handle any errors that occur during the creation process
      print('Error creating admin: $error');
      // Optionally, show a snackbar or toast to indicate the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create admin. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Admin"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: adminnameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Admin Name",
                hintText: "Enter Admin Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: adminemailController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Email Address",
                hintText: "Enter Email Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Phone Number",
                hintText: "Enter Your Phone Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: addressController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Address",
                hintText: "Enter Your Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: true, // Hide password characters
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _createAdmin, child: Text("Create")),
          ],
        ),
      ),
    );
  }
}
