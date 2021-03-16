import 'package:ecommerce/providers/categories.dart';
import 'package:ecommerce/screens/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Carousals(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Categories(),
        ),
      ],
      child: MaterialApp(
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
        },
      ),
    );
  }
}
