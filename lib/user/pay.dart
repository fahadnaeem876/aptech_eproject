import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_project/user/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth

class Pay extends StatefulWidget {
  final User user; // Accept User object as a parameter

  const Pay({required this.user, Key? key}) : super(key: key);

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user; // Initialize _user with the provided user object
  }

  void _handleCheckout() async {
    try {
      // Get the cart items
      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('carts')
          .where('uid', isEqualTo: _user.uid)
          .get();

      // Add the cart items to the orders collection
      WriteBatch batch = FirebaseFirestore.instance.batch();
      cartSnapshot.docs.forEach((doc) {
        batch.set(
          FirebaseFirestore.instance.collection('orders').doc(),
          doc.data(),
        );
      });
      await batch.commit();

      Navigator.push(context, MaterialPageRoute(builder: (context) => home()));

      // Delete the cart items
      cartSnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });
    } catch (e) {
      // Handle errors here
      print('Error during checkout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Form"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Center(
            child: Container(
              width: 300,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Holder Name", // Changed label to labelText
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: 300,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Account Number", // Changed label to labelText
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: 300,
              child: TextField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: "Expiry Date", // Changed label to labelText
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: _handleCheckout, child: Text("Pay")),
        ],
      ),
    );
  }
}
