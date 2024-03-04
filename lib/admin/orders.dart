import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Orders')),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var order = snapshot.data!.docs[index].data();
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(order['imgurl']),
                  ),
                  title: Text(order['title'],
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text(order['subtitle'],
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: Text('${order['price']}',
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  // Display additional order details as needed
                  onTap: () {
                    // Handle tapping on order item
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No orders found'));
          }
        },
      ),
    );
  }
}
