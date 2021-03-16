import 'package:ecommerce/widgets/featured_product.dart';
import 'package:ecommerce/widgets/new_arrival.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce/providers/products.dart';
import 'package:ecommerce/widgets/app_drawer.dart';
import 'package:ecommerce/widgets/carousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Carousel(),
                  SizedBox(height: 10),
                  Divider(thickness: 2),
                  Text(
                    'Featured Products',
                    textAlign: TextAlign.left,
                  ),
                  Divider(thickness: 2),
                  FeaturedProduct(),
                  SizedBox(height: 10),
                  Divider(thickness: 2),
                  Text(
                    'New Arrivals',
                    textAlign: TextAlign.left,
                  ),
                  Divider(thickness: 2),
                  NewArrival(),
                ],
              ),
            ),
    );
  }
}
