import 'package:flutter/material.dart';
import 'package:intern_assignment/Data/posts_data.dart';
import 'package:intern_assignment/services/fetchTextPosts/fetch_text_posts.dart';
import 'package:intern_assignment/widgets/TextPosts/text_posts_widget.dart';
import 'package:intern_assignment/widgets/get_data_fun.dart';

class TextPostScreen extends StatefulWidget {
  const TextPostScreen({super.key});

  @override
  State<TextPostScreen> createState() => _TextPostScreenState();
}

class _TextPostScreenState extends State<TextPostScreen> {
  Future<void> _fetchTextPosts() async {
    await fetchText(context);
    if (PostsData.textPostsData == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text("Error Fetching posts")));
    } else {
      setState(() {
        PostsData.isTextFetch = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PostsData.textPostsData?.isEmpty ?? true
          ? Container(
              height: MediaQuery.of(context).size.height * 0.9,
              alignment: Alignment.center,
              child: getDataFun("Get Text Posts", _fetchTextPosts),
            )
          : Column(
              children: List.generate(
              PostsData.textPostsData?.length ?? 0,
              (index) => GetTextPostsWidgetUi(
                index: index,
              ),
            )),
    );
  }
}
