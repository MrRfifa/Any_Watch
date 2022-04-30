import 'package:flutter/material.dart';

class UserModel {
  late String username,
      useremail,
      usergender,
      userphone,
      userimage,
      useraddress;
  UserModel({
    required this.username,
    required this.useremail,
    required this.usergender,
    required this.userphone,
    required this.userimage,
    required this.useraddress,
  });
}
