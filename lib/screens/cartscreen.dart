import 'package:anime_info/provider/show_provider.dart';
import 'package:anime_info/screens/checkout.dart';
import 'package:anime_info/screens/homepage.dart';
import 'package:anime_info/widgets/cartsingleproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/notification_but.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

late ShowProvider shpro;

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    shpro = Provider.of<ShowProvider>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 90,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 50),
        child: RaisedButton(
          onPressed: () {
            shpro.addNotification('Notification');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => CheckOut(),
              ),
            );
          },
          child: Text(
            'Continue',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          color: Color.fromARGB(204, 40, 91, 117),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cart Screen',
          style: TextStyle(color: Colors.black),
        ),
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
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
        actions: <Widget>[
          NotificationButton(),
        ],
      ),
      body: ListView.builder(
        itemCount: shpro.getCheckOutModelListLength,
        itemBuilder: (ctx, index) => CartSingleProduct(
          isCount: false,
          image: shpro.getCheckOutModelList[index].image,
          name: shpro.getCheckOutModelList[index].name,
          type: shpro.getCheckOutModelList[index].type,
          quantity: shpro.getCheckOutModelList[index].quantity,
          price: shpro.getCheckOutModelList[index].price,
        ),
      ),
    );
  }
}
