import 'package:e_project/SelectRole.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  final String uid;

  const Profile({Key? key, required this.uid}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String _username = '';
  late String _email = '';
  late String _address = '';
  late String _phone = '';
  bool _isEditable = false;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  void fetchUserDetails() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('admin')
          .where('uid', isEqualTo: widget.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Assuming there's only one document matching the uid
        setState(() {
          _username = snapshot.docs.first.data()['admin_name'];
          _email = snapshot.docs.first.data()['email'];
          _address = snapshot.docs.first.data()['address'];
          _phone = snapshot.docs.first.data()['phone'];
        });
      } else {
        print("Document not found for uid: ${widget.uid}");
      }
    } catch (error) {
      print("Error fetching user details: $error");
    }
  }

  void _editProfile() {
    setState(() {
      _isEditable = true;
    });
  }

  void _saveProfile() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('admin')
              .where('uid', isEqualTo: widget.uid)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document matching the uid
        String docId = querySnapshot.docs.first.id;
        await FirebaseFirestore.instance.collection('admin').doc(docId).update({
          'admin_name': _username,
          'email': _email,
          'address': _address,
          'phone': _phone,
        });
        setState(() {
          _isEditable = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile updated successfully'),
          ),
        );
      } else {
        print("Document not found for uid: ${widget.uid}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile. User not found.'),
          ),
        );
      }
    } catch (error) {
      print('Error updating profile: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _isEditable
                  ? TextFormField(
                      initialValue: _username,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _username = value;
                        });
                      },
                    )
                  : Text(_username),
              SizedBox(height: 16),
              Text(
                'Email:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _isEditable
                  ? TextFormField(
                      initialValue: _email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    )
                  : Text(_email),
              SizedBox(height: 16),
              Text(
                'Address:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _isEditable
                  ? TextFormField(
                      initialValue: _address,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _address = value;
                        });
                      },
                    )
                  : Text(_address),
              SizedBox(height: 16),
              Text(
                'Phone:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _isEditable
                  ? TextFormField(
                      initialValue: _phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _phone = value;
                        });
                      },
                    )
                  : Text(_phone),
              SizedBox(height: 16),
              _isEditable
                  ? Row(
                      children: [
                        ElevatedButton(
                          onPressed: _saveProfile,
                          child: Text('Save'),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isEditable = false;
                            });
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              ElevatedButton(
                onPressed: () async {
                  // Handle logout functionality
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          selectrole(), // Replace with your login screen widget
                    ),
                  );
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Background color set to red
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
