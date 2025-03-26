import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/models/place.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

Future<Database> _getDb() async {
  final dbPath = await getDatabasesPath();

  final db = await openDatabase(path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
    return db.execute(
      'CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)',
    );
  }, version: 1);

  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDb();
    final dataList = await db.query('user_places');

    final places = dataList.map((row) {
      return Place(
        id: row['id'] as String?,
        title: row['title'] as String,
        image: File(row['image'] as String),
        location: PlaceLocation(
          latitude: row['latitude'] as double,
          longitude: row['longitude'] as double,
          address: row['address'] as String,
        ),
      );
    }).toList();

    state = places;
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final savedImage = await image.copy(path.join(appDir.path, fileName));

    final db = await _getDb();
    db.insert('user_places', {
      'title': title,
      'image': savedImage.path,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'address': location.address,
    });

    final newPlace = Place(title: title, image: savedImage, location: location);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
