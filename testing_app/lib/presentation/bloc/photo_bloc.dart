import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testing_app/core/services/pixels_api_services.dart';
import 'package:testing_app/models/photo_model.dart';
import 'photo_event.dart';
import 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  
  List<PhotoModel> _photos = [];
  int _page = 1;

  PhotoBloc() : super(PhotoInitial()) {
    on<FetchPhotos>(_onFetchPhotos);
    on<downloadImage>(_onDownloadImage);
  }

  Future<void> _onDownloadImage(downloadImage event, Emitter<PhotoState> emit) async {
    await _downloadImage(event.photo, event.context);
  }

  Future<void> _onFetchPhotos(FetchPhotos event, Emitter<PhotoState> emit) async {
    if (state is PhotoLoading) return;

    emit(PhotoLoading());
    try {
      final newPhotos = await PexelsApiService().fetchPhotos(_page);
     
      _photos.addAll(newPhotos);
      _page++;
      emit(PhotoLoaded(List.from(_photos)));
    } catch (e) {
      emit(PhotoError("Failed to load photos"));
    }
  }


   Future<void> _downloadImage(BuildContext context, PhotoModel photo) async {
    try {
      if (Platform.isAndroid) {
        final storageStatus = await Permission.storage.status;
        if (storageStatus.isDenied) {
          final status = await Permission.storage.request();
          if (!status.isGranted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Storage permission is required to download images')),
            );
            return;
          }
        }
        
        if (await Permission.storage.isPermanentlyDenied) {
          openAppSettings();
          return;
        }
      }

      final dir = Directory('/storage/emulated/0/Download');
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      final response = await http.get(Uri.parse(photo.src));
      final file = File('${dir.path}/${photo.id}.jpg');
      await file.writeAsBytes(response.bodyBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save image: ${e.toString()}')),
      );
    }
  }
}
