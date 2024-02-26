import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My Orders')),
      ),
      body: _user != null
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .where('uid', isEqualTo: _user!.uid) // Filter by UID
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No orders yet'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final order = snapshot.data!.docs[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            order['imgurl'] ?? '',
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(order['title'] ?? ''),
                        subtitle: Text(order['subtitle'] ?? ''),
                        trailing: Text("Paid"),
                        // Add more fields if needed
                      );
                    },
                  );
                }
              },
            )
          : Center(
              child: Text('Please log in to view your orders'),
            ),
    );
  }
}
