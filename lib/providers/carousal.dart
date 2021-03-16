import 'package:flutter/cupertino.dart';

class Carousal with ChangeNotifier {
  final String id;
  final String link;
  final String image;

  Carousal({
    @required this.id,
    @required this.link,
    @required this.image,
  });
}
