import 'package:anime_info/provider/category_provider.dart';
import 'package:anime_info/screens/detailscreen.dart';
import 'package:anime_info/screens/listshows.dart';
import 'package:anime_info/widgets/singleproduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:anime_info/model/product.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

Product? interdata;
Product? blaclodata;
Product? jundata;
Product? hxhdata;

late CategoryProvider provider;

var featuresnapshot;
var newachivessnapshot;

///categories snapshots
var animecatsnapshot;
var seriecatsnapshot;
var filmcatsnapshot;
var mangacatsnapshot;

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Widget _buildCategoryProduct({required String image}) {
    return CircleAvatar(
      maxRadius: 48,
      backgroundImage: AssetImage('assets/$image'),
    );
  }

  bool homeColor = true;

  bool inProgColor = true;

  bool aboutColor = true;

  bool contactColor = true;
  Widget _buildMyDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text(
              'Rfifa Anouar',
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/user.jpg'),
            ),
            decoration: BoxDecoration(
              color: Color(0xfff2f2f2),
            ),
            accountEmail: Text(
              'anouarrafifa99@gmail.com',
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            selected: homeColor,
            onTap: () {
              setState(() {
                contactColor = false;
                inProgColor = false;
                aboutColor = false;
                homeColor = true;
              });
            },
            leading: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          ListTile(
            selected: inProgColor,
            onTap: () {
              setState(() {
                contactColor = false;
                homeColor = false;
                aboutColor = false;
                inProgColor = true;
              });
            },
            leading: const Icon(Icons.notification_important),
            title: const Text('In Progress'),
          ),
          ListTile(
            selected: aboutColor,
            onTap: () {
              setState(() {
                contactColor = false;
                inProgColor = false;
                homeColor = false;
                aboutColor = true;
              });
            },
            leading: const Icon(Icons.info),
            title: const Text('About'),
          ),
          ListTile(
            selected: contactColor,
            onTap: () {
              setState(() {
                contactColor = true;
                inProgColor = false;
                aboutColor = false;
                homeColor = false;
              });
            },
            leading: const Icon(Icons.phone),
            title: const Text('Contact us'),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSlider() {
    return Container(
      height: 240,
      child: Carousel(
        autoplay: true,
        showIndicator: false,
        images: [
          const AssetImage('assets/lost.jpg'),
          const AssetImage('assets/twd.jpg'),
          const AssetImage('assets/demon-slayer.jpg'),
          const AssetImage('assets/hannibal.jpg'),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    List<Product> animecat = provider.getAnimeList;
    List<Product> filmcat = provider.getFilmList;
    List<Product> mangacat = provider.getMangaList;
    List<Product> seriecat = provider.getSerieList;
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                'Categories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          child: Row(
            children: <Widget>[
              GestureDetector(
                child: _buildCategoryProduct(image: 'anime.jpg'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => ListShows(
                            name: 'Anime Category',
                            snapShot: animecat,
                          )),
                    ),
                  );
                },
              ),
              GestureDetector(
                child: _buildCategoryProduct(image: 'manga.jpg'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => ListShows(
                            snapShot: mangacat,
                            name: 'Manga Category',
                          )),
                    ),
                  );
                },
              ),
              GestureDetector(
                child: _buildCategoryProduct(image: 'serie.jpg'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => ListShows(
                            snapShot: seriecat,
                            name: 'Serie Category',
                          )),
                    ),
                  );
                },
              ),
              GestureDetector(
                child: _buildCategoryProduct(image: 'film.jpg'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => ListShows(
                            snapShot: filmcat,
                            name: 'Film Category',
                          )),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CategoryProvider>(context);
    provider.getAnimeData();
    provider.getFilmData();
    provider.getMangaData();
    provider.getSerieData();
    return Scaffold(
      key: _key,
      drawer: _buildMyDrawer(),
      appBar: AppBar(
        title: const Text(
          'HomePage',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            _key.currentState?.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Products')
              .doc('R37rXfK1lzu3kc9NkRvU')
              .collection('featureproduct')
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            featuresnapshot = streamSnapshot;
            blaclodata = Product(
                image: streamSnapshot.data?.docs[1]['image'],
                type: streamSnapshot.data?.docs[1]['type'],
                name: streamSnapshot.data?.docs[1]['name'],
                price: streamSnapshot.data?.docs[1]['price']);
            interdata = Product(
                image: streamSnapshot.data?.docs[0]['image'],
                type: streamSnapshot.data?.docs[0]['type'],
                name: streamSnapshot.data?.docs[0]['name'],
                price: streamSnapshot.data?.docs[0]['price']);

            return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('categorie')
                    .doc('EEIvCeEXeuKbdx7ubFvz')
                    .collection('anime')
                    .get(),
                builder: (context, animesnapshot) {
                  if (animesnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  animecatsnapshot = animesnapshot;

                  return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('Products')
                          .doc('R37rXfK1lzu3kc9NkRvU')
                          .collection('newachives')
                          .get(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        newachivessnapshot = streamSnapshot;
                        hxhdata = Product(
                            image: streamSnapshot.data?.docs[1]['image'],
                            type: streamSnapshot.data?.docs[1]['type'],
                            name: streamSnapshot.data?.docs[1]['name'],
                            price: streamSnapshot.data?.docs[1]['price']);
                        jundata = Product(
                            image: streamSnapshot.data?.docs[0]['image'],
                            type: streamSnapshot.data?.docs[0]['type'],
                            name: streamSnapshot.data?.docs[0]['name'],
                            price: streamSnapshot.data?.docs[0]['price']);
                        return Container(
                          height: double.infinity,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: ListView(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                _buildImageSlider(),
                                                _buildCategory(),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Featured',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                          MaterialPageRoute(
                                                            builder: (ctx) =>
                                                                ListShows(
                                                              name: 'Featured',
                                                              snapShot:
                                                                  featuresnapshot,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: const Text(
                                                        'View more',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          DetailScreen(
                                                        image: interdata!.image,
                                                        name: interdata!.name,
                                                        type: interdata!.type,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: SingleProduct(
                                                    show_type: interdata!.type,
                                                    show_name: interdata!.name,
                                                    image: interdata!.image),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          DetailScreen(
                                                        image:
                                                            blaclodata!.image,
                                                        name: blaclodata!.name,
                                                        type: blaclodata!.type,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: SingleProduct(
                                                  show_type: blaclodata!.type,
                                                  show_name: blaclodata!.name,
                                                  image: blaclodata!.image,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 50,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'New Achives',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (ctx) => ListShows(
                                                      name: 'New Achives',
                                                      snapShot:
                                                          newachivessnapshot,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'View more',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          DetailScreen(
                                                        image: jundata!.image,
                                                        name: jundata!.name,
                                                        type: jundata!.type,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: SingleProduct(
                                                    show_type: jundata!.type,
                                                    show_name: jundata!.name,
                                                    image: jundata!.image),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          DetailScreen(
                                                        image: hxhdata!.image,
                                                        name: hxhdata!.name,
                                                        type: hxhdata!.type,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: SingleProduct(
                                                    show_type: hxhdata!.type,
                                                    show_name: hxhdata!.name,
                                                    image: hxhdata!.image),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                });
          }),
    );
  }
}
