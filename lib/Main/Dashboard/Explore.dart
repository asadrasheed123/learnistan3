import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:learnistan/Main/tabbar/matric.dart';
import 'package:learnistan/Main/tabbar/Inter.dart';
import 'package:learnistan/Main/tabbar/Freelancing.dart';
class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  String _userName = "";
  String _profilePictureUrl = "";

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    // Get the current user's uid
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // Get the user's data from Firestore
    DocumentSnapshot userData =
    await FirebaseFirestore.instance.collection("users").doc(uid).get();

    // Set the user's name and profile picture url
    setState(() {
      _userName = userData.get("name");
      _profilePictureUrl = userData.get("profilePictureUrl");
    });
  }
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(length: 3,
      child: Scaffold(
body: SafeArea(
      child:Column(

        children: [
          Container(
            height: 250,width: double.infinity,
            decoration: BoxDecoration(color: Colors.blueGrey.shade400,borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),


            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              Padding(padding: EdgeInsets.only(top: 30,left: 20)
                ,child: Text("HI, $_userName",style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold),)),
                Padding(padding: EdgeInsets.only(left: 20,top: 10),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(_profilePictureUrl),
                  ),
                ),
  Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 30),
      child: Container(height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TextField(

          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search for courses',
            border: InputBorder.none,
          ),
        ),
      ),
  ),


            ],),
          ),
          SizedBox(height: 20,),
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0)
            ),
            child:  TabBar(
              indicator: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius:  BorderRadius.circular(25.0)
              ) ,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: const  [
                Tab(text: 'Matric',),
                Tab(text: 'Inter',),
                Tab(text: 'Freelancing',),

              ],
            ),
          ),
          const Expanded(
              child: TabBarView(
                children:  [
                   matric(),
                 Inter(),
                  Freelancing(),

                ],
              )
          )






        ],

      )




),


      ),
    );
  }
}
