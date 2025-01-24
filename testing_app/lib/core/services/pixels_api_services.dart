import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testing_app/models/photo_model.dart';


class PexelsApiService {
  final String _apiKey = 'WX17oRVeZM3AMCdfVpzPnAAmTmDcYUE5CsA0LtrulJbv07FnJ8eng09b';
  final String _baseUrl = 'https://api.pexels.com/v1/curated';

  Future<List<PhotoModel>> fetchPhotos(int page) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?per_page=20&page=$page'),
      headers: {'Authorization': _apiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['photos'] as List).map((json) => PhotoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
