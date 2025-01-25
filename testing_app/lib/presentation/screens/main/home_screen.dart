import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:testing_app/config/theme/them.dart';
import 'package:testing_app/presentation/bloc/photo_bloc.dart';
import 'package:testing_app/presentation/bloc/photo_event.dart';
import 'package:testing_app/presentation/bloc/photo_state.dart';
import 'package:testing_app/presentation/widgets/image_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PhotoBloc>().add(FetchPhotos());
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.read<PhotoBloc>().add(FetchPhotos());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarycolor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Wallpaper App'),
        backgroundColor: AppColors.primarycolor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is PhotoLoading && state is! PhotoLoaded) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PhotoLoaded) {
            return MasonryGridView.count(
              controller: _scrollController,
              itemCount: state.photos.length,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 8,
              itemBuilder: (context, index) {
                final aspectRatio = (index % 2 == 0) ? 0.9 : 0.7;
                return AspectRatio(
                  aspectRatio: aspectRatio,
                  child: ImageCard(photo: state.photos[state.photos.length - 1 - index]),
                );
              },
            );
          } else if (state is PhotoError) {
            return Center(child: Text(state.message, style: TextStyle(color: Colors.white)));
          }
          return Center(child: Text('Press the button to load photos', style: TextStyle(color: Colors.white)));
        },
      ),
    );
  }
}
