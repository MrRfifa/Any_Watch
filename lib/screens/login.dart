import 'package:anime_info/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/mybutton.dart';
import '../widgets/textformfield.dart';
import 'homepage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool isLoading = false;
RegExp regExp = new RegExp(p);
bool obserText = true;
late final TextEditingController email = TextEditingController();
late final TextEditingController password = TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _LoginState extends State<Login> {
  Widget _button(String name, Function onPressed) {
    return Container(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed(),
        child: Text(name),
      ),
    );
  }

  void submit(context) async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential result =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomePage(),
        ),
      );
      print(result);
    } on PlatformException catch (error) {
      var message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message.toString();
      }
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(message.toString()),
          duration: Duration(milliseconds: 800),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.toString().substring(31)),
        duration: Duration(
          milliseconds: 2000,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    }

    setState(() {
      isLoading = false;
    });
  }

  void validation() async {
    if (email.text.isEmpty && password.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Both fields are empty'),
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
    } else {
      submit(context);
    }
  }

  Widget _buildAllPart() {
    return Expanded(
      flex: 3,
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: <Widget>[
                Text(
                  "Login",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                ////

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
                        obserText == true
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),

                ///
                SizedBox(
                  height: 10,
                ),
                isLoading == false
                    ? MyButton(
                        onPressed: () {
                          validation();
                        },
                        name: "Login",
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('I don\'t have an account!'),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => SignUp()));
                      },
                      child: Text(
                        'SignUp',
                        style: TextStyle(color: Colors.cyan, fontSize: 20),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildAllPart(),
            ],
          ),
        ),
      ),
    );
  }
}
