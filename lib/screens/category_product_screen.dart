import 'package:ecommerce/providers/products.dart';
import 'package:ecommerce/widgets/cateogry_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProductScreen extends StatelessWidget {
  static const routeName = '/category-product';

  @override
  Widget build(BuildContext context) {
    final catId = ModalRoute.of(context).settings.arguments;
    final productsCat = Provider.of<Products>(context).filterCategory(catId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cateogry'),
      ),
      body: productsCat.isEmpty
          ? Container(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: FittedBox(
                  child: Text(
                      "Sorry no products in this category, Please check later for updates."),
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: productsCat.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: productsCat[i],
                child: CategoryProduct(productsCat[i]),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 50,
              ),
            ),
    );
  }
}
