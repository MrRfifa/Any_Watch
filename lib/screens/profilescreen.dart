import 'package:anime_info/screens/homepage.dart';
import 'package:anime_info/screens/signup.dart';
import 'package:anime_info/widgets/notification_but.dart';
import 'package:anime_info/widgets/textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../model/usermodel.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/mybutton.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  bool isMale = false;
  late UserModel userModel;
  late TextEditingController phoneNumber;
  late TextEditingController address;
  late TextEditingController userName;
  File _pickedImage = new File('');
  late PickedFile _image;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validation() async {
    if (userName.text.isEmpty && phoneNumber.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('All fields are empty'),
        ),
      );
    } else if (userName.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: const Text('Username is empty'),
        ),
      );
    } else if (userName.text.length < 6) {
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: const Text('Username must be 6'),
        ),
      );
    } else if (phoneNumber.text.length < 8 || phoneNumber.text.length > 8) {
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Phone Number Must Be 8 "),
        ),
      );
    } else {
      userDetailUpdate();
    }
  }

  User? user = FirebaseAuth.instance.currentUser;
  bool centerCircle = false;
  var imageMap;
  Future<void> userDetailUpdate() async {
    setState(() {
      centerCircle = true;
    });
    _pickedImage != null
        ? imageMap = await _uploadImage(image: _pickedImage)
        : Container();
    FirebaseFirestore.instance.collection('user').doc(user!.uid).update(
      {
        "Username": userName.text,
        "Gender": isMale == true ? "Male" : "Female",
        "Phone Number": phoneNumber.text,
        "Userimage": imageMap,
        "Useraddress": address.text,
      },
    );
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
      setState(() {
        _pickedImage = File(_image.path);
      });
    }
  }

  late String imageUrl;
  Future<String> _uploadImage({required File image}) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('userImage/$userUid');
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  void getUserUid() {
    User? myUser = FirebaseAuth.instance.currentUser;
    userUid = myUser!.uid;
  }

  Widget _buildSingleContainer({
    required String startText,
    required String endText,
    required Color color,
  }) {
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
          color: edit == true ? color : Colors.white,
          borderRadius: edit == false
              ? BorderRadius.circular(30)
              : BorderRadius.circular(0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
  late String userUid;
  Widget _buildContainerPart() {
    address = TextEditingController(text: userModel.useraddress);
    userName = TextEditingController(text: userModel.username);
    phoneNumber = TextEditingController(text: userModel.userphone);
    if (userModel.usergender == 'Male') {
      isMale = true;
    } else {
      isMale = false;
    }
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSingleContainer(
            startText: 'Name',
            endText: userModel.username,
            color: Colors.amber,
          ),
          _buildSingleContainer(
            startText: 'Email',
            endText: userModel.useremail,
            color: Colors.amber,
          ),
          _buildSingleContainer(
            startText: 'Phone Number',
            endText: userModel.userphone,
            color: Colors.amber,
          ),
          _buildSingleContainer(
            startText: 'Gender',
            endText: userModel.usergender,
            color: Colors.amber,
          ),
          _buildSingleContainer(
            startText: 'Address',
            endText: userModel.useraddress,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }

  Future<void> myDialogBox(context) {
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
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MyTextFormField(
            controller: username,
            name: 'Username',
          ),
          _buildSingleContainer(
            startText: 'Email',
            endText: userModel.useremail,
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = !isMale;
              });
            },
            child: _buildSingleContainer(
              startText: 'Gender',
              endText: isMale == true ? 'Male' : 'Female',
              color: Colors.white,
            ),
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
  }

  @override
  Widget build(BuildContext context) {
    getUserUid();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
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
                  icon: Icon(
                    Icons.check,
                    size: 30,
                    color: Color(0xff746bc9),
                  ),
                  onPressed: () {
                    validation();
                  },
                ),
        ],
      ),
      body: centerCircle == false
          ? ListView(
              children: [
                StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('user').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var myDoc = snapshot.data!.docs;
                    myDoc.forEach((checkDocs) {
                      if (checkDocs.get('UserId') == userUid) {
                        ////verify userid in firebase
                        userModel = UserModel(
                          username: checkDocs.get('Username'),
                          useremail: checkDocs.get('Useremail'),
                          usergender: checkDocs.get('Gender'),
                          userphone: checkDocs.get('Phone Number'),
                          userimage: checkDocs.get('Userimage'),
                          useraddress: checkDocs.get('Useraddress'),
                        );
                      }
                    });
                    return Container(
                      // height: double.infinity,
                      // width: double.infinity,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 55,
                                      backgroundImage: _pickedImage == null
                                          ? userModel.userimage == ''
                                              ? const AssetImage(
                                                  'assets/user.jpg')
                                              : NetworkImage(
                                                      userModel.userimage)
                                                  as ImageProvider
                                          : FileImage(_pickedImage),
                                    ),
                                  ],
                                ),
                              ),
                              edit == true
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .viewPadding
                                                  .left +
                                              220,
                                          top: MediaQuery.of(context)
                                                  .viewPadding
                                                  .left +
                                              110),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            myDialogBox(context);
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: edit == true
                                        ? _buildTextFormFieldPart()
                                        : _buildContainerPart(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: edit == false
                                  ? MyButton(
                                      name: "Edit Profile",
                                      onPressed: () {
                                        setState(() {
                                          edit = true;
                                        });
                                      },
                                    )
                                  : Container(),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
