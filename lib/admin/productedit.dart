import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProductEdit extends StatefulWidget {
  final DocumentSnapshot product;

  const ProductEdit({Key? key, required this.product}) : super(key: key);

  @override
  _ProductEditState createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;

  File? _imageFile; // New image file
  String? _imageUrl; // New image URL or existing image URL

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product['title']);
    _subtitleController =
        TextEditingController(text: widget.product['subtitle']);
    _priceController = TextEditingController(text: widget.product['price']);
    _descriptionController =
        TextEditingController(text: widget.product['Description']);
    _imageUrlController = TextEditingController(text: widget.product['imgurl']);
    _imageUrl = widget.product['imgurl']; // Initialize with existing image URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _subtitleController,
                decoration: InputDecoration(labelText: 'Subtitle'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 16),
              _buildImagePreview(),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Upload New Image'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    if (_imageFile != null) {
      return Image.file(
        _imageFile!,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      );
    } else if (_imageUrl != null) {
      return Image.network(
        _imageUrl!,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        height: 150,
        width: 150,
        color: Colors.grey[300],
        child: Icon(Icons.image, size: 50),
      );
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveChanges() async {
    // Update product details in Firestore
    try {
      if (_imageFile != null) {
        // Upload new image to Firebase Storage
        final String fileName =
            DateTime.now().millisecondsSinceEpoch.toString();
        final Reference storageRef =
            FirebaseStorage.instance.ref().child('products').child(fileName);
        await storageRef.putFile(_imageFile!);
        _imageUrl = await storageRef.getDownloadURL();
      }

      // Update product details in Firestore
      FirebaseFirestore.instance
          .collection('products')
          .doc(widget.product.id)
          .update({
        'title': _titleController.text,
        'subtitle': _subtitleController.text,
        'price': _priceController.text,
        'Description': _descriptionController.text,
        'imgurl': _imageUrl ??
            widget.product[
                'imgurl'], // Use new image URL if available, otherwise keep the existing one
      });

      // Show a snackbar to indicate success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product updated successfully')),
      );

      // Optionally navigate back to the product list screen
      Navigator.pop(context);
    } catch (error) {
      // Show a snackbar to indicate error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update product: $error')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}
