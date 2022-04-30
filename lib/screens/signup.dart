// ignore_for_file: prefer_const_constructors

import 'package:anime_info/screens/login.dart';
import 'package:anime_info/screens/profilescreen.dart';
import 'package:anime_info/widgets/passwordTextformfield.dart';
import 'package:anime_info/widgets/textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
bool obserText = true;
bool isMale = true;

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

late final TextEditingController email = TextEditingController();
late final TextEditingController username = TextEditingController();
late final TextEditingController phonenumber = TextEditingController();
late final TextEditingController password = TextEditingController();
late final TextEditingController address = TextEditingController();
GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _SignUpState extends State<SignUp> {
  void validation() async {
    if (username.text.isEmpty &&
        email.text.isEmpty &&
        phonenumber.text.isEmpty &&
        password.text.isEmpty &&
        address.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('All fields are empty'),
        ),
      );
    } else if (username.text.length < 6) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Username must be at least 6'),
        ),
      );
    } else if (email.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Email is empty'),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Invalid Email'),
        ),
      );
    } else if (password.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Password is empty'),
        ),
      );
    } else if (password.text.length < 8) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Password is too short'),
        ),
      );
    } else if (phonenumber.text.length < 8 || phonenumber.text.length > 8) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Phone number at least 8 digits'),
        ),
      );
    } else if (address.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Empty address'),
        ),
      );
    } else {
      try {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text);
        User user = result.user!;
        FirebaseFirestore.instance.collection('user').doc(user.uid).set(
          {
            'Username': username.text,
            'UserId': user.uid,
            'Useremail': email.text,
            'Useraddress': address.text,
            'Gender': isMale == true ? 'Male' : 'Female',
            'Phone Number': phonenumber.text,
          },
        );
      } on PlatformException catch (e) {
        _scaffoldKey.currentState!.showSnackBar(
          SnackBar(
            content: Text(
              e.message.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 260,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[
                      Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 500,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MyTextFormField(
                          controller: username,
                          name: 'Username',
                        ),
                        MyTextFormField(
                          controller: email,
                          name: 'Email',
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isMale = !isMale;
                            });
                          },
                          child: Container(
                            height: 60,
                            padding: EdgeInsets.only(
                              left: 15,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.grey,
                            )),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    isMale == true ? 'Male' : 'Female',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        MyTextFormField(
                          controller: phonenumber,
                          name: 'Address',
                        ),
                        MyTextFormField(
                          controller: phonenumber,
                          name: 'Phone Number',
                        ),
                        PasswordTextFormField(
                          controller: password,
                          name: 'Password',
                          obserText: obserText,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              obserText = !obserText;
                            });
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 45,
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {
                              validation();
                            },
                            child: Text('Register'),
                          ),
                        ),
                        Row(
                          children: [
                            Text('I have already an account!'),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => Login()));
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.cyan,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
