import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:fotografo_nato/models/place.dart';
import 'package:fotografo_nato/utils/db_util.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map(
          (it) => Place(
            id: it['id'],
            title: it['title'],
            location: null,
            image: File(
              it['image_path'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: null,
      image: image,
    );

    _items.add(newPlace);

    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image_path': newPlace.image.path
    });

    notifyListeners();
  }
}
