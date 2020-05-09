import 'package:flutter/material.dart';
import 'package:my_shop/screens/orders_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart' show CartProvider;
import '../providers/orders_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    var ordersProvider = Provider.of<OrdersProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.title.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(
                      cartProvider: cartProvider,
                      ordersProvider: ordersProvider),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (ctx, index) {
                var cartItem = cartProvider.items.values.toList()[index];
                return CartItem(
                  cartItem.id,
                  cartProvider.items.keys.toList()[index],
                  cartItem.price,
                  cartItem.quantity,
                  cartItem.title,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartProvider,
    @required this.ordersProvider,
  }) : super(key: key);

  final CartProvider cartProvider;
  final OrdersProvider ordersProvider;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return 
    // _isLoading
    //     ? Container(
    //         margin: EdgeInsets.symmetric(horizontal: 20),
    //         child: CircularProgressIndicator(),
    //       )
    //     : 
        FlatButton(
            onPressed: widget.cartProvider.totalAmount <= 0
                ? null
                : () async {
                    try {
                      setState(() {
                        _isLoading = true;
                      });
                      await widget.ordersProvider.addOrder(
                        widget.cartProvider.items.values.toList(),
                        widget.cartProvider.totalAmount,
                      );
                      setState(() {
                        _isLoading = false;
                      });
                      widget.cartProvider.clearCart();
                    } catch (error) {
                      print(error);
                    }
                    // Navigator.of(context).pushNamed(OrdersScreen.routeName);
                  },
            child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
            textColor: Theme.of(context).primaryColor,
          );
  }
}
