import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

import 'home_admin.dart';

class AddRecommendationForm extends StatefulWidget {
  @override
  _AddRecommendationFormState createState() => _AddRecommendationFormState();
}

class _AddRecommendationFormState extends State<AddRecommendationForm> {
  void setPictureUrl(String url) {
    setState(() {
      _pictureUrl = url;
    });
  }

  final _formKey = GlobalKey<FormState>();
  String _pictureUrl = '';
  String _destinationName = '';
  String _location = '';
  String _description = '';
  double _rating = 0; // New variable for rating
  double _price = 0.0; // Add this variable for price

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Recommendation Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    final bytes = await pickedFile.readAsBytes();
                    // Upload the image to Firebase Storage
                    final imageUrl = await _uploadImageToStorage(bytes);
                    setState(() {
                      _pictureUrl = imageUrl;
                    });
                  }
                },
                child: Text('Upload Image'),
              ),
              _pictureUrl.isNotEmpty
                  ? Image.network(
                      _pictureUrl,
                      height: 200,
                      width: 200,
                      fit: BoxFit.fill,
                    )
                  : Text('No image selected.'),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Food Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a food name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _destinationName = value!;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
                onSaved: (value) {
                  _location = value!;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
                maxLines: 3,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Rating: "),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 30,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              // SizedBox(height: 5),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _uploadImageToStorage(List<int> bytes) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final imagePath = 'images/$timestamp.jpg';
      final storageReference = _storage.ref().child(imagePath);
      final uploadTask = storageReference.putData(Uint8List.fromList(bytes));

      // Wait for the upload to complete
      await uploadTask.whenComplete(() {});

      // Get the download URL from the storage reference
      final imageUrl = await storageReference.getDownloadURL();

      return imageUrl;
    } catch (error) {
      print('Error uploading image to Firebase Storage: $error');
      // Handle error as needed
      return '';
    }
  }

  Future<void> _saveDataToFirestore() async {
    try {
      await _firestore.collection('admin').add({
        'pictureUrl': _pictureUrl,
        'destinationName': _destinationName,
        'location': _location,
        'description': _description,
        'rating': _rating,
        'price': _price // Add rating field
      });

      // Data successfully saved to Firestore
      print('Data saved to Firestore!');

      // Show a success notification
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data saved successfully!'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } catch (error) {
      // Handle errors
      print('Error saving data to Firestore: $error');
    }
  }

  Future<void> _submitForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        await _saveDataToFirestore();
      }
    } catch (error) {
      print('Error submitting form: $error');
      // Show an error notification or feedback to the user
    }
  }
}
