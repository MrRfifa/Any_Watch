import 'package:anime_info/model/categoryicon.dart';
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

  ///cat icon
  List<CategoryIcon> animeIcon = [];
  late CategoryIcon animeiconData;
  List<CategoryIcon> mangaIcon = [];
  late CategoryIcon mangaiconData;
  List<CategoryIcon> filmIcon = [];
  late CategoryIcon filmiconData;
  List<CategoryIcon> serieIcon = [];
  late CategoryIcon serieiconData;

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
    notifyListeners();
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
    notifyListeners();
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
    notifyListeners();
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
    notifyListeners();
  }

  List<Product> get getSerieList {
    return serie;
  }
  /////end serie data

  ////animeicon data

  Future<void> getAnimeIconData() async {
    List<CategoryIcon> tempList = [];
    QuerySnapshot animeiconSnapshot = await FirebaseFirestore.instance
        .collection('categoryicon')
        .doc('fH6SSUo0bGXHEnGuTgz6')
        .collection('anime')
        .get();
    animeiconSnapshot.docs.forEach(
      (element) {
        animeiconData = CategoryIcon(
          image: element.get('image'),
        );
        tempList.add(animeiconData);
      },
    );
    animeIcon = tempList;
    notifyListeners();
  }

  List<CategoryIcon> get getAnimeIcon {
    return animeIcon;
  }
  /////end animeicon data

  ////mangaicon data

  Future<void> getMangaIconData() async {
    List<CategoryIcon> tempList = [];
    QuerySnapshot mangaiconSnapshot = await FirebaseFirestore.instance
        .collection('categoryicon')
        .doc('fH6SSUo0bGXHEnGuTgz6')
        .collection('manga')
        .get();
    mangaiconSnapshot.docs.forEach(
      (element) {
        mangaiconData = CategoryIcon(
          image: element.get('image'),
        );
        tempList.add(mangaiconData);
      },
    );
    mangaIcon = tempList;
    notifyListeners();
  }

  List<CategoryIcon> get getMangaIcon {
    return mangaIcon;
  }
  /////end mangaicon data

  ////filmicon data

  Future<void> getFilmIconData() async {
    List<CategoryIcon> tempList = [];
    QuerySnapshot filmiconSnapshot = await FirebaseFirestore.instance
        .collection('categoryicon')
        .doc('fH6SSUo0bGXHEnGuTgz6')
        .collection('film')
        .get();
    filmiconSnapshot.docs.forEach(
      (element) {
        filmiconData = CategoryIcon(
          image: element.get('image'),
        );
        tempList.add(filmiconData);
      },
    );
    filmIcon = tempList;
    notifyListeners();
  }

  List<CategoryIcon> get getFilmIcon {
    return filmIcon;
  }
  /////end filmicon data

  ////serieicon data

  Future<void> getSerieIconData() async {
    List<CategoryIcon> tempList = [];
    QuerySnapshot serieiconSnapshot = await FirebaseFirestore.instance
        .collection('categoryicon')
        .doc('fH6SSUo0bGXHEnGuTgz6')
        .collection('serie')
        .get();
    serieiconSnapshot.docs.forEach(
      (element) {
        serieiconData = CategoryIcon(
          image: element.get('image'),
        );
        tempList.add(serieiconData);
      },
    );
    serieIcon = tempList;
    notifyListeners();
  }

  List<CategoryIcon> get getSerieIcon {
    return serieIcon;
  }
  /////end serieicon data
}
