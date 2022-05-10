import 'package:anime_info/provider/show_provider.dart';
import 'package:anime_info/screens/homepage.dart';
import 'package:anime_info/widgets/cartsingleproduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/cartmodel.dart';
import '../widgets/notification_but.dart';

class CheckOut extends StatefulWidget {
  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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

  User? user;
  late double total;
  late List<CartModel> myList;
  Widget _buildButton() {
    return Column(
      children: shpro.userModelList.map((e) {
        return Container(
          height: 50,
          width: double.infinity,
          child: RaisedButton(
            onPressed: () {
              if (shpro.checkOutModelList.isNotEmpty) {
                FirebaseFirestore.instance.collection('Order').add({
                  'Product': shpro.checkOutModelList
                      .map((c) => {
                            'ProductName': c.name,
                            'ProductType': c.type,
                            'ProductPrice': c.price,
                            'ProductQuantity': c.quantity,
                            'ProductImage': c.image,
                          })
                      .toList(),
                  'TotalPrice': total.toStringAsFixed(2),
                  'Username': e.username,
                  'Useremail': e.useremail,
                  'Useraddress': e.useraddress,
                  'Userphonenumber': e.userphone,
                  'Userid': user!.uid,
                });
                setState(() {
                  myList.clear();
                });

                shpro.addNotification('Notification');
                //shpro.clearCheckOutProduct();
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
          ),
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    shpro = Provider.of<ShowProvider>(context, listen: false);
    myList = shpro.checkOutModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
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

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        return Future.value(true);
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.only(bottom: 10),
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
                flex: 2,
                child: Container(
                  child: ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (ctx, myIndex) {
                      return CartSingleProduct(
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
              Expanded(
                child: Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
