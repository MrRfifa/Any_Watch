import 'package:anime_info/provider/show_provider.dart';
import 'package:anime_info/screens/homepage.dart';
import 'package:anime_info/screens/signup.dart';
import 'package:anime_info/widgets/notification_but.dart';
import 'package:anime_info/widgets/textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../model/usermodel.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);

bool isMale = false;
late TextEditingController phoneNumber;
late TextEditingController address;
late TextEditingController userName;

class _ProfileScreenState extends State<ProfileScreen> {
  late ShowProvider shpro;
  File? _pickedImage;
  late PickedFile _image;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void finalValidation() async {
    await _uploadImage(image: _pickedImage!);
    await userDetailUpdate();
  }

  void validation() async {
    if (email.text.isEmpty && password.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('All fields are empty'),
        ),
      );
    } else if (userName.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Username is empty'),
        ),
      );
    } else if (userName.text.length < 6) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('Username must be 6'),
        ),
      );
    } else if (phoneNumber.text.length < 11 || phoneNumber.text.length > 11) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("Phone Number Must Be 11 "),
        ),
      );
    } else {
      finalValidation();
    }
  }

  User? user = FirebaseAuth.instance.currentUser;
  bool centerCircle = false;
  var imageMap;
  Future<void> userDetailUpdate() async {
    FirebaseFirestore.instance.collection('user').doc(user!.uid).update(
      {
        "UserName": userName.text,
        "UserGender": isMale == true ? "Male" : "Female",
        "UserNumber": phoneNumber.text,
        "UserImage": imageUrl == null ? '' : imageUrl,
        "UserAddress": address.text,
      },
    );
    return null;
    setState(() {
      centerCircle = false;
    });
    setState(() {
      edit = false;
    });
  }

  Future<void> getImage({required ImageSource source}) async {
    _image = (await ImagePicker().getImage(source: source))!;

    if (_image != null) {
      _pickedImage = File(_image.path);
    }
  }

  late String imageUrl;
  Future<void> _uploadImage({required File image}) async {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref = storage.ref().child('userImage/{$user.uid}');
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    imageUrl = await snapshot.ref.getDownloadURL();
  }

  Widget _buildSingleContainer(
      {required String startText, required String endText}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              startText,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            Text(
              endText,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            edit = true;
          });
        },
        child: const Text('Edit Profile'),
      ),
    );
  }

  bool edit = false;
  late String userImage;
  Widget _buildContainerPart() {
    List<UserModel> userModel = showprovider.getUserModeList;
    return Column(
      children: userModel.map((e) {
        userImage = e.userimage;
        address = TextEditingController(text: e.useraddress);
        userName = TextEditingController(text: e.username);
        phoneNumber = TextEditingController(text: e.userphone);
        if (e.usergender == 'Male') {
          setState(() {
            isMale = true;
          });
        } else {
          setState(() {
            isMale = false;
          });
        }
        return Container(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildSingleContainer(
                startText: 'Name',
                endText: e.username,
              ),
              _buildSingleContainer(
                startText: 'Email',
                endText: e.useremail,
              ),
              _buildSingleContainer(
                startText: 'Phone Number',
                endText: e.userphone,
              ),
              _buildSingleContainer(
                startText: 'Gender',
                endText: e.usergender,
              ),
              _buildSingleContainer(
                startText: 'Address',
                endText: e.useraddress,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Future<void> myDialogBox() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Pick from camera'),
                  onTap: () {
                    getImage(source: ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Pick from gallery'),
                  onTap: () {
                    getImage(source: ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextFormFieldPart() {
    List<UserModel> userModel = showprovider.getUserModeList;
    return Column(
      children: userModel.map((e) {
        return Container(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MyTextFormField(
                controller: username,
                name: 'Username',
              ),
              _buildSingleContainer(
                startText: 'Email',
                endText: e.useremail,
              ),
              _buildSingleContainer(
                startText: 'Email',
                endText: e.usergender,
              ),
              MyTextFormField(
                controller: phonenumber,
                name: 'Phone Number',
              ),
              MyTextFormField(
                controller: address,
                name: 'Address',
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    shpro = Provider.of(context);
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(
        leading: edit == true
            ? IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.redAccent,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    edit = false;
                  });
                },
              )
            : IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black45,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  });
                },
              ),
        backgroundColor: Colors.white,
        actions: [
          edit == false
              ? NotificationButton()
              : IconButton(
                  onPressed: () {
                    _uploadImage(image: _pickedImage!);
                    setState(() {
                      edit = false;
                    });
                  },
                  icon: IconButton(
                    icon: Icon(
                      Icons.check,
                      size: 30,
                    ),
                    color: Color(0xff746bc9),
                    onPressed: () {
                      validation();
                    },
                  ),
                ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 130,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          maxRadius: 55,
                          backgroundImage: userImage == null
                              ? AssetImage('assets/user.jpg')
                              : NetworkImage(userImage) as ImageProvider,
                        ),
                      ],
                    ),
                  ),
                  edit == true
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 215,
                            top: 60,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                myDialogBox();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Color(0xff746bc9),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              Container(
                height: 300,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 300,
                      child: edit == true
                          ? _buildTextFormFieldPart()
                          : _buildContainerPart(),
                    ),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: edit == false ? _buildButton() : Container(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
