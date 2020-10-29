import 'dart:collection';
import 'package:delivery_manager/models/classes/order.dart';
import 'package:delivery_manager/widgets/hero_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  final SplayTreeMap<String, Map<String, dynamic>> orders;
  //this key to load the chart when any thing changes ( add , remove):
  Chart(key, this.orders) : super(key: key);
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  Map<String, Color> colors = Map<String, Color>();
  Map<String, int> count = Map<String, int>();
  bool showChart;
  String selectedDate;
  //String selectedDate;

  @override
  void initState() {
    super.initState();
    colors = {
      'Muhammed Aly': Colors.blue,
      'Toka Ehab': Colors.yellow,
      'Ahmed Aly': Colors.purple,
    };
    filterByDate(DateTime.now());
    selectedDate = DateFormat("dd/MM").format(DateTime.now());

    /*count['Muhammed Aly'] = 0;
    count['Toka Ehab'] = 0;
    count['Ahmed Aly'] = 0;*/
    //selectedDate = DateFormat('yyyyMMdd').format(DateTime.now());
  }

  void filterByDate(DateTime date) {
    final selectedDate = DateFormat('yyyyMMdd').format(date);
    if (widget.orders.containsKey(selectedDate)) {
      showChart = true;
      SplayTreeSet<Order> list = widget.orders[selectedDate]['list'];
      // we should return them to 0 every time !!
      count['Muhammed Aly'] = 0;
      count['Toka Ehab'] = 0;
      count['Ahmed Aly'] = 0;
      list.forEach((element) {
        count[element.deliveryMan]++;
      });
    } else
      showChart = false;
  }

  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).accentColor == Colors.grey[800];
    return Card(
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05)
          .add(EdgeInsets.only(bottom: 10)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        // to put the next in the center of the card !!
        // 1-- alignment: Alignment.center,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
        child: // 2--
            Center(
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      final date =
                          DateTime.now().subtract(Duration(days: index));
                      return Container(
                        margin: EdgeInsets.only(
                            left: index != 6 ? 2 : 0,
                            right: index != 0 ? 2 : 0),
                        child: FlatButton(
                            shape: StadiumBorder(),
                            color: dark
                                ? (selectedDate ==
                                        DateFormat("dd/MM").format(date))
                                    ? Colors.grey[900]
                                    : Colors.grey[700]
                                : (selectedDate ==
                                        DateFormat("dd/MM").format(date))
                                    ? Colors.amber
                                    : Colors.amber[100],
                            child: Text(
                              DateFormat("dd/MM").format(date),
                              style: TextStyle(
                                  color:
                                      dark ? Colors.grey[200] : Colors.black),
                            ),
                            onPressed: () {
                              setState(() {
                                selectedDate = DateFormat("dd/MM").format(date);
                                filterByDate(date);
                              });
                            }),
                      );
                    },
                  )),
              Expanded(
                flex: 8,
                child: showChart
                    ? Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Text("#Orders"),
                                Expanded(child: Container()),
                                Expanded(
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      HeroItem(colors['Muhammed Aly'],
                                          'Muhammed Aly'),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      HeroItem(
                                          colors['Toka Ehab'], 'Toka Ehab'),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      HeroItem(
                                          colors['Ahmed Aly'], 'Ahmed Aly'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              return Row(
                                children: [
                                  Container(
                                    height: constraints.maxHeight,
                                    width: constraints.maxWidth * 0.15,
                                    //color: Colors.blue,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('20'),
                                        Text('10'),
                                        Text('0'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: constraints.maxHeight,
                                    width: constraints.maxWidth * 0.85,
                                    //color: Colors.blue[900],
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        if (count['Muhammed Aly'] != 0)
                                          Container(
                                            /*child: Listener(
                                              onPointerMove:
                                                  (PointerMoveEvent event) {
                                                Text("Muhammed Aly made " +
                                                    count['Muhammed Aly']
                                                        .toString() +
                                                    " orders");
                                                print(event);
                                              },
                                            ),*/
                                            child: GestureDetector(
                                                onLongPress: () {
                                              print("Muhammed Aly delivered " +
                                                  count['Muhammed Aly']
                                                      .toString() +
                                                  " orders");
                                            }),
                                            width: 20,
                                            height: count['Muhammed Aly'] *
                                                constraints.maxHeight /
                                                20,
                                            color: Colors.blue,
                                          ),
                                        if (count['Toka Ehab'] != 0)
                                          Container(
                                            child: GestureDetector(
                                                onLongPress: () {
                                              print("Toka Ehab delivered " +
                                                  count['Toka Ehab']
                                                      .toString() +
                                                  " orders");
                                              /*child: FlatButton(
                                              onPressed: () {
                                                print("Toka Ehab made " +
                                                    count['Toka Ehab']
                                                        .toString() +
                                                    " orders");
                                              },child: null,),*/
                                            }),
                                            width: 20,
                                            height: count['Toka Ehab'] *
                                                constraints.maxHeight /
                                                20,
                                            color: Colors.yellow,
                                          ),
                                        if (count['Ahmed Aly'] != 0)
                                          Container(
                                            child: GestureDetector(
                                                onLongPress: () {
                                              print("Ahmed Aly delivered " +
                                                  count['Ahmed Aly']
                                                      .toString() +
                                                  " orders");
                                            }),
                                            width: 20,
                                            height: count['Ahmed Aly'] *
                                                constraints.maxHeight /
                                                20,
                                            color: Colors.purple,
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: FittedBox(
                            child: Center(
                                child: Text(
                          "No Orders Yet !",
                          style: TextStyle(
                              color: dark ? Colors.white : Colors.black),
                        ))),
                      ),
              ),
            ],
          ),
          //fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
