import 'package:e_project/user/home.dart';
import 'package:e_project/user/pay.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  Future<void> _deleteCartItem(String cartItemId) async {
    try {
      await FirebaseFirestore.instance
          .collection('carts')
          .doc(cartItemId)
          .delete();
    } catch (e) {
      // Handle errors here
      print('Error deleting cart item: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: _user != null
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('carts')
                  .where('uid', isEqualTo: _user!.uid) // Filter by UID
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No items in cart'));
                } else {
                  List<Map<String, dynamic>> cartItems = snapshot.data!.docs
                      .map((doc) => doc.data() as Map<String, dynamic>)
                      .toList();
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final cartItem = cartItems[index];
                            final cartItemId = snapshot.data!.docs[index].id;
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(16),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    cartItem['imgurl'] ?? '',
                                    width: 64,
                                    height: 64,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  cartItem['title'] ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  cartItem['subtitle'] ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Container(
                                  width: 100, // Adjust width as needed
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${cartItem['price'] ?? ''}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              8), // Add some spacing between price and delete button
                                      IconButton(
                                        color: Colors.red,
                                        iconSize: 24,
                                        icon: Icon(Icons.delete),
                                        onPressed: () =>
                                            _deleteCartItem(cartItemId),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Pay(user: _user!)));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green, // background color
                                onPrimary: Colors.white, // text color
                              ),
                              child: Text('Check Out'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            )
          : Center(
              child: Text('Please log in to view your cart'),
            ),
    );
  }
}
