import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:fotografo_nato/models/place.dart';
import 'package:fotografo_nato/utils/db_util.dart';
import 'package:fotografo_nato/utils/location_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map(
          (it) => Place(
            id: it['id'],
            title: it['title'],
            location: PlaceLocation(
              latitude: it['lat'],
              longitude: it['long'],
              address: it['address'],
            ),
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

  Future<void> addPlace(String title, File image, LatLng position) async {
    String address = await LocationUtil.getAddressFrom(position);

    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: PlaceLocation(
          latitude: position.latitude,
          longitude: position.longitude,
          address: address),
      image: image,
    );

    _items.add(newPlace);

    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image_path': newPlace.image.path,
      'lat': position.latitude,
      'long': position.longitude,
      'address': address
    });

    notifyListeners();
  }
}
