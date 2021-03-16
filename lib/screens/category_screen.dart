import 'package:ecommerce/providers/categories.dart';
import 'package:ecommerce/widgets/category_grid.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/product-category';
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
      Provider.of<Categories>(context).fetchAndSetCategories().then((_) {
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
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CategoryGrid(),
    );
  }
}
