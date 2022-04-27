import 'package:anime_info/provider/show_provider.dart';
import 'package:anime_info/screens/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSingleProduct extends StatefulWidget {
  final String name;
  final String image;
  final String type;
  int quantity;
  final bool? isCount;
  final int price;
  CartSingleProduct({
    required this.image,
    required this.name,
    required this.type,
    required this.quantity,
    this.isCount,
    required this.price,
  });
  @override
  State<CartSingleProduct> createState() => _CartSingleProductState();
}

TextStyle myStyle = TextStyle(fontSize: 18);
late ShowProvider shpro;

class _CartSingleProductState extends State<CartSingleProduct> {
  @override
  Widget build(BuildContext context) {
    shpro = Provider.of<ShowProvider>(context);

    return Container(
      height: 150,
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 130,
                  width: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.image),
                    ),
                  ),
                ),
                Container(
                  height: 140,
                  width: 200,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.name),
                        Text(widget.type),
                        Text(
                          '5\$',
                          style: TextStyle(
                              color: Color(0xff9b96d6),
                              fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "1 month costs 5\$",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 35,
                              width: 140,
                              color: Color.fromARGB(204, 40, 91, 117),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                    onTap: () {
                                      setState(
                                        () {
                                          if (widget.quantity > 1) {
                                            widget.quantity--;
                                            shpro.getCheckOutData(
                                              name: widget.name,
                                              type: widget.type,
                                              image: widget.image,
                                              quantity: widget.quantity,
                                              price: widget.price,
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                  Text(
                                    widget.quantity.toString() + ' Month(s)',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    onTap: () {
                                      setState(
                                        () {
                                          widget.quantity++;
                                          shpro.getCheckOutData(
                                            name: widget.name,
                                            type: widget.type,
                                            image: widget.image,
                                            quantity: widget.quantity,
                                            price: widget.price,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
