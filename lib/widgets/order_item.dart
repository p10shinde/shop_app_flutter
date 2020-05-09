import 'package:flutter/material.dart';
import 'dart:math';
import 'package:my_shop/providers/orders_provider.dart' as ord;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  // AnimationController _controller;
  // Animation<Size> _heightAnimation;

  @override
  Widget build(BuildContext context) {
    // _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    List<CartItem> products = [];
    return 
    // AnimatedContainer(
    //   duration: Duration(milliseconds: 100),
    //   height: _expanded ? min(widget.order.products.length * 20.0 + 110, 200) : 95,
    //   child: 
      Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('\$${widget.order.amount}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(
                    () {
                      _expanded = !_expanded;
                      products = widget.order.products;
                    },
                  );
                },
              ),
            ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                height: _expanded ? min(widget.order.products.length * 20.0 + 10, 100) : 0,
                child: ListView(
                  children: widget.order.products
                      .map(
                        (p) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              p.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${p.quantity}x \$${p.price}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      )
                      .toList(),
                ),
              )
          ],
        ),
      );
    // );
  }
}
