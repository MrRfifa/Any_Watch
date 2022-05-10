import 'package:anime_info/provider/show_provider.dart';
import 'package:anime_info/screens/cartscreen.dart';
import 'package:anime_info/screens/homepage.dart';
import 'package:anime_info/widgets/notification_but.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final String type;
  final int price;
  DetailScreen(
      {required this.image,
      required this.name,
      required this.type,
      required this.price});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int count = 1;
  late ShowProvider shpro;

  Widget _BuildTypeProduct({required String name}) {
    return Container(
      height: 60,
      width: 70,
      color: Color(0xfff2f2f2),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Center(
      child: Container(
        width: 300,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.image),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNamePart() {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                widget.type,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff9b96d6),
                ),
              ),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionPart() {
    return Container(
      height: 140,
      child: Wrap(
        children: <Widget>[
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypePart() {
    return Column(
      children: <Widget>[
        Text(
          'Type',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _BuildTypeProduct(name: 'Action'),
              _BuildTypeProduct(name: 'Comedie'),
              _BuildTypeProduct(name: 'Adventure'),
              _BuildTypeProduct(name: 'Romantic'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonPart() {
    return Container(
      height: 50,
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () {
          shpro.getCheckOutData(
              image: widget.image,
              type: widget.type,
              name: widget.name,
              quantity: count,
              price: widget.price);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => CartScreen(),
            ),
          );
        },
        color: Colors.pink,
        child: Text(
          'Add to cart',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    shpro = Provider.of<ShowProvider>(context);
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
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Detail Page',
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
        body: Container(
          child: ListView(
            children: <Widget>[
              _buildImage(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildNamePart(),
                    _buildDescriptionPart(),
                    _buildTypePart(),
                    SizedBox(
                      height: 15,
                    ),
                    _buildButtonPart(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
