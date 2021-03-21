import 'package:ecommerce/providers/cart.dart';
import 'package:ecommerce/providers/categories.dart';
import 'package:ecommerce/providers/orders.dart';
import 'package:ecommerce/screens/auth_screen.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/category_product_screen.dart';
import 'package:ecommerce/screens/category_screen.dart';
import 'package:ecommerce/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/providers/auth.dart';

import 'package:ecommerce/screens/products_overview_screen.dart';
import 'package:ecommerce/providers/carousals.dart';
import 'package:ecommerce/screens/product_detail_screen.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/providers/products.dart';
// import 'package:ecommerce/screens/products_overview_screen.dart';
// import 'package:ecommerce/screens/auth_screen.dart';
// import 'package:ecommerce/screens/welcome_screen.dart';
// import 'package:ecommerce/providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Carousals(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Categories(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => null,
          update: (ctx, auth, previousOrder) => Orders(
            auth.token,
            previousOrder == null ? [] : previousOrder.orders,
            auth.userId,
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: HomeScreen(),
        routes: {
          ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CategoryScreen.routeName: (ctx) => CategoryScreen(),
          CategoryProductScreen.routeName: (ctx) => CategoryProductScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen()
        },
      ),
    );
  }
}
