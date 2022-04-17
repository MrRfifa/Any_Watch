import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  String show_type;
  String show_name;
  String image;

  SingleProduct(
      {required this.show_type, required this.show_name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 250,
        width: 180,
        child: Column(
          children: [
            Container(
              child: Container(
                height: 200,
                width: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.fill),
                ),
              ),
            ),
            Text(
              show_type,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color(0xff9b96d6)),
            ),
            Text(
              show_name,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
