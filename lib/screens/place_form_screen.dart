import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fotografo_nato/providers/places_provider.dart';
import 'package:fotografo_nato/widgets/image_input.dart';
import 'package:fotografo_nato/widgets/location_input.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  LatLng _pickedPosition;

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectPosition(LatLng position) {
    setState(() {
      this._pickedPosition = position;
    });
  }

  bool _isValidForm() {
    return _titleController.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedPosition != null;
  }

  void _submitForm() {
    if (!this._isValidForm()) {
      return;
    }

    Provider.of<PlacesProvider>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _pickedPosition);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 10),
                    ImageInput(this._selectImage),
                    SizedBox(height: 10),
                    LocationInput(this._selectPosition)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: this._isValidForm() ? _submitForm : null,
            icon: Icon(Icons.add),
            label: Text('Adicionar'),
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(20)),
          )
        ],
      ),
    );
  }
}
