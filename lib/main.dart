import 'package:flutter/material.dart';
import 'package:fotografo_nato/screens/place_form_screen.dart';
import 'package:fotografo_nato/screens/places_list_screen.dart';
import 'package:fotografo_nato/utils/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fotógrafo Nato',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber,
      ),
      home: PlacesListScreen(),
      routes: {
        AppRoutes.PLACE_FORM: (ctx) => PlaceFormScreen(),
      },
    );
  }
}
