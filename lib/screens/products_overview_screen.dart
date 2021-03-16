import 'package:ecommerce/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const routeName = '/product-overview';

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(),
    );
    return scaffold;
  }
}
