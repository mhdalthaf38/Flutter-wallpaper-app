import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:testing_app/core/services/pixels_api_services.dart';
import 'package:testing_app/presentation/bloc/photo_bloc.dart';
import 'package:testing_app/presentation/bloc/photo_event.dart';
import 'package:testing_app/presentation/screens/main/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhotoBloc(PexelsApiService())..add(FetchPhotos()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Wallpaper App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
