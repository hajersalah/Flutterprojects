import 'dart:collection';
import 'dart:math';
import 'package:delivery_manager/models/classes/order.dart';
import 'package:delivery_manager/widgets/add_order_sheet.dart';
import 'package:delivery_manager/widgets/background_container.dart';
import 'package:delivery_manager/widgets/chart.dart';
import 'package:delivery_manager/widgets/home-title.dart';
import 'package:delivery_manager/widgets/order_item.dart';
import 'package:delivery_manager/widgets/sticky_header_head.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeScreen extends StatefulWidget {
  final Function toggleTheme;
  HomeScreen(this.toggleTheme);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool light = true;
  bool showUpButton = false;
  ScrollController controller = ScrollController();
  //to put a map inside a splay tree map :
  SplayTreeMap<String, Map<String, dynamic>> orders =
      SplayTreeMap<String, Map<String, dynamic>>((String a, String b) {
    return -a.compareTo(b);
  });
  //SplayTreeMap<String, List<Order>> orders =SplayTreeMap<String, List<Order>>();
  List<String> deliveryMen = ['Muhammed Aly', 'Toka Ehab', 'Ahmed Aly'];

  @override
  // what we put in this fun. will run just 1 time .. only !!
  void initState() {
    super.initState();
    final ordersList = List.generate(12, (index) {
      return Order(
        deliveryMan: deliveryMen[Random().nextInt(3)],
        price: Random().nextDouble() * 500,
        orderDate: DateTime.now().subtract(
          Duration(
            days: Random().nextInt(12),
            hours: Random().nextInt(24),
            minutes: Random().nextInt(60),
          ),
        ),
      );
    });

    ordersList.forEach((element) {
      final key = DateFormat('yyyyMMdd').format(element.orderDate);
      if (!orders.containsKey(key)) {
        orders[key] = Map<String, dynamic>();
        orders[key]['date'] =
            DateFormat('EEEE, dd/MM/yyyy').format(element.orderDate);
        orders[key]['list'] = SplayTreeSet<Order>((Order a, Order b) {
          String timeA, timeB;
          timeA = DateFormat('hh:mm').format(a.orderDate);
          timeB = DateFormat('hh:mm').format(b.orderDate);
          return timeA.compareTo(timeB);
        });
        /*if (a.orderDate.isBefore(b.orderDate)) {
            return 1;
          } else {
            return -1;
          }*/
      }
      orders[key]['list'].add(element);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void removeOrder(String key, Order order) {
    setState(() {
      (orders[key]['list'] as SplayTreeSet<Order>).remove(order);
      if (orders[key]['list'].isEmpty) {
        orders.remove(key);
      }
    });
  }

  void addOrder(Order order) {
    Navigator.of(context).pop();
    String key = DateFormat('yyyyMMdd').format(order.orderDate);
    setState(() {
      if (orders.containsKey(key)) {
        orders[key]['list'].add(order);
      } else {
        orders[key] = Map<String, dynamic>();
        orders[key]['date'] =
            DateFormat('EEEE,dd/MM/yyyy').format(order.orderDate);
        orders[key]['list'] = SplayTreeSet<Order>((Order a, Order b) {
          String timeA, timeB;
          timeA = DateFormat('hh:mm').format(a.orderDate);
          timeB = DateFormat('hh:mm').format(b.orderDate);
          return timeA.compareTo(timeB);
        });
      }
      orders[key]['list'].add(order);
    });
  }
  /*to make sure that data taken
    print(order.deliveryMan);
    print(order.price);
    print(order.orderDate);*/

  @override
  Widget build(BuildContext context) {
    // to know if the orintation is portrait or landscape :
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        children: [
          BackGroundContainer(portrait),
          SafeArea(
            // safe area made the container start from the bottom of the notifacation bar !
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HomeTitle(),
                    Chart(GlobalKey(), orders),
                    Expanded(
                        child: NotificationListener<ScrollUpdateNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels >= 20 &&
                            showUpButton == false) {
                          //print('here');
                          setState(() {
                            showUpButton = true;
                          });
                        } else if (notification.metrics.pixels < 20 &&
                            showUpButton == true) {
                          setState(() {
                            showUpButton = false;
                          });
                        }
                        return true;
                      },
                      child: ListView.builder(
                        controller: controller,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                            bottom: kFloatingActionButtonMargin + 56),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final List keys = orders.keys.toList();
                          final key = keys[index];
                          final date = orders[key]['date'];
                          final SplayTreeSet<Order> list = orders[key]['list'];
                          return StickyHeader(
                            header: StickyHeaderHead(date),
                            content: Column(
                              children: list.map((element) {
                                return OrderItem(element, removeOrder);
                              }).toList(),
                            ),
                          );
                        },
                        /*Text("aaaaaaaaaa"),
                                Text("bbbbbbbbbb"),
                                Text("cccccccccc"),
                                Text("dddddddddd"),*/
                      ),
                    )
                        /*OrderItem(Order(1, "muhammed ali", 50.00, DateTime.now()),
                              ),
                              OrderItem(Order(2, "ahmed ali", 10.00, DateTime.now()),
                              ),
                              OrderItem(Order(3, "abdulrahman ahmed", 30.00, DateTime.now()),
                              ),
                              OrderItem(Order(4, "mohamed ahmed", 40.00, DateTime.now()),
                              ),
                              OrderItem(Order(5, "ahmed saber", 20.00, DateTime.now()),
                              ),*/
                        ),
                  ]),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 2 * kFloatingActionButtonMargin),
        child: Row(
          mainAxisAlignment: (showUpButton)
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
          children: [
            if (showUpButton)
              FloatingActionButton(
                backgroundColor: Colors.grey[500],
                onPressed: () {
                  controller.jumpTo(0.0);
                },
                mini: true,
                child: Icon(Icons.keyboard_arrow_up),
              ),
            Spacer(),
            // now we will change the floating action button to >> Switch
            /*FloatingActionButton(
                backgroundColor: Colors.amber,
                child: Icon(Icons.wb_sunny),
                mini: true,
                onPressed: () {
                  widget.toggleTheme();
                }),*/
            Icon(
              Icons.wb_sunny,
              color: Colors.amber,
            ),
            Switch(
                // to change the active & inactivr Colors :
                activeColor: Colors.black,
                inactiveThumbColor: Colors.amber,
                value: light,
                onChanged: (value) {
                  setState(() {
                    light = value;
                    widget.toggleTheme();
                  });
                }),
            Icon(Icons.brightness_3),
            FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                showModalBottomSheet(
                  //isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return AddOrderSheet(deliveryMen, addOrder);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
