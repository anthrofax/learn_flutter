import 'package:flutter_dotenv/flutter_dotenv.dart';

String getStaticMap(double latitute, double longitude) {
  final lat = latitute;
  final lng = longitude;

  return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$lng&key=${dotenv.env['GOOGLE_MAP_API_KEY']}";
}
