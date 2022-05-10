import 'package:anime_info/screens/homepage.dart';
import 'package:anime_info/screens/login.dart';

import 'package:anime_info/widgets/mybutton.dart';

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
bool isLoading = false;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

late final TextEditingController email = TextEditingController();
late final TextEditingController username = TextEditingController();
late final TextEditingController phonenumber = TextEditingController();
late final TextEditingController password = TextEditingController();
late final TextEditingController address = TextEditingController();
GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _SignUpState extends State<SignUp> {
  void submit() async {
    late UserCredential result;
    try {
      setState(() {
        isLoading = true;
      });
      result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      print(result);
    } on PlatformException catch (error) {
      var message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message.toString();
      }
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text(message.toString()),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.toString().substring(36)),
        duration: Duration(milliseconds: 2000),
        backgroundColor: Theme.of(context).primaryColor,
      ));

      print(error);
    }
    FirebaseFirestore.instance.collection("user").doc(result.user?.uid).set({
      "Username": username.text,
      "UserId": result.user!.uid,
      "Useremail": email.text,
      "Useraddress": address.text,
      "Gender": isMale == true ? "Male" : "Female",
      "Phone Number": phonenumber.text,
      "Userimage": '',
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => HomePage(),
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

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
      submit();
    }
  }

  Widget _buildAllTextFormField() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MyTextFormField(
            name: "UserName",
            controller: username,
          ),
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            name: "Email",
            controller: email,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: password,
            obscureText: obserText,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obserText = !obserText;
                  });
                },
                child: Icon(
                  obserText == true ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
              ),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = !isMale;
              });
            },
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 10),
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      isMale == true ? "Male" : "Female",
                      style: TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            name: "Phone Number",
            controller: phonenumber,
          ),
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            name: "Address",
            controller: address,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildAllTextFormField(),
          SizedBox(
            height: 10,
          ),
          isLoading == false
              ? MyButton(
                  name: "SignUp",
                  onPressed: () {
                    validation();
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          Row(
            children: [
              Text('I have already an account!'),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => Login(),
                    ),
                  );
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: [
          Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 500,
            child: _buildBottomPart(),
          ),
        ],
      ),
    );
  }
}
