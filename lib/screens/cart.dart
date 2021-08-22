import 'package:flutter/material.dart';
import 'package:zartek/dto/restaurant.dart';

class Cart extends StatefulWidget {
  final Restaurant? restaurant;
  final List<Order> orders;
  Cart({Key? key, required this.orders, this.restaurant}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Order> orders = [];

  @override
  Widget build(BuildContext context) {
    double totalAmount = 0;
    Size size = MediaQuery.of(context).size;
    orders = widget.orders;
    var disCount = orders.length;
    var itemsCount = 0;
    for (var i = 0; i < orders.length; i++) {
      itemsCount += orders[i].dishCount;
    }
    Restaurant? restaurant = widget.restaurant;
    List<TableMenuList>? tabMenuList = [];
    tabMenuList = restaurant?.tableMenuList;
    var tabLength = (tabMenuList?.length == null) ? 0 : tabMenuList?.length;

    List<Widget> oderList = [];
    TableMenuList? tempTab;
    CategoryDishes? tempCategory;
    String? dishName;
    double? dishPrice;
    double? dishCalories;
    for (var j = 0; j < orders.length; j++) {
      tempTab = tabMenuList
          ?.where(
              (element) => element.menuCategoryId == orders[j].menucategoryId)
          .toList()[0];
      tempCategory = tempTab?.categoryDishes
          .where((element) => element.dishId == orders[j].dishId)
          .toList()[0];
      dishName = tempCategory?.dishName;
      dishPrice = tempCategory?.dishPrice;
      dishCalories = tempCategory?.dishCalories;

      int? dishCount = orders
          .where((element) =>
              element.restaurantId == restaurant?.restaurantId &&
              element.dishId == orders[j].dishId)
          .toList()[0]
          .dishCount;
      totalAmount += double.parse(('$dishPrice').toString()) * dishCount;
      oderList.add(
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 7.5,
                        top: 30,
                      ),
                      child: Icon(
                        Icons.crop_din,
                        color: (tempCategory?.dishType == 2)
                            ? Colors.green
                            : Colors.red,
                        size: 30,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 37.5),
                      child: Icon(Icons.circle,
                          color: (tempCategory?.dishType == 2)
                              ? Colors.green
                              : Colors.red,
                          size: 15),
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 40),
                      child: Text(
                        '$dishName',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 40),
                      child: Text(
                        'INR ' +
                            double.parse('$dishPrice' + '00')
                                .toStringAsFixed(2),
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 40),
                      child: Text(
                        (dishCalories?.toStringAsFixed(
                                    dishCalories.truncateToDouble() ==
                                            dishCalories
                                        ? 0
                                        : 1))
                                .toString() +
                            ' ' +
                            'calories',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 60,
                child: Container(
                  margin: EdgeInsets.only(top: 30),
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
                                    element.dishId == orders[j].dishId)
                                .toList()[0]
                                .dishCount;
                            if (count > 0) {
                              orders
                                  .where((element) =>
                                      element.restaurantId ==
                                          restaurant?.restaurantId &&
                                      element.dishId == orders[j].dishId)
                                  .toList()[0]
                                  .dishCount--;
                              totalAmount = totalAmount -
                                  double.parse(('$dishPrice').toString()) *
                                      dishCount;
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
                        child: Text(dishCount.toString()),
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
                            int count = orders
                                .where((element) =>
                                    element.restaurantId ==
                                        restaurant?.restaurantId &&
                                    element.dishId == orders[j].dishId)
                                .toList()[0]
                                .dishCount;
                            orders
                                .where((element) =>
                                    element.restaurantId ==
                                        restaurant?.restaurantId &&
                                    element.dishId == orders[j].dishId)
                                .toList()[0]
                                .dishCount++;
                            totalAmount = totalAmount +
                                double.parse(('$dishPrice').toString()) *
                                    dishCount;
                          });
                        },
                        child: Text('+'),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 15,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 35,
                  ),
                  child: Text(
                    'INR ' +
                        double.parse((double.parse(('$dishPrice').toString()) *
                                        dishCount)
                                    .toString() +
                                '00')
                            .toStringAsFixed(2),
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      oderList.add(SizedBox(
        height: 10,
      ));
      oderList.add(
        Divider(
          indent: 10,
          endIndent: 10,
          color: Colors.grey,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Order Summary',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
        leading: IconButton(
          color: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Container(
          height: size.height * .81,
          width: size.width * .95,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 50,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.green[900],
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      width: size.width * .9,
                      child: Center(
                        child: Text(
                          disCount.toString() +
                              ' Dishes - ' +
                              itemsCount.toString() +
                              ' Items',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * .55,
                      child: SingleChildScrollView(
                        child: Column(
                          children: oderList,
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 15, bottom: 20, top: 10),
                            child: Text(
                              'Total Amount',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin:
                                EdgeInsets.only(right: 15, bottom: 20, top: 10),
                            child: Text(
                              'INR ' +
                                  double.parse(totalAmount.toString() + '00')
                                      .toStringAsFixed(2),
                              style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Place Oder',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    minimumSize: Size(
                      size.width * 0.9,
                      50,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
