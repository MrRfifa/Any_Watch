// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:anime_info/screens/cartscreen.dart';
import 'package:anime_info/screens/homepage.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final String type;
  DetailScreen({required this.image, required this.name, required this.type});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
              _BuildTypeProduct(name: 'Chonin'),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => CartScreen(
                  image: widget.image, name: widget.name, type: widget.type),
            ),
          );
        },
        color: Colors.pink,
        child: Text(
          'Buy now for 5\$',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Detail Screen',
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
                builder: (ctx) => HomePage(),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                _buildImage(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildNamePart(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildDescriptionPart(),
                      SizedBox(
                        height: 15,
                      ),
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
          ],
        ),
      ),
    );
  }
}
