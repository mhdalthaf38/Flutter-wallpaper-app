import 'package:flutter/material.dart';
import 'package:testing_app/core/services/pixels_api_services.dart';
import 'package:testing_app/models/photo_model.dart';


class PhotoProvider with ChangeNotifier {
  final PexelsApiService _apiService = PexelsApiService();
  List<PhotoModel> _photos = [];
  int _page = 1;
  bool _isLoading = false;

  List<PhotoModel> get photos => _photos;
  bool get isLoading => _isLoading;

  Future<void> fetchPhotos() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final newPhotos = await _apiService.fetchPhotos(_page);
      _photos.addAll(newPhotos);
      _page++;
    } catch (e) {
      print("Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
