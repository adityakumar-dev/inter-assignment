import 'package:flutter/material.dart';
import 'package:intern_assignment/Data/posts_data.dart';
import 'package:share_plus/share_plus.dart';

class GetTextPostsUi extends StatelessWidget {
  final int index;
  const GetTextPostsUi({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                PostsData.imagePostsData![index].name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    String baseUrl =
                        "https://flutter-intern-web.onrender.com/image?name=${Uri.encodeComponent(PostsData.imagePostsData![index].name.trim())}";
                    Share.share(
                        "Click to open intern_assignment application : $baseUrl");
                    print(baseUrl);
                  },
                  child: const Icon(Icons.share))
            ],
          ),
          PostsData.imagePostsData![index].url.isNotEmpty
              ? Image.network(PostsData.imagePostsData![index].url)
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
