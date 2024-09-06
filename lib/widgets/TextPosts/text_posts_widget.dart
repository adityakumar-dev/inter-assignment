import 'package:flutter/material.dart';
import 'package:intern_assignment/Data/posts_data.dart';
import 'package:share_plus/share_plus.dart';

class GetTextPostsWidgetUi extends StatelessWidget {
  final index;
  const GetTextPostsWidgetUi({
    super.key,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: PostsData.isTextFetch,
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Text(PostsData.textPostsData?[index].name ?? "name",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 24)),
              Text(
                PostsData.textPostsData?[index].desc ?? "desc",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              ElevatedButton(
                  onPressed: () async {
                    print(PostsData.textPostsData![index].name);
                    String baseUrl =
                        "https://flutter-intern-web.onrender.com/text?name=${Uri.encodeComponent(PostsData.textPostsData![index].name.trim())}";
                    Share.share(
                        "Click to open intern_assignment application : $baseUrl");
                    print(baseUrl);
                  },
                  child: const Icon(Icons.share))
            ],
          ),
        ));
  }
}
