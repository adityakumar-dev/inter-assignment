import 'package:flutter/material.dart';
import 'package:intern_assignment/Data/posts_data.dart';
import 'package:intern_assignment/services/fetchVideoPosts/fetchVideo.dart';
import 'package:intern_assignment/widgets/get_data_fun.dart';

import 'package:video_player/video_player.dart';

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

class GetVideoPostsWidgetUi extends StatefulWidget {
  final int index;
  const GetVideoPostsWidgetUi({super.key, required this.index});

  @override
  State<GetVideoPostsWidgetUi> createState() => _GetVideoPostsWidgetUiState();
}

class _GetVideoPostsWidgetUiState extends State<GetVideoPostsWidgetUi> {
  late VideoPlayerController videoPlayerController;
  bool _isVideoReady = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(PostsData.videoPostsData![widget.index].url),
    );

    videoPlayerController.initialize().then((_) {
      setState(() {
        _isVideoReady = true;
      });
    });
  }

  @override
  void dispose() {
    // videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            PostsData.videoPostsData![widget.index].name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (_isVideoReady)
            AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController),
            )
          else
            const Center(child: CircularProgressIndicator()),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                videoPlayerController.value.isPlaying
                    ? videoPlayerController.pause()
                    : videoPlayerController.play();
              });
            },
            child: Text(
              videoPlayerController.value.isPlaying ? "Pause" : "Play",
            ),
          ),
        ],
      ),
    );
  }
}
