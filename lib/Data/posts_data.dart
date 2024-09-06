import 'package:intern_assignment/models/posts_model.dart';

class PostsData {
  static bool isTextFetch = false;
  static bool isVideoFetch = false;
  static bool isImageFetch = false;

  static List<TextPost>? textPostsData;
  static List<VideoPost>? videoPostsData;
  static List<ImagePost>? imagePostsData;
}
