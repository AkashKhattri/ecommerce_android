import 'package:flutter/material.dart';
import 'package:ecommerce/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productArray = ModalRoute.of(context).settings.arguments;
    var array = [];
    array = productArray;

    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(array[0]);

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 300,
          stretch: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Container(
              decoration: BoxDecoration(color: Colors.black38),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Text(
                    loadedProduct.name,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            stretchModes: <StretchMode>[
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
            ],
            background: Hero(
              tag: (array[1] as String == 'featured')
                  ? 'hero1-${loadedProduct.id}'
                  : (array[1] as String == 'new')
                      ? 'hero2-${loadedProduct.id}'
                      : 'hero3-${loadedProduct.id}',
              child: Image.network(
                loadedProduct.heroImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: 10),
              Text(
                '\Nrs. ${loadedProduct.sellingPrice}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: loadedProduct.techspecs
                      .map(
                        (item) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 90,
                              height: 20,
                              child: Text(item['name']),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              child: Text(
                                item['value'],
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                height: 800,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
