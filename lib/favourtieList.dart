import 'package:flutter/material.dart';

class FavoriteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavouriteList();
}

class _FavouriteList extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
      child: Text('Lista de favoritos'),
    ));
  }
}
