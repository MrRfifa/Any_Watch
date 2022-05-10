import 'package:anime_info/model/product.dart';
import 'package:anime_info/provider/category_provider.dart';
import 'package:anime_info/provider/show_provider.dart';
import 'package:anime_info/screens/detailscreen.dart';
import 'package:anime_info/screens/homepage.dart';
import 'package:anime_info/screens/search_by_category.dart';
import 'package:anime_info/screens/search_by_show.dart';
import 'package:anime_info/widgets/notification_but.dart';
import 'package:anime_info/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListShows extends StatelessWidget {
  final String name;
  bool isCategory = true;
  final List<Product> snapShot;
  ListShows({
    required this.name,
    required this.snapShot,
    required this.isCategory,
  });

  late CategoryProvider categoryProvider;
  late ShowProvider showProvider;
  Widget _buildTopName() {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildMyGridView(context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      height: 620,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        childAspectRatio: orientation == Orientation.portrait ? 0.7 : 0.75,
        scrollDirection: Axis.vertical,
        children: snapShot
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => DetailScreen(
                        image: e.image,
                        name: e.name,
                        price: e.price,
                        type: e.type,
                      ),
                    ),
                  );
                },
                child: SingleProduct(
                  show_name: e.name,
                  show_type: e.type,
                  image: e.image,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSearchBar(context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    ShowProvider showProvider = Provider.of<ShowProvider>(context);
    return isCategory == true
        ? IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              categoryProvider.getSearchList(
                list: snapShot,
              );
              showSearch(
                context: context,
                delegate: SearchByCategory(),
              );
            },
          )
        : IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              showProvider.getSearchList(list: snapShot);
              showSearch(
                context: context,
                delegate: SearchByShow(),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomePage(),
              ),
            );
          },
        ),
        actions: <Widget>[
          _buildSearchBar(context),
          NotificationButton(),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: <Widget>[
            _buildTopName(),
            SizedBox(
              height: 10,
            ),
            _buildMyGridView(context),
          ],
        ),
      ),
    );
  }
}
