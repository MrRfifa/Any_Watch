import 'package:anime_info/screens/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/usermodel.dart';
import '../provider/show_provider.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController message = TextEditingController();

  late String name = '', email = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void vaildation() async {
    if (message.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Please Fill Message"),
        ),
      );
    } else {
      User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection("Message").doc(user!.uid).set({
        "Name": name,
        "Email": email,
        "Message": message.text,
      });
    }
  }

  Widget _buildSingleField({required String name}) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    ShowProvider provider;
    provider = Provider.of<ShowProvider>(context, listen: false);
    provider.getUserData();
    List<UserModel> user = provider.userModelList;
    user.map((e) {
      name = e.username;
      email = e.useremail;
    }).toList();

    super.initState();
  }

  late ShowProvider provider;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        return Future.value(true);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xfff8f8f8),
          title: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xff746bc9),
              size: 35,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => HomePage(),
                ),
              );
            },
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 27),
              height: 600,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Sent Us Your Message",
                    style: TextStyle(
                      color: Color(0xff746bc9),
                      fontSize: 28,
                    ),
                  ),
                  _buildSingleField(name: name),
                  _buildSingleField(name: email),
                  Container(
                    height: 200,
                    child: TextFormField(
                      controller: message,
                      expands: true,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: " Message",
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      vaildation();
                      print(name + 'vrber');
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
