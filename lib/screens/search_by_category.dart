import 'package:anime_info/model/product.dart';
import 'package:anime_info/provider/category_provider.dart';
import 'package:anime_info/provider/show_provider.dart';
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
    CategoryProvider provider = Provider.of(context);
    List<Product> searchCategory = provider.searchCategoryList(query);
    return GridView.count(
      childAspectRatio: 0.8,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: searchCategory
          .map(
            (e) => SingleProduct(
              show_type: e.type,
              show_name: e.name,
              image: e.image,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    CategoryProvider categoryprovider = Provider.of(context);
    List<Product> searchCategory = categoryprovider.searchCategoryList(query);
    return GridView.count(
      childAspectRatio: 0.8,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: searchCategory
          .map(
            (e) => SingleProduct(
              show_type: e.type,
              show_name: e.name,
              image: e.image,
            ),
          )
          .toList(),
    );
  }
}
