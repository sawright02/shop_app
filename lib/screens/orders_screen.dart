import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: Consumer<Orders>(
        builder: (context, orderData, _) {
          return ListView.builder(
            itemCount: orderData.orders.length,
            itemBuilder: (context, i) {
              return OrderItem(orderData.orders[i]);
            },
          );
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
