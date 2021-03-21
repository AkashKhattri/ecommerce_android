import 'package:ecommerce/providers/cart.dart';
import 'package:ecommerce/providers/product.dart';
import 'package:ecommerce/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProduct extends StatefulWidget {
  final Product product;

  CategoryProduct(this.product);

  @override
  _CategoryProductState createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
            arguments: [widget.product.id, 'prolist'])
      },
      child: Container(
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                alignment: Alignment.center,
                child: Hero(
                  tag: "hero1-${widget.product.id}",
                  child: FadeInImage(
                    placeholder: AssetImage(
                      'assets/images/untitled-5.gif',
                    ),
                    image: NetworkImage(widget.product.heroImage),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 250,
                child: FittedBox(
                  child: Text(
                    widget.product.name,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rs.${widget.product.sellingPrice.toString()}'),
                    GestureDetector(
                      onTap: () {
                        cart.addItem(
                          widget.product.id,
                          (widget.product.sellingPrice).toDouble(),
                          widget.product.name,
                          widget.product.heroImage,
                        );
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added item to cart!'),
                            duration: Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'UNDO',
                              onPressed: () {
                                cart.removeSingleItem(widget.product.id);
                              },
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.shopping_basket_outlined,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
