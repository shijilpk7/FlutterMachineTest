import 'dart:convert';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:zartek/dto/restaurant.dart';
import 'package:zartek/provider/google_sign_in_provider.dart';
import 'package:zartek/screens/cart.dart';

class LoggedInScreen extends StatefulWidget {
  const LoggedInScreen({Key? key}) : super(key: key);

  @override
  _LoggedInScreenState createState() => _LoggedInScreenState();
}

class _LoggedInScreenState extends State<LoggedInScreen> {
  Restaurant? restaurant;
  Future getData() async {
    var response = await http.get(
        Uri.parse('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad'),
        headers: {'Accept': "application/json"});
    final jsonData = jsonDecode(response.body);
    return Restaurant.fromJson(jsonData[0]);
  }

  void initState() {
    super.initState();
    getData().then(
      (data) => setState(
        () {
          restaurant = data;
        },
      ),
    );
  }

  List<Order> orders = [];
  var notificationCount = 0;
  @override
  Widget build(BuildContext context) {
    // final  user = FirebaseAuth.instance.currentUser;
    Size size = MediaQuery.of(context).size;
    var user = FirebaseAuth.instance.currentUser;
    var name = "", email = "", photoUrl = "", provider = user!.providerData;
    if (provider[0].providerId != 'phone') {
      name = user.displayName!;
      email = user.email!;
      photoUrl = user.photoURL!;
    } else {
      name = user.phoneNumber!;
      email = user.uid;
      photoUrl =
          'https://p.kindpng.com/picc/s/78-785975_icon-profile-bio-avatar-person-symbol-chat-icon.png';
    }

    //calling api
    //var tabMenuList = data['table_menu_list'];

    // print(user.photoURL);

    List<TableMenuList>? tabMenuList = [];
    tabMenuList = restaurant?.tableMenuList;
    var tabLength = (tabMenuList?.length == null) ? 0 : tabMenuList?.length;

    List<Tab> tabs = [];
    List<Widget> tabMenu = [];

    for (var i = 0; i < tabLength!; i++) {
      tabs.add(
        Tab(
          text: tabMenuList?[i].menuCategory,
        ),
      );
      List<CategoryDishes>? dishes = [];
      dishes = tabMenuList?[i].categoryDishes;
      var dishLength = (dishes?.length == null) ? 0 : dishes?.length;
      List<Widget> dishViewList = [];
      for (var j = 0; j < dishLength!; j++) {
        String? dishAvailability;
        String? temp1 =
            (restaurant?.restaurantId == null) ? '' : restaurant?.restaurantId;
        String? temp2 = (dishes?[j].dishId == null) ? '' : dishes?[j].dishId;
        orders.add(new Order(
            restaurantId: temp1,
            dishId: temp2,
            dishCount: 0,
            menucategoryId: tabMenuList?[i].menuCategoryId));
        dishAvailability = dishes?[j].dishAvailability.toString();
        dishViewList.add(
          Opacity(
            opacity: ('$dishAvailability'.toLowerCase() == 'true') ? 1 : .5,
            child: AbsorbPointer(
              absorbing:
                  ('$dishAvailability'.toLowerCase() == 'true') ? false : true,
              child: Container(
                height: 250,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 7.5, top: 17.5),
                            child: Icon(
                              Icons.crop_din,
                              color: (dishes![j].dishType == 2)
                                  ? Colors.green
                                  : Colors.red,
                              size: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15, top: 25),
                            child: Icon(Icons.circle,
                                color: (dishes[j].dishType == 2)
                                    ? Colors.green
                                    : Colors.red,
                                size: 15),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 12,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              dishes[j].dishName,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  dishes[j].dishCurrency +
                                      ' ' +
                                      double.parse(
                                              dishes[j].dishPrice.toString() +
                                                  '00')
                                          .toStringAsFixed(2),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    (dishes[j].dishCalories.toStringAsFixed(
                                                dishes[j]
                                                            .dishCalories
                                                            .truncateToDouble() ==
                                                        dishes[j].dishCalories
                                                    ? 0
                                                    : 1))
                                            .toString() +
                                        ' ' +
                                        'calories',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                dishes[j].dishDescription.toString(),
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(50, 40),
                                    primary: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    )),
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      int count = orders
                                          .where((element) =>
                                              element.restaurantId ==
                                                  restaurant?.restaurantId &&
                                              element.dishId ==
                                                  dishes?[j].dishId)
                                          .toList()[0]
                                          .dishCount;
                                      if (count > 0) {
                                        orders
                                            .where((element) =>
                                                element.restaurantId ==
                                                    restaurant?.restaurantId &&
                                                element.dishId ==
                                                    dishes?[j].dishId)
                                            .toList()[0]
                                            .dishCount--;
                                        notificationCount = orders
                                            .where((element) =>
                                                element.dishCount > 0)
                                            .toList()
                                            .length;
                                      }
                                    });
                                  },
                                  child: Text('-'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    minimumSize: Size(50, 40),
                                    shape: ContinuousRectangleBorder(),
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    return null;
                                  },
                                  child: Text(orders
                                      .where((element) =>
                                          element.restaurantId ==
                                              restaurant?.restaurantId &&
                                          element.dishId == dishes?[j].dishId)
                                      .toList()[0]
                                      .dishCount
                                      .toString()),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    minimumSize: Size(50, 40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    )),
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      orders
                                          .where((element) =>
                                              element.restaurantId ==
                                                  restaurant?.restaurantId &&
                                              element.dishId ==
                                                  dishes?[j].dishId)
                                          .toList()[0]
                                          .dishCount++;
                                      notificationCount = orders
                                          .where((element) =>
                                              element.dishCount > 0)
                                          .toList()
                                          .length;
                                    });
                                  },
                                  child: Text('+'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              (dishes[j].addonCat.length != 0)
                                  ? 'Customization Available'
                                  : '',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            width: 80,
                            height: 80,
                            child: Image(
                                //image: NetworkImage(dishes[j].dishImage),
                                image:
                                    AssetImage('assets/images/logo/dish.png')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      tabMenu.add(ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return dishViewList[index];
          },
          separatorBuilder: (_, data) => Divider(
                thickness: 1,
              ),
          itemCount: dishViewList.length));
    }
    return DefaultTabController(
      length: (tabMenuList?.length == null) ? 0 : tabLength,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 70,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                color: Colors.grey,
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          bottom: TabBar(
            indicatorColor: Colors.pink,
            labelColor: Colors.pink,
            isScrollable: true,
            labelStyle: TextStyle(fontSize: 20, fontFamily: 'RobotoMono'),
            tabs: tabs,
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              iconSize: 30,
              color: Colors.grey,
              icon: Stack(
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 13,
                      width: 13,
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      alignment: Alignment.center,
                      child: Text(
                        notificationCount.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, height: 1.1),
                      ),
                    ),
                  )
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(
                      orders: orders
                          .where((element) => element.dishCount > 0)
                          .toList(),
                      restaurant: restaurant,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: tabMenu,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(photoUrl),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        name,
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'ID : ' + email,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Log out',
                      style: TextStyle(color: Colors.grey, fontSize: 23),
                    ),
                  ],
                ),
                onTap: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
