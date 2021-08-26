import 'package:flutter/material.dart';
import 'package:fotografo_nato/providers/places_provider.dart';
import 'package:fotografo_nato/screens/place_detail_screen.dart';
import 'package:fotografo_nato/screens/place_form_screen.dart';
import 'package:fotografo_nato/screens/places_list_screen.dart';
import 'package:fotografo_nato/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => PlacesProvider(),
      child: MaterialApp(
        title: 'Fotógrafo Nato',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AppRoutes.PLACE_FORM: (ctx) => PlaceFormScreen(),
          AppRoutes.PLACE_DETAIL: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
