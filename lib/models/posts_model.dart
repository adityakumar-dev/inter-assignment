import 'package:cloud_firestore/cloud_firestore.dart';

class TextPost {
  final String name;
  final String desc;

  TextPost({required this.name, required this.desc});

  factory TextPost.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TextPost(
      name: data['name'] ?? 'No Name',
      desc: data['desc'] ?? 'No Description',
    );
  }
}

class VideoPost {
  final String name;
  final String url;

  VideoPost({required this.name, required this.url});

  factory VideoPost.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return VideoPost(
      name: data['name'] ?? 'No Name',
      url: data['url'] ?? 'No URL',
    );
  }
}

class ImagePost {
  final String name;
  final String url;

  ImagePost({required this.name, required this.url});

  factory ImagePost.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ImagePost(
      name: data['name'] ?? 'No Name',
      url: data['url'] ?? 'No URL',
    );
  }
}
