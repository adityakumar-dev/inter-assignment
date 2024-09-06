import 'package:flutter/material.dart';
import 'package:intern_assignment/Data/posts_data.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              ElevatedButton(
                  onPressed: () async {
                    String baseUrl =
                        "https://flutter-intern-web.onrender.com/video?name=${Uri.encodeComponent(PostsData.videoPostsData![widget.index].name.trim())}";
                    Share.share(
                        "Click to open intern_assignment application : $baseUrl");
                    print(baseUrl);
                  },
                  child: const Icon(Icons.share))
            ],
          ),
        ],
      ),
    );
  }
}
