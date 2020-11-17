import 'package:delivery_manager/models/classes/order.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddOrderSheet extends StatefulWidget {
  final List<String> deliveryMen;
  final Function addOrder;
  AddOrderSheet(this.deliveryMen, this.addOrder);
  @override
  _AddOrderSheetState createState() => _AddOrderSheetState();
}

class _AddOrderSheetState extends State<AddOrderSheet> {
  //List<String> deliveryMen = ['Muhammed Aly', 'Toka Ehab', 'Ahmed Aly'];
  TextEditingController controller;
  String selecteddeliveryMan;
  DateTime selectedDate;
  double price;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    selecteddeliveryMan = widget.deliveryMen[0];
    selectedDate = DateTime.now();
    price = 0.0;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).accentColor == Colors.grey[800];
    return Container(
      color: Theme.of(context).accentColor,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Text(
                "let\'s add an order",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "who will deliver ?",
                      style: TextStyle(
                          color: dark ? Colors.grey[200] : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Card(
                      color: dark ? Colors.grey[700] : Colors.blue[50],
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: DropdownButton(
                          dropdownColor: dark
                              ? Theme.of(context).accentColor
                              : Theme.of(context).accentColor,
                          isExpanded: true,
                          value: selecteddeliveryMan,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          items: widget.deliveryMen.map((deliveryMan) {
                            return DropdownMenuItem(
                              child: Text(deliveryMan),
                              value: deliveryMan,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selecteddeliveryMan = value;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'when will be delivered ?',
                      style: TextStyle(
                        color: dark ? Colors.grey[200] : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        RaisedButton(
                            color: dark ? Colors.grey[500] : Colors.blue[50],
                            child: Text(
                              DateFormat("EEEE, dd/MM/yyyy")
                                  .format(selectedDate),
                              style: TextStyle(fontSize: 15),
                            ),
                            onPressed: () async {
                              DateTime date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now().subtract(
                                  Duration(days: 7),
                                ),
                                lastDate: DateTime.now().add(
                                  Duration(days: 90),
                                ),
                              );
                              if (date != null) {
                                setState(() {
                                  selectedDate = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      selectedDate.hour,
                                      selectedDate.minute);
                                });
                              }
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "at",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                          color: dark ? Colors.grey[500] : Colors.blue[50],
                          child: Text(
                            DateFormat("hh:mm a").format(selectedDate),
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () async {
                            final time = await showTimePicker(
                                context: context,
                                initialTime:
                                    TimeOfDay.fromDateTime(selectedDate));
                            if (time != null) {
                              setState(() {
                                selectedDate = DateTime(
                                    selectedDate.year,
                                    selectedDate.month,
                                    selectedDate.day,
                                    time.hour,
                                    time.minute);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'what is the price ?',
                      style: TextStyle(
                        color: dark ? Colors.grey[200] : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        /*onChanged: (value) {
                          setState(() {
                            price = double.parse(value);
                            // to maake sure the it parsed !! Print(price);
                          });
                        },*/
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: dark ? Colors.grey[700] : Colors.blue[50],
                          //border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            "Add Order",
                            style: TextStyle(
                                color: dark
                                    ? Colors.grey[200]
                                    : Theme.of(context).accentColor),
                          ),
                          onPressed: () {
                            // to make sure that the price is taken >> print(controller.text);
                            /*Order newOrder = Order(
                                deliveryMan: selecteddeliveryMan,
                                orderDate: selectedDate,
                                price: double.parse(controller.text));
                            widget.addOrder(newOrder);*/
                            try {
                              //if (price == null) throw NullThrownError; >>>>
                              double price = double.parse(controller.text);
                              if (price < 0) throw FormatException;
                              Order newOrder = Order(
                                price: price,
                                deliveryMan: selecteddeliveryMan,
                                orderDate: selectedDate,
                              );
                              widget.addOrder(newOrder);
                              // to show a short message (toast):
                              Fluttertoast.showToast(
                                msg: "Order has been Added",
                                fontSize: 18,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor:
                                    dark ? Colors.grey[500] : Colors.grey[200],
                                textColor: Theme.of(context).primaryColor,
                                toastLength: Toast.LENGTH_LONG,
                              );
                            } catch (FormatException) {
                              // to know the erroe name (exception name ) : print(error);
                              //if (error == 'negative price')
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: dark
                                          ? Colors.grey[700]
                                          : Colors.white,
                                      title: Text("invalid Order data"),
                                      content:
                                          Text("you've entered invalid price."),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("ok"))
                                      ],
                                    );
                                  });
                            }
                            //if (error == NullThrownError)
                            // ignore: dead_code_catch_following_catch
                            /*catch (NullThrownError) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title: Text("No price added"),
                                          content: Text("please add a price."),
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("ok"))
                                          ]);
                                    });
                              }*/
                          }),
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
