import 'package:ecommerce/providers/carousals.dart';
import 'package:flutter/cupertino.dart';

// import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class CarouselItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Carousals>(context, listen: false);
    final carousalItems = products.items;
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          // aspectRatio: 16 / 9,
          // viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: carousalItems
            .map(
              (item) => Container(
                child: FadeInImage(
                  placeholder: AssetImage(
                    'assets/images/untitled-5.gif',
                  ),
                  image: NetworkImage(
                    item.image.replaceAll('../', ''),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
