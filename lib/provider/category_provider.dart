import 'package:anime_info/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  Product? animeData;
  List<Product> anime = [];
  Future<void> getAnimeData() async {
    List<Product> newList = [];
    QuerySnapshot animeSnapshot = await FirebaseFirestore.instance
        .collection('categorie')
        .doc('EEIvCeEXeuKbdx7ubFvz')
        .collection('anime')
        .get();
    for (var e in animeSnapshot.docs) {
      animeData = Product(
          image: e.get('image'),
          name: e.get('name'),
          type: e.get('type'),
          price: e.get('type'));
      newList.add(animeData!);
    }
    anime = newList;
    print(anime);
  }

  List<Product> get getAnimeList {
    return anime;
  }
}
