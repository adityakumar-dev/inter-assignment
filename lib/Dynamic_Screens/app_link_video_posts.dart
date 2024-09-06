import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_assignment/Data/posts_data.dart';
import 'package:intern_assignment/models/posts_model.dart';
import 'package:intern_assignment/services/fetchVideoPosts/fetchVideo.dart';
import 'package:video_player/video_player.dart';

class AppLinkVideoPosts extends StatefulWidget {
  const AppLinkVideoPosts({super.key, required this.name});
  final String name;

  @override
  State<AppLinkVideoPosts> createState() => _AppLinkVideoPostsState();
}

class _AppLinkVideoPostsState extends State<AppLinkVideoPosts> {
  bool erro = false;
  bool show = false;
  String url = '';
  String errors = '';
  late VideoPlayerController videoPlayerController;
  bool _isVideoReady = false;

  Future<void> fetchData() async {
    try {
      await fetchVideo(context); // Fetch video posts
      VideoPost videoPost = PostsData.videoPostsData!.firstWhere((element) {
        return element.name.trim() == widget.name.trim();
      }, orElse: () => VideoPost(name: '', url: ''));

      if (videoPost.url.isEmpty) {
        // Handle empty or invalid URL case
        setState(() {
          erro = true;
          errors = 'No valid URL found for the post';
        });
      } else {
        setState(() {
          show = true;
          url = videoPost.url;

          // Initialize the video player controller
          videoPlayerController = VideoPlayerController.network(url)
            ..initialize().then((_) {
              setState(() {
                _isVideoReady = true;
              });
            }).catchError((e) {
              // Catch any errors while initializing the video player
              setState(() {
                erro = true;
                errors = 'Error loading video: ${e.toString()}';
              });
            });
        });
      }
    } catch (e) {
      setState(() {
        errors = 'Error fetching post data: ${e.toString()}';
        erro = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (_isVideoReady) {
      videoPlayerController.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              PostsData.videoPostsData = null;
            });
            context.go('/home');
          },
          icon: const Icon(Icons.home),
        ),
        title: const Text("App Link Video Posts"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (erro)
              Text(
                errors.isNotEmpty ? errors : 'Error: Post Not Found',
                style: const TextStyle(color: Colors.red),
              ),
            if (!show && !erro) const CircularProgressIndicator(),
            if (show && !erro)
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (_isVideoReady)
                      AspectRatio(
                        aspectRatio: videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(videoPlayerController),
                      )
                    else if (url.isNotEmpty)
                      const CircularProgressIndicator()
                    else
                      const Text('No valid video URL found.'),
                    const SizedBox(height: 10),
                    if (_isVideoReady)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            videoPlayerController.value.isPlaying
                                ? videoPlayerController.pause()
                                : videoPlayerController.play();
                          });
                        },
                        child: Text(
                          videoPlayerController.value.isPlaying
                              ? "Pause"
                              : "Play",
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
