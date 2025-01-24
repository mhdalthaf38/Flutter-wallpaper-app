import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/config/theme/them.dart';
import 'package:testing_app/presentation/provider/photo_provider.dart';
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
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        Provider.of<PhotoProvider>(context, listen: false).fetchPhotos();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PhotoProvider>(context, listen: false).fetchPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PhotoProvider>(context);
    
    return Scaffold(
      backgroundColor: AppColors.primarycolor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Wallpaper App'),
        backgroundColor:AppColors.primarycolor ,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: provider.isLoading && provider.photos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : MasonryGridView.count(
              controller: _scrollController,
              itemCount: provider.photos.length,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 8,
              itemBuilder: (context, index) {
                final aspectRatio = (index % 2 == 0) ? 0.9 : 0.7;
                return AspectRatio(
                  aspectRatio: aspectRatio,
                  child: ImageCard(photo: provider.photos[index]),
                );
              },
            ),
    );
  }
}