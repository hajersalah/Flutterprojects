import 'package:delivery_manager/models/classes/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  final Function removeOrder;
  OrderItem(this.order, this.removeOrder);
  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).accentColor == Colors.grey[800];
    return Card(
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04)
          .add(EdgeInsets.only(bottom: 10)),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 30,
            child: FittedBox(
              // we use this widget to make the next fit the line .. & not to seperate in 2 lines !
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${order.price.toStringAsFixed(2)}\$',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(
            order.deliveryMan,
            style: TextStyle(color: dark ? Colors.white : Colors.black),
          ),
          subtitle: Text(DateFormat('hh:mm a').format(order.orderDate),
              style: TextStyle(color: dark ? Colors.white : Colors.black)),
          trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                removeOrder(
                    DateFormat('yyyyMMdd').format(order.orderDate), order);
              }),
        ),
      ),
    );
  }
}
