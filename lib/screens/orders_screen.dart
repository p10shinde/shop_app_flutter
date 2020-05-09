import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart' show OrdersProvider;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static final routeName = '/orders';

  // var _isLoading = false;
  // @override
  // void initState() {
  // Future.delayed(Duration.zero).then((_) async {
  // setState(() {
  // _isLoading = true;
  // });
  // Provider.of<OrdersProvider>(context, listen: false)
  //     .fetchAndSetupOrders()
  //     .then((_) {
  //   setState(() {
  //     _isLoading = false;
  //   });
  // });
  // });
  // super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: FutureBuilder(
          future: Provider.of<OrdersProvider>(context, listen: false)
              .fetchAndSetupOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An error ocure'),
                );
              } else {
                return Consumer<OrdersProvider>(
                  builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, index) {
                      return OrderItem(orderData.orders[index]);
                    },
                  ),
                );
              }
            }
          }),
      drawer: AppDrawer(),
    );
  }
}
