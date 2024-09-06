import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_assignment/Data/posts_data.dart';
import 'package:intern_assignment/models/posts_model.dart';
import 'package:intern_assignment/services/fetchImagePosts/fetch_image_posts.dart';

class AppLinkImagePosts extends StatefulWidget {
  final String? name; // Ensure it's nullable if necessary
  const AppLinkImagePosts({Key? key, this.name}) : super(key: key);

  @override
  State<AppLinkImagePosts> createState() => _AppLinkImagePostsState();
}

class _AppLinkImagePostsState extends State<AppLinkImagePosts> {
  bool erro = false;
  bool show = false;
  String url = ''; // Set a default value
  String errors = '';

  Future<void> fetchData() async {
    try {
      await fetchImage(context); // Fetch video posts
      ImagePost imagePost = PostsData.imagePostsData!.firstWhere((element) {
        return element.name.trim() == widget.name!.trim();
      }, orElse: () => ImagePost(name: '', url: ''));

      setState(() {
        show = true;
        url = imagePost.url; // Use the correct URL
      });
    } catch (e) {
      setState(() {
        errors = e.toString();
        erro = true;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.name != null) {
        fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.home),
        ),
        title: const Text("App Link Image Posts"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (erro)
              const Text(
                'Error: Post Not Found',
                style: TextStyle(color: Colors.red),
              ),
            if (!show && !erro) const CircularProgressIndicator(),
            if (show)
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Text(
                      widget.name ?? 'Unknown',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    url.isNotEmpty
                        ? Image.network(url)
                        : const Text('No Image URL Found'),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
