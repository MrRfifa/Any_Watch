import 'package:anime_info/provider/show_provider.dart';
import 'package:anime_info/screens/homepage.dart';
import 'package:anime_info/widgets/cartsingleproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/notification_but.dart';

class CheckOut extends StatefulWidget {
  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  late ShowProvider shpro;
  Widget _buildBottomDetail(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: TextStyle(fontSize: 18),
        ),
        Text(
          endName,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    double discount = 5;
    double discountRupees;
    double total;
    shpro = Provider.of<ShowProvider>(context);
    shpro.getCheckOutModelList.forEach(
      ((element) {
        subtotal += element.price * element.quantity;
      }),
    );
    discountRupees = (discount / 100) * subtotal;
    total = subtotal - discountRupees;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 90,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 50),
        child: RaisedButton(
          onPressed: () {},
          child: Text(
            'Buy',
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
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: ListView.builder(
                  itemCount: shpro.getCheckOutModelList.length,
                  itemBuilder: (ctx, index) {
                    return CartSingleProduct(
                      image: shpro.getCheckOutModelList[index].image,
                      name: shpro.getCheckOutModelList[index].name,
                      type: shpro.getCheckOutModelList[index].type,
                      quantity: shpro.getCheckOutModelList[index].quantity,
                      price: shpro.getCheckOutModelList[index].price,
                    );
                  },
                ),
              ),
            ),
            Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildBottomDetail(
                    startName: 'Your Price',
                    endName: '${subtotal.toStringAsFixed(2)} \$',
                  ),
                  _buildBottomDetail(
                    startName: 'Discount',
                    endName: '${discount.toStringAsFixed(2)} %',
                  ),
                  _buildBottomDetail(
                    startName: 'Total Price',
                    endName: '${total.toStringAsFixed(2)} \$',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
