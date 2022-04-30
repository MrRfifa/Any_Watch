import 'package:anime_info/provider/show_provider.dart';
import 'package:anime_info/screens/homepage.dart';
import 'package:anime_info/widgets/cartsingleproduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/notification_but.dart';

class CheckOut extends StatefulWidget {
  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late ShowProvider shpro;
  Widget _buildBottomDetail(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          endName,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  late User user;
  late double total;
  late int index;
  Widget _buildButton() {
    return Column(
      children: shpro.userModelList.map((e) {
        return RaisedButton(
          onPressed: () {
            if (shpro.checkOutModelList.isNotEmpty) {
              FirebaseFirestore.instance.collection('Order').doc(user.uid).set({
                'Product': shpro.checkOutModelList
                    .map((c) => {
                          'Product Name': c.name,
                          'Product Type': c.type,
                          'Product Price': c.price,
                          'Product Quantity': c.quantity,
                        })
                    .toList(),
                'Total Price': total.toStringAsFixed(2),
                'Username': e.username,
                'Useremail': e.useremail,
                'Useraddress': e.useraddress,
                'Userphonenumber': e.userphone,
                'Userid': user.uid,
              });
              shpro.clearCheckOutProduct();
            } else {
              _scaffoldKey.currentState!.showSnackBar(
                SnackBar(
                  content: Text('No item yet'),
                ),
              );
            }
          },
          child: const Text(
            'Buy',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          color: const Color.fromARGB(204, 40, 91, 117),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser!;
    double subtotal = 0;
    double discount = 5;
    double discountRupees;

    shpro = Provider.of<ShowProvider>(context);
    shpro.getCheckOutModelList.forEach(
      ((element) {
        subtotal += element.price * element.quantity;
      }),
    );
    discountRupees = (discount / 100) * subtotal;
    total = subtotal - discountRupees;
    if (shpro.getCheckOutModelList.isEmpty) {
      total = 0.0;
      discountRupees = 0.0;
    }

    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: Container(
        height: 90,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildButton(),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: ListView.builder(
                  itemCount: shpro.getCheckOutModelList.length,
                  itemBuilder: (ctx, myIndex) {
                    index = myIndex;
                    return CartSingleProduct(
                      isCount: true,
                      index: myIndex,
                      image: shpro.getCheckOutModelList[myIndex].image,
                      name: shpro.getCheckOutModelList[myIndex].name,
                      type: shpro.getCheckOutModelList[myIndex].type,
                      quantity: shpro.getCheckOutModelList[myIndex].quantity,
                      price: shpro.getCheckOutModelList[myIndex].price,
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
