import 'package:anime_info/model/product.dart';
import 'package:anime_info/provider/category_provider.dart';
import 'package:anime_info/provider/show_provider.dart';
import 'package:anime_info/screens/detailscreen.dart';
import 'package:anime_info/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchByCategory extends SearchDelegate<void> {
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
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    CategoryProvider catprovider = Provider.of<CategoryProvider>(context);
    List<Product> searchCategory = catprovider.searchCategoryList(query);
    return GridView.count(
      childAspectRatio: 0.75,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: searchCategory
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
    CategoryProvider catprovider = Provider.of<CategoryProvider>(context);
    List<Product> searchCategory = catprovider.searchCategoryList(query);
    return GridView.count(
      childAspectRatio: 0.75,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: searchCategory
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
