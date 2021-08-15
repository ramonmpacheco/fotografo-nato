import 'package:flutter/cupertino.dart';
import 'package:fotografo_nato/models/place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get ItemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }
}
