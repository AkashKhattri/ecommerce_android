import 'package:ecommerce/providers/auth.dart';
import 'package:ecommerce/providers/orders.dart' show Orders;
import 'package:ecommerce/screens/auth_screen.dart';
import 'package:ecommerce/widgets/app_drawer.dart';
import 'package:ecommerce/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return auth.isAuth
        ? Scaffold(
            appBar: AppBar(
              title: Text('Your Orders'),
            ),
            drawer: AppDrawer(),
            body: FutureBuilder(
              future: Provider.of<Orders>(context, listen: false)
                  .fetchAndSetOrders(auth.token),
              builder: (ctx, dataSnapShot) {
                if (dataSnapShot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (dataSnapShot.error != null) {
                    return Center(
                      child: Text('${dataSnapShot.error}'),
                    );
                  } else {
                    return Consumer<Orders>(
                      builder: (ctx, orderData, child) => ListView.builder(
                        itemCount: orderData.orders.length,
                        itemBuilder: (ctx, i) => OrderItem(
                          orderData.orders[i],
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          )
        : AuthScreen();
  }
}
