import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String imageUrl;

  const ProfileScreen({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 75,
            backgroundImage: NetworkImage(imageUrl),
          ),
          SizedBox(height: 16),
          Text(
            name,
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
