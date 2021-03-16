import 'package:flutter/foundation.dart';

class Category with ChangeNotifier {
  final String id;
  final String name;
  final List<dynamic> subCategory;

  Category({
    @required this.id,
    @required this.name,
    @required this.subCategory,
  });
}
