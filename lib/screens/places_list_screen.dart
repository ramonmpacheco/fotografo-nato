import 'package:flutter/material.dart';
import 'package:fotografo_nato/providers/places_provider.dart';
import 'package:fotografo_nato/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Lugares'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<PlacesProvider>(context, listen: false).loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<PlacesProvider>(
                child: Center(
                  child: Text('Nenhuma local...'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount == 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlaces.itemByIndex(index).image),
                          ),
                          title: Text(greatPlaces.itemByIndex(index).title),
                          subtitle: Text(
                              greatPlaces.itemByIndex(index).location.address),
                          onTap: () {},
                        ),
                      ),
              ),
      ),
    );
  }
}
