import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_assignment/Data/posts_data.dart';
import 'package:intern_assignment/models/posts_model.dart';
import 'package:intern_assignment/services/fetchTextPosts/fetch_text_posts.dart';

class AppLinkTextPosts extends StatefulWidget {
  final String? name;

  const AppLinkTextPosts({Key? key, this.name}) : super(key: key);

  @override
  State<AppLinkTextPosts> createState() => _AppLinkTextPostsState();
}

class _AppLinkTextPostsState extends State<AppLinkTextPosts> {
  bool erro = false;
  bool show = false;
  String? desc;
  String errors = '';

  Future<void> fetchData() async {
    try {
      await fetchText(context);
      TextPost textPost = PostsData.textPostsData!.firstWhere((element) {
        return element.name.trim() == widget.name!.trim();
      }, orElse: () => TextPost(name: '', desc: ''));

      if (textPost.name.isEmpty) {
        setState(() {
          erro = true;
          errors = "Post not found";
        });
      } else {
        // If the post was found, show the post data
        setState(() {
          show = true;
          desc = textPost.desc;
        });
      }
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
          onPressed: () {
            setState(() {
              PostsData.textPostsData = null;
            });
            context.go('/home');
          },
          icon: const Icon(Icons.home),
        ),
        title: const Text("App Link Text Posts"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (erro)
              Text(
                'Error: $errors',
                style: const TextStyle(color: Colors.red),
              ),
            if (!show && !erro) const CircularProgressIndicator(),
            if (show)
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(widget.name ?? "name",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 24)),
                    Text(
                      desc ?? "desc",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
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
