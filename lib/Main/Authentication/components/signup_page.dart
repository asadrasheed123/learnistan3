import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnistan/Main/Dashboard/dashboard.dart';

import '../../../test/profile.dart';
import 'common/custom_form_button.dart';
import 'common/custom_input_field.dart';
import 'common/page_header.dart';
import 'common/page_heading.dart';
import 'login_page.dart';
import 'package:getwidget/getwidget.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _picker = ImagePicker();
  File? _imageFile;

  void _signUp() async {
    try {
      if (_imageFile != null) {
        if (!EmailValidator.validate(_emailController.text)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a valid email')),
          );
          return;
        }

        // Validate password field
        if (_passwordController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a password')),
          );
          return;
        }
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
            builder: (context) => MyHomePage()
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        body: SingleChildScrollView(


          child: Column(
            children: [
              const PageHeader(),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),),
                ),
                child: Column(
                  children: [
                    const PageHeading(title: 'Sign-up',),
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: _imageFile != null ? FileImage(
                            _imageFile!) : null,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: _getImage,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_sharp,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16,),
                    Padding(padding: EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name',
                          border: OutlineInputBorder(),
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.orangeAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.orangeAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                        hintText: "Enter Name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16,),


                    Padding(padding: EdgeInsets.only(left: 10,right: 10),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email',
                          border: OutlineInputBorder(),hintText: "Enter Email",
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.orangeAccent, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.orangeAccent, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    Padding(padding: EdgeInsets.only(left: 10,right: 10),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password',
                          border: OutlineInputBorder(),
                        hintText: "Enter Password",
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.orangeAccent, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.orangeAccent, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22,),
                Container(width: 280,

                  decoration: BoxDecoration(
                    color: HexColor("#F9A826"),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: _signUp,
                    child: Text("Sign Up", style: const TextStyle(color: Colors.white, fontSize: 20),),
                  ),
                ),
                    const SizedBox(height: 18,),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account ? ', style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff939393),
                              fontWeight: FontWeight.bold),),
                          GestureDetector(
                            onTap: () =>
                            {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const LoginPage()))
                            },
                            child: const Text('Log-in', style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff748288),
                                fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
