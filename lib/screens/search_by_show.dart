import 'package:anime_info/model/product.dart';
import 'package:anime_info/provider/category_provider.dart';
import 'package:anime_info/provider/show_provider.dart';
import 'package:anime_info/screens/detailscreen.dart';
import 'package:anime_info/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchByShow extends SearchDelegate<void> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.close,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(
          context,
          null,
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    CategoryProvider showprovider = Provider.of(context);
    //List<Product> searchProduct = showprovider.searchAnimeList(query);
    List<Product> searchProduct = [];
    return GridView.count(
      childAspectRatio: 0.75,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: searchProduct
          .map(
            (e) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => DetailScreen(
                      image: e.image,
                      name: e.name,
                      type: e.type,
                      price: e.price,
                    ),
                  ),
                );
              },
              child: SingleProduct(
                image: e.image,
                show_name: e.name,
                show_type: e.type,
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    CategoryProvider showprovider = Provider.of(context);
    //List<Product> searchProduct = showprovider.searchAnimeList(query);
    List<Product> searchProduct = [];
    return GridView.count(
      childAspectRatio: 0.75,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: searchProduct
          .map(
            (e) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => DetailScreen(
                      image: e.image,
                      name: e.name,
                      type: e.type,
                      price: e.price,
                    ),
                  ),
                );
              },
              child: SingleProduct(
                image: e.image,
                show_name: e.name,
                show_type: e.type,
              ),
            ),
          )
          .toList(),
    );
  }
}
