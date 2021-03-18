import 'package:ecommerce/providers/product.dart';
import 'package:ecommerce/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

class CategoryProduct extends StatefulWidget {
  final Product product;

  CategoryProduct(this.product);

  @override
  _CategoryProductState createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: [widget.product.id, '']);
          },
          child: Hero(
            tag: 'hero3-${widget.product.id}',
            child: FadeInImage(
              placeholder: AssetImage(
                'assets/images/product-placeholder.png',
              ),
              image: NetworkImage(widget.product.heroImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          title: Text(
            widget.product.name,
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }
}
