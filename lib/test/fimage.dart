import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnistan/test/profile.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _picker = ImagePicker();
  File? _imageFile;

  void _signUp() async {
    try {
      if (_imageFile != null) {
        // Upload image to Firebase Storage
        final storageReference =
        FirebaseStorage.instance.ref().child('profile_pictures').child(
            _imageFile!.path);
        final uploadTask = storageReference.putFile(_imageFile!);
        await uploadTask.whenComplete(() => null);

        // Get image download URL
        final imageUrl = await storageReference.getDownloadURL();

        // Get user's name, email, and password from the text fields
        final name = _nameController.text;
        final email = _emailController.text;
        final password = _passwordController.text;

        // Create new user in Firebase Authentication
        final authResult = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final uid = authResult.user!.uid;

        // Store user data in Firebase Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set({
          'uid': uid,
          'name': name,
          'email': email,
          'profilePictureUrl': imageUrl,
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProfileScreen(name: name, imageUrl: imageUrl),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text('Email'),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              Text('Password'),
              TextField(
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              Text('Profile Picture'),
              SizedBox(height: 8.0),
              _imageFile != null
                  ? Image.file(_imageFile!, height: 200.0)
                  : SizedBox(height: 200.0),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Choose Image'),
              ),
              ElevatedButton(
                onPressed: _signUp,
                child: Text('Sign Up'),
              ),
            ]
        ),
      ),
    );
  }
}

