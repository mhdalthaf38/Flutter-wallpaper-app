import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:testing_app/config/theme/them.dart';
import 'package:testing_app/models/photo_model.dart';
import 'package:testing_app/presentation/bloc/photo_bloc.dart';
import 'package:testing_app/presentation/bloc/photo_event.dart';

class ImageViewScreen extends StatelessWidget {
  final PhotoModel photo;
  const ImageViewScreen({required this.photo});

  // Future<void> _downloadImage(BuildContext context) async {
  //   try {
  //     if (Platform.isAndroid) {
  //       final storageStatus = await Permission.storage.status;
  //       if (storageStatus.isDenied) {
  //         final status = await Permission.storage.request();
  //         if (!status.isGranted) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('Storage permission is required to download images')),
  //           );
  //           return;
  //         }
  //       }
        
  //       if (await Permission.storage.isPermanentlyDenied) {
  //         openAppSettings();
  //         return;
  //       }
  //     }

  //     final dir = Directory('/storage/emulated/0/Download');
  //     if (!await dir.exists()) {
  //       await dir.create(recursive: true);
  //     }

  //     final response = await http.get(Uri.parse(photo.src));
  //     final file = File('${dir.path}/${photo.id}.jpg');
  //     await file.writeAsBytes(response.bodyBytes);

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Image saved successfully!')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to save image: ${e.toString()}')),
  //     );
  //   }
  // }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text(photo.photographer),
        backgroundColor:AppColors.primarycolor ,
        elevation: 0,
      
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(photo.src, fit: BoxFit.cover),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context).primaryColor.withOpacity(0.8), Theme.of(context).primaryColor],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ElevatedButton.icon(
                  onPressed: () => context.read<PhotoBloc>().add(downloadImage(context, photo)),
                  icon: Icon(Icons.download, color: Colors.white),
                  label: Text('Download', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ),
            ),          ),
        ],
      ),
    );
  }
}