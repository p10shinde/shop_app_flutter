import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/cart_screen.dart';
import './providers/cart_provider.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './providers/products_provider.dart';
import './providers/orders_provider.dart';
import './providers/auth_provider.dart';
import './screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
              create: (_) => ProductsProvider(),
              update: (ctx, authData, previousProducts) {
                previousProducts.user = authData.userId;
                // previousProducts.auth = authData.token;
                return previousProducts..auth = authData.token;
                // return previousProducts;
              }
              // value: ProductsProvider(),
              ),
          ChangeNotifierProxyProvider<AuthProvider, CartProvider>(
              create: (_) => CartProvider(),
              update: (ctx, authData, previousData) {
                previousData.user = authData.userId;
                return previousData..auth = authData.token;
              }),
          ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
              create: (_) => OrdersProvider(),
              update: (ctx, authData, previousData) {
                previousData.user = authData.userId;
                return previousData..auth = authData.token;
              }),
        ],
        child: Consumer<AuthProvider>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato'),
            home: auth.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              // '/': (ctx) => ProductOverviewScreen(),
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          ),
        ));
  }
}
