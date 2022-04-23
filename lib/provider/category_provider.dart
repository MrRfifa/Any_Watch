import 'package:anime_info/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  late Product animeData;
  List<Product> anime = [];
  late Product filmData;
  List<Product> film = [];
  late Product serieData;
  List<Product> serie = [];
  late Product mangaData;
  List<Product> manga = [];
  ////anime data
  Future<void> getAnimeData() async {
    List<Product> tempList = [];
    QuerySnapshot animeSnapshot = await FirebaseFirestore.instance
        .collection('categorie')
        .doc('EEIvCeEXeuKbdx7ubFvz')
        .collection('anime')
        .get();
    animeSnapshot.docs.forEach(
      (element) {
        animeData = Product(
          image: element.get('image'),
          name: element.get('name'),
          type: element.get('type'),
          price: element.get('price'),
        );
        tempList.add(animeData);
      },
    );
    anime = tempList;
  }

  List<Product> get getAnimeList {
    return anime;
  }

  /////end anime data
  /////film data
  Future<void> getFilmData() async {
    List<Product> tempList = [];
    QuerySnapshot filmSnapshot = await FirebaseFirestore.instance
        .collection('categorie')
        .doc('EEIvCeEXeuKbdx7ubFvz')
        .collection('film')
        .get();
    filmSnapshot.docs.forEach(
      (element) {
        filmData = Product(
          image: element.get('image'),
          name: element.get('name'),
          type: element.get('type'),
          price: element.get('price'),
        );
        tempList.add(filmData);
      },
    );
    film = tempList;
  }

  List<Product> get getFilmList {
    return film;
  }
  /////end film data

  /////manga data
  Future<void> getMangaData() async {
    List<Product> tempList = [];
    QuerySnapshot mangaSnapshot = await FirebaseFirestore.instance
        .collection('categorie')
        .doc('EEIvCeEXeuKbdx7ubFvz')
        .collection('manga')
        .get();
    mangaSnapshot.docs.forEach(
      (element) {
        mangaData = Product(
          image: element.get('image'),
          name: element.get('name'),
          type: element.get('type'),
          price: element.get('price'),
        );
        tempList.add(mangaData);
      },
    );
    manga = tempList;
  }

  List<Product> get getMangaList {
    return manga;
  }
  /////end manga data

  /////serie data
  Future<void> getSerieData() async {
    List<Product> tempList = [];
    QuerySnapshot serieSnapshot = await FirebaseFirestore.instance
        .collection('categorie')
        .doc('EEIvCeEXeuKbdx7ubFvz')
        .collection('tv-serie')
        .get();
    serieSnapshot.docs.forEach(
      (element) {
        serieData = Product(
          image: element.get('image'),
          name: element.get('name'),
          type: element.get('type'),
          price: element.get('price'),
        );
        tempList.add(serieData);
      },
    );
    serie = tempList;
  }

  List<Product> get getSerieList {
    return serie;
  }
  /////end serie data

}
