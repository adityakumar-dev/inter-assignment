import 'package:flutter/material.dart';
import 'package:intern_assignment/Data/posts_data.dart';
import 'package:intern_assignment/services/fetchImagePosts/fetch_image_posts.dart';
import 'package:intern_assignment/widgets/ImagePosts/image_posts_widget.dart';
import 'package:intern_assignment/widgets/get_data_fun.dart';

class ImagePostScreen extends StatefulWidget {
  const ImagePostScreen({super.key});

  @override
  State<ImagePostScreen> createState() => _ImagePostScreenState();
}

class _ImagePostScreenState extends State<ImagePostScreen> {
  Future<void> _fetchImagePosts() async {
    await fetchImage(context);
    if (PostsData.imagePostsData == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text("Error Fetching posts")));
    } else {
      setState(() {}); // Trigger rebuild after fetching data
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PostsData.imagePostsData?.isEmpty ?? true
          ? Center(
              child: getDataFun("Get Image Posts", _fetchImagePosts),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                PostsData.imagePostsData?.length ?? 0,
                (index) => GetTextPostsUi(index: index),
              ),
            ),
    );
  }
}
