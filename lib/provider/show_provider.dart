import 'package:anime_info/model/cartmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';

class ShowProvider with ChangeNotifier {
  List<CartModel> cartModelList = [];
  late CartModel cartModel;
  List<CartModel> checkOutModelList = [];
  late CartModel checkOutModel;

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
}
