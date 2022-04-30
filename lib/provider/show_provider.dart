import 'package:anime_info/model/cartmodel.dart';
import 'package:anime_info/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';

class ShowProvider with ChangeNotifier {
  List<CartModel> cartModelList = [];
  late CartModel cartModel;
  List<CartModel> checkOutModelList = [];
  late CartModel checkOutModel;

  void deleteCartProduct(int index) {
    cartModelList.removeAt(index);
    notifyListeners();
  }

  void deleteCheckOutProduct(int index) {
    checkOutModelList.removeAt(index);
    notifyListeners();
  }

  void clearCheckOutProduct() {
    checkOutModelList.clear();
    notifyListeners();
  }

  void getCheckOutData({
    required String name,
    required String type,
    required String image,
    required int quantity,
    required int price,
  }) {
    checkOutModel = CartModel(
      image: image,
      type: type,
      name: name,
      quantity: quantity,
      price: price,
    );
    checkOutModelList.add(checkOutModel);
  }

  List<CartModel> get getCheckOutModelList {
    return List.from(checkOutModelList);
  }

  int get getCheckOutModelListLength {
    return checkOutModelList.length;
  }

  late Product featureData;
  List<Product> feature = [];

  ////feature data
  Future<void> getFeatureData() async {
    List<Product> tempList = [];
    QuerySnapshot featureSnapshot = await FirebaseFirestore.instance
        .collection('Products')
        .doc('R37rXfK1lzu3kc9NkRvU')
        .collection('featureproduct')
        .get();
    featureSnapshot.docs.forEach(
      (element) {
        featureData = Product(
          image: element.get('image'),
          name: element.get('name'),
          type: element.get('type'),
          price: element.get('price'),
        );
        tempList.add(featureData);
      },
    );
    feature = tempList;
  }

  List<Product> get getFeatureList {
    return feature;
  }

  /////end feature data

  late Product newachieveData;
  List<Product> newachieve = [];
  ////newachieve data
  Future<void> getNewAchieveData() async {
    List<Product> tempList = [];
    QuerySnapshot newachieveSnapshot = await FirebaseFirestore.instance
        .collection('Products')
        .doc('R37rXfK1lzu3kc9NkRvU')
        .collection('newachives')
        .get();
    newachieveSnapshot.docs.forEach(
      (element) {
        newachieveData = Product(
          image: element.get('image'),
          name: element.get('name'),
          type: element.get('type'),
          price: element.get('price'),
        );
        tempList.add(newachieveData);
      },
    );
    newachieve = tempList;
    notifyListeners();
  }

  List<Product> get getNewAchieveList {
    return newachieve;
  }

  /////end newachieve data

  late Product homefeatureData;
  List<Product> homefeature = [];

  ////homefeature data
  Future<void> getHomeFeatureData() async {
    List<Product> tempList = [];
    QuerySnapshot homefeatureSnapshot = await FirebaseFirestore.instance
        .collection('homefeature')
        .doc('RzfWdrQhrJdmS1bQRBe6')
        .collection('features')
        .get();
    homefeatureSnapshot.docs.forEach(
      (element) {
        homefeatureData = Product(
          image: element.get('image'),
          name: element.get('name'),
          type: element.get('type'),
          price: element.get('price'),
        );
        tempList.add(homefeatureData);
      },
    );
    homefeature = tempList;
    notifyListeners();
  }

  List<Product> get getHomeFeatureList {
    return homefeature;
  }

  /////end homefeature data

  late Product homenewachieveData;
  List<Product> homenewachieve = [];

  ////homenewachieve data
  Future<void> getHomeNewAchieveData() async {
    List<Product> tempList = [];
    QuerySnapshot homenewachieveSnapshot = await FirebaseFirestore.instance
        .collection('homefeature')
        .doc('RzfWdrQhrJdmS1bQRBe6')
        .collection('newachives')
        .get();
    homenewachieveSnapshot.docs.forEach(
      (element) {
        homenewachieveData = Product(
          image: element.get('image'),
          name: element.get('name'),
          type: element.get('type'),
          price: element.get('price'),
        );
        tempList.add(homenewachieveData);
      },
    );
    homenewachieve = tempList;
    notifyListeners();
  }

  List<Product> get getHomeNewAchieveList {
    return homenewachieve;
  }

  /////end homenewachieve data

  List<String> notificationList = [];
  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  late UserModel usermodel;
  List<UserModel> userModelList = [];
  ////usermodel data
  Future<void> getUserData() async {
    List<UserModel> tempList = [];
    User? currentuser = FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('user').get();
    userSnapshot.docs.forEach(
      (element) {
        if (currentuser?.uid == element.get('UserId')) {
          usermodel = UserModel(
            useraddress: element.get('Useradress'),
            userimage: element.get('Userimage'),
            username: element.get('Username'),
            useremail: element.get('Useremail'),
            usergender: element.get('Gender'),
            userphone: element.get('Phone Number'),
          );
          tempList.add(usermodel);
        }
        userModelList = tempList;
      },
    );
    notifyListeners();
  }

  List<UserModel> get getUserModeList {
    return userModelList;
  }

  //end usermodel
  ///search in products
  late List<Product> searchList;
  void getSearchList({required List<Product> list}) {
    searchList = list;
  }

  List<Product> searchProductList(String query) {
    List<Product> search_by_show = searchList.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return search_by_show;
  }
}
