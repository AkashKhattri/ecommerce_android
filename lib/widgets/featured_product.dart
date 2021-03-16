import 'package:ecommerce/providers/products.dart';
import 'package:ecommerce/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeaturedProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fProducts = Provider.of<Products>(context, listen: false).isFeatured;

    return Container(
      height: 250,
      width: double.infinity,
      // margin: const EdgeInsets.only(bottom: 6),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(5),
      //   color: Colors.white,
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey,
      //       offset: Offset(0, 1),
      //       blurRadius: 6,
      //     ),
      //   ],
      // ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: fProducts
            .map(
              (item) => GestureDetector(
                onTap: () => {
                  Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                      arguments: [item.id, 'featured'])
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                              tag: "hero1-${item.id}",
                              child: FadeInImage(
                                placeholder: AssetImage(
                                  'assets/images/untitled-5.gif',
                                ),
                                image: NetworkImage(item.heroImage),
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
                                item.name,
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
                                Text('Rs.${item.sellingPrice.toString()}'),
                                GestureDetector(
                                  onTap: () {
                                    print('I got added to cart');
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
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
