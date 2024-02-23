import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  String imagePath = '';

  @override
  Widget build(BuildContext context) {
    void pickImage() async {
      final ImagePicker _picker = ImagePicker();
      final image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        imagePath = image!.path;
      });
    }

    void submit() async {
      print("Submitting...");
      try {
        String name = namecontroller.text;
        String price = pricecontroller.text;
        String description = descriptioncontroller.text;

        firebase_storage.FirebaseStorage storage =
            firebase_storage.FirebaseStorage.instance;

        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref('/image.jpeg');

        File file = File(imagePath);
        await ref.putFile(file);

        String downloadurl = await ref.getDownloadURL();

        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection("products").add({
          "title": name,
          "price": price,
          "Description": description,
          "imgurl": downloadurl
        });

        print("Product uploaded successfully");
        print(downloadurl);
      } catch (e) {
        print("Error uploading image: $e");
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Add Product")),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: namecontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: Text("Product Name"),
                      hintText: "Enter Your Product Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 300,
                child: TextField(
                  controller: pricecontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: Text("Product Price"),
                      hintText: "Enter Your Product Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 300,
                child: TextField(
                  controller: descriptioncontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: Text("Product Description"),
                      hintText: "Enter Your Product Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: pickImage,
                      child: Text("Upload Product Image")),
                  SizedBox(
                    width: 18,
                  ),
                  ElevatedButton(onPressed: submit, child: Text("Submit")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
