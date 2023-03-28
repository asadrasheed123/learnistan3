import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:learnistan/onboard/onboard.dart';
import 'package:learnistan/test/profile.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> _login() async {
    try {
      setState(() {
        _isLoading = true;
      });
      // Validate form fields
      if (!_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Sign in with email and password
      final authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navigate to home screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Onboard(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password provided for that user.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred while signing in.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: SingleChildScrollView(
        child: Form(
        key: _formKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Text(
        'Login',
        style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(height: 16.0),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32.0),
    child: TextFormField(
    controller: _emailController,
    keyboardType: TextInputType.emailAddress,
    decoration: const InputDecoration(
    hintText: 'Email',
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter an email';
    }
    if (!EmailValidator.validate(value)) {
    return 'Please enter a valid email';
    }
    return null;
    },
    ),
    ),
    const SizedBox(height: 16.0),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32.0),
    child: TextFormField(
    controller: _passwordController,
    obscureText: true,
    decoration: const InputDecoration(
    hintText: 'Password',

    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a password';
    }
    if (value.length < 6) {
    return 'Password must be at least 6 characters long';
    }
    return null;
    },
    ),
    ),
    const SizedBox(height: 16.0),
    ElevatedButton(
    onPressed: _isLoading ? null : _login,
    child: _isLoading
    ? CircularProgressIndicator()
    : Text('Login'),
    )
    ]
    )
    )
    )
    )
    );



    }
}