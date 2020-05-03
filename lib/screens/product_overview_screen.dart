import 'package:flutter/material.dart';
import 'package:my_shop/providers/products_provider.dart';
import '../widgets/app_drawer.dart';
import './cart_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart_provider.dart';

enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          Consumer<CartProvider>(
            builder: (_, item, ch) => Badge(
              child: ch,
              value: '${item.itemCount}',
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  isFavorite = true;
                } else {
                  isFavorite = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.All)
            ],
          ),
        ],
      ),
      body: ProductsGrid(isFavorite),
      drawer: AppDrawer(),
    );
  }
}
