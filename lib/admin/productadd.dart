import 'dart:io';

import 'package:e_project/admin/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();

  String? imagePath;

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = image?.path;
    });
  }

  void submit() async {
  try {
    if (imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please upload an image.'),
        ),
      );
      return;
    }

    final String name = nameController.text;
    final String subtitle = subtitleController.text;
    final String price = priceController.text;
    final String description = descriptionController.text;

    final String imageName = imagePath!.split('/').last;
    final firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref(imageName);
    final File file = File(imagePath!);
    await ref.putFile(file);

    final String downloadUrl = await ref.getDownloadURL();

    final FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection("products").add({
      "title": name,
      "subtitle": subtitle,
      "price": price,
      "Description": description,
      "imgurl": downloadUrl,
      "imageName": imageName,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Your product was added.'),
        action: SnackBarAction(
          label: 'Go to Admin Home',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AdminHome(),
              ),
            );
          },
        ),
      ),
    );
  } catch (e) {
    print("Error uploading image: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to add product.'),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              maxLength: 16,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Watch Name",
                hintText: "Enter Your Product Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: subtitleController,
              maxLength: 16,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Watch Subtitle",
                hintText: "Enter Your Watch Subtitle Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Product Price",
                hintText: "Enter Your Product Price",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Product Description",
                hintText: "Enter Your Product Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            imagePath != null
                ? Image.file(
                    File(imagePath!),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  )
                : SizedBox(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: pickImage,
                  child: Text("Upload Product Image"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: submit,
                  child: Text("Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
