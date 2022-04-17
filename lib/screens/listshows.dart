import 'package:anime_info/screens/homepage.dart';
import 'package:anime_info/widgets/singleproduct.dart';
import 'package:flutter/material.dart';

class ListShows extends StatelessWidget {
  final String name;
  final snapShot;
  ListShows({required this.name, required this.snapShot});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomePage(),
              ),
            );
          },
          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                Container(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 550,
                  child: GridView.builder(
                    itemCount: snapShot.data.docs.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, index) => SingleProduct(
                        show_type: snapShot.data.docs[index]['type'],
                        show_name: snapShot.data.docs[index]['name'],
                        image: snapShot.data.docs[index]['image']),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 10,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
