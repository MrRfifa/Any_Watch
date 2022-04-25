import 'package:anime_info/provider/show_provider.dart';
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
    shpro = Provider.of<ShowProvider>(context);
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
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
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
            ListView.builder(
              itemCount: shpro.getCartModelListLength,
              itemBuilder: (ctx, index) {
                return CartSingleProduct(
                  image: shpro.getCartModelList[index].image,
                  name: shpro.getCartModelList[index].name,
                  type: shpro.getCartModelList[index].type,
                  quantity: shpro.getCartModelList[index].quantity,
                );
              },
            ),
            Container(
              height: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildBottomDetail(
                    startName: 'Your Price',
                    endName: '10\$',
                  ),
                  _buildBottomDetail(
                    startName: 'Discount',
                    endName: '3%',
                  ),
                  _buildBottomDetail(
                    startName: 'Total Price',
                    endName: '10\$',
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
