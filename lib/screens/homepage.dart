import 'package:anime_info/model/categoryicon.dart';
import 'package:anime_info/model/usermodel.dart';
import 'package:anime_info/provider/category_provider.dart';
import 'package:anime_info/screens/about.dart';
import 'package:anime_info/screens/contactus.dart';
import 'package:anime_info/screens/detailscreen.dart';
import 'package:anime_info/screens/listshows.dart';
import 'package:anime_info/screens/profilescreen.dart';
import 'package:anime_info/screens/search_by_show.dart';
import 'package:anime_info/screens/welcomescreen.dart';
import 'package:anime_info/widgets/singleproduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:anime_info/model/product.dart';
import 'package:provider/provider.dart';

import '../provider/show_provider.dart';
import '../widgets/notification_but.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

late CategoryProvider categprovider;
late ShowProvider showprovider;

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Widget _buildCategoryProduct({required String image, required int color}) {
    return CircleAvatar(
      maxRadius: height * 0.14 / 2.1,
      backgroundColor: Color(color),
      child: Container(
        height: 40,
        child: Image(
          image: NetworkImage(image),
          color: Colors.white,
        ),
      ),
    );
  }

  late double height, width;
  bool homeColor = true;
  bool aboutColor = false;
  bool contactColor = false;
  bool profileColor = false;

  Widget _buildUserAccountsDrawerHeader() {
    List<UserModel> userModel = showprovider.getUserModeList;
    return Column(
      children: userModel.map((e) {
        return UserAccountsDrawerHeader(
          accountName: Text(
            e.username,
            style: const TextStyle(color: Colors.black),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: e.userimage == ''
                ? const AssetImage('assets/user.jpg')
                : NetworkImage(e.userimage) as ImageProvider,
          ),
          decoration: const BoxDecoration(
            color: Color(0xfff2f2f2),
          ),
          accountEmail: Text(
            e.useremail,
            style: const TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMyDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _buildUserAccountsDrawerHeader(),
          ListTile(
            selected: homeColor,
            onTap: () {
              setState(() {
                contactColor = false;
                aboutColor = false;
                homeColor = true;
                profileColor = false;
              });
            },
            leading: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          ListTile(
            selected: profileColor,
            onTap: () {
              setState(() {
                contactColor = false;
                aboutColor = false;
                homeColor = false;
                profileColor = true;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
          ),
          ListTile(
            selected: aboutColor,
            onTap: () {
              setState(() {
                contactColor = false;
                homeColor = false;
                aboutColor = true;
                profileColor = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => About(),
                ),
              );
            },
            leading: const Icon(Icons.info),
            title: const Text('About'),
          ),
          ListTile(
            selected: contactColor,
            onTap: () {
              setState(() {
                contactColor = true;
                aboutColor = false;
                homeColor = false;
                profileColor = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ContactUs(),
                ),
              );
            },
            leading: const Icon(Icons.phone),
            title: const Text('Contact us'),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => WelcomeScreen(),
                ),
              );
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
      height: height * 0.3,
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

  Widget _buildAnimeIcon() {
    List<Product> animecat = categprovider.getAnimeList;
    List<CategoryIcon> animecaticon = categprovider.getAnimeIcon;

    return Row(
      children: animecaticon.map(
        (e) {
          return GestureDetector(
            child: _buildCategoryProduct(
              image: e.image,
              color: 0xffd9ed92,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => ListShows(
                        isCategory: true,
                        name: 'Anime Category',
                        snapShot: animecat,
                      )),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }

  Widget _buildMangaIcon() {
    List<Product> mangacat = categprovider.getMangaList;
    List<CategoryIcon> mangacaticon = categprovider.getMangaIcon;

    return Row(
      children: mangacaticon.map(
        (e) {
          return GestureDetector(
            child: _buildCategoryProduct(
              image: e.image,
              color: 0xff76c893,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => ListShows(
                        isCategory: true,
                        name: 'Manga Category',
                        snapShot: mangacat,
                      )),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }

  Widget _buildFilmIcon() {
    List<Product> filmcat = categprovider.getFilmList;
    List<CategoryIcon> filmcaticon = categprovider.getFilmIcon;

    return Row(
      children: filmcaticon.map(
        (e) {
          return GestureDetector(
            child: _buildCategoryProduct(
              image: e.image,
              color: 0xff1a759f,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => ListShows(
                        name: 'Film Category',
                        snapShot: filmcat,
                        isCategory: true,
                      )),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }

  Widget _buildSerieIcon() {
    List<Product> seriecat = categprovider.getSerieList;
    List<CategoryIcon> seriecaticon = categprovider.getSerieIcon;

    return Row(
      children: seriecaticon.map(
        (e) {
          return GestureDetector(
            child: _buildCategoryProduct(
              image: e.image,
              color: 0xff184e77,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => ListShows(
                        isCategory: true,
                        name: 'Serie Category',
                        snapShot: seriecat,
                      )),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }

  Widget _buildCategory() {
    return Column(
      children: <Widget>[
        Container(
          height: height * 0.1 - 30,
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
              _buildAnimeIcon(),
              _buildMangaIcon(),
              _buildSerieIcon(),
              _buildFilmIcon(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeature() {
    List<Product> feature = showprovider.getFeatureList;
    List<Product> featureproduct;
    featureproduct = showprovider.getHomeFeatureList;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Featured',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => ListShows(
                      isCategory: false,
                      name: 'Featured',
                      snapShot: feature,
                    ),
                  ),
                );
              },
              child: const Text(
                'View more',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Row(
          children: featureproduct.map((e) {
            return Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                              image: e.image,
                              name: e.name,
                              type: e.type,
                              price: e.price,
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        show_type: e.type,
                        show_name: e.name,
                        image: e.image,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                            image: e.image,
                            name: e.name,
                            type: e.type,
                            price: e.price,
                          ),
                        ),
                      );
                    },
                    child: SingleProduct(
                      show_type: e.type,
                      show_name: e.name,
                      image: e.image,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNewAchieve() {
    List<Product> newachieveproduct = showprovider.getNewAchieveList;
    return Column(
      children: <Widget>[
        Container(
          height: height * 0.1 - 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New Achives',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => ListShows(
                            isCategory: false,
                            name: 'New Achieves',
                            snapShot: newachieveproduct,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'View more',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Row(
          children: showprovider.getHomeNewAchieveList.map((e) {
            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (ctx) => DetailScreen(
                                        image: e.image,
                                        name: e.name,
                                        type: e.type,
                                        price: e.price,
                                      ),
                                    ),
                                  );
                                },
                                child: SingleProduct(
                                  show_type: e.type,
                                  show_name: e.name,
                                  image: e.image,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => DetailScreen(
                                      image: e.image,
                                      name: e.name,
                                      type: e.type,
                                      price: e.price,
                                    ),
                                  ),
                                );
                              },
                              child: SingleProduct(
                                show_type: e.type,
                                show_name: e.name,
                                image: e.image,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void getCallAllFunctions() {
    categprovider.getAnimeData();
    categprovider.getFilmData();
    categprovider.getMangaData();
    categprovider.getSerieData();

    ///feature and new achieves data
    showprovider.getFeatureData();
    showprovider.getNewAchieveData();
    /////home feature provider
    showprovider.getHomeFeatureData();
    /////home new achieves provider
    showprovider.getHomeNewAchieveData();
    /////home categorie icon provider
    categprovider.getAnimeIconData();
    categprovider.getFilmIconData();
    categprovider.getSerieIconData();
    categprovider.getMangaIconData();
    /////usermodel provider
    showprovider.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    ////show provider
    showprovider = Provider.of<ShowProvider>(context);
    ////category provider
    categprovider = Provider.of<CategoryProvider>(context);
    getCallAllFunctions();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        actions: <Widget>[
          // IconButton(
          //   onPressed: () {
          //     // showSearch(
          //     //   context: context,
          //     //   delegate: SearchByShow(),
          //     // );
          //   },
          //   icon: Icon(
          //     Icons.search,
          //     color: Colors.black,
          //   ),
          // ),
          NotificationButton(),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildImageSlider(),
                  _buildCategory(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildFeature(),
                  _buildNewAchieve(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
