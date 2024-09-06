import 'package:flutter/material.dart';
import 'package:intern_assignment/Data/posts_data.dart';
import 'package:intern_assignment/services/fetchVideoPosts/fetchVideo.dart';
import 'package:intern_assignment/widgets/VideoPosts/video_posts_widget.dart';
import 'package:intern_assignment/widgets/get_data_fun.dart';

class VideoPostScreen extends StatefulWidget {
  const VideoPostScreen({super.key});

  @override
  State<VideoPostScreen> createState() => _VideoPostScreenState();
}

class _VideoPostScreenState extends State<VideoPostScreen> {
  Future<void> _fetchVideoposts() async {
    await fetchVideo(context);
    if (PostsData.videoPostsData == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text("Error Fetching posts")));
    } else {
      setState(() {
        PostsData.isVideoFetch = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: PostsData.videoPostsData?.isEmpty ?? true
            ? Container(
                height: MediaQuery.of(context).size.height * 0.9,
                alignment: Alignment.center,
                child: getDataFun("Get Video Posts", _fetchVideoposts),
              )
            : Column(
                children: List.generate(
                PostsData.videoPostsData?.length ?? 0,
                (index) => GetVideoPostsWidgetUi(index: index),
              )),
      ),
    );
  }
}
