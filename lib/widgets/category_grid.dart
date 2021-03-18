import 'package:ecommerce/providers/categories.dart';

import 'package:ecommerce/widgets/categoryItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Categories>(context).items;

    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: categories.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: categories[i],
        child: CategoryItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 50,
      ),
    );
  }
}
