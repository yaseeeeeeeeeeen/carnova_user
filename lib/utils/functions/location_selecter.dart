import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class MapBoxHelper {
  static const accessToken =
      'pk.eyJ1IjoiaXNtYWlsdmsiLCJhIjoiY2xwOWtvZjF5MDM2dTJpcWlndHJ1Mnh0dyJ9.plsEL1xGKiKwrCuP36uc5Q';

  static const mapId = "mapbox.mapbox-streets-v8";

  static const urlTemplate =
      'https://api.mapbox.com/styles/v1/ismailvk/clp9licsc002201po1gh6bjt9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaXNtYWlsdmsiLCJhIjoiY2xwOWtvZjF5MDM2dTJpcWlndHJ1Mnh0dyJ9.plsEL1xGKiKwrCuP36uc5Q';

  static getSearchResults(String query) async {
    const String apiKey = accessToken;
    final String endpoint =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json';

    final response =
        await http.get(Uri.parse('$endpoint?access_token=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List features = data['features'];

      if (features.isNotEmpty) {
        final results = features.map((feature) {
          final placeName = feature['place_name'];
          final coordinates = feature['geometry']['coordinates'];
          final latitude = coordinates[1];
          final longitude = coordinates[0];

          return {
            'placeName': placeName,
            'latitude': latitude,
            'longitude': longitude,
          };
        }).toList();

        return results;
      }
    }

    return [];
  }

  Future<String?> getPlaceName(double latitude, double longitude) async {
    const String apiKey = accessToken;
    final String endpoint =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json';
    http.Response response;
    try {
      response = await http.get(Uri.parse('$endpoint?access_token=$apiKey'));
    } catch (e) {
      return null;
    }

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List features = data['features'];

      if (features.isNotEmpty) {
        return features[0]['place_name'];
      }
    }

    return null;
  }
}
