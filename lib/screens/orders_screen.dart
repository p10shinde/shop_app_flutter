import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart' show OrdersProvider;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static final routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, index) {
          return OrderItem(orderData.orders[index]);
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
