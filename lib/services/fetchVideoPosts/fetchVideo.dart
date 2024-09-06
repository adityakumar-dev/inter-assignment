import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intern_assignment/Data/posts_data.dart';
import 'package:intern_assignment/models/posts_model.dart';
import 'package:lottie/lottie.dart';

Future<void> fetchVideo(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Lottie.asset(
        'assets/loading_lottie.json',
      );
    },
  );
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Posts');

  try {
    QuerySnapshot postsSnapshot = await collectionReference.get();

    List<VideoPost> allVideoPosts = [];

    for (QueryDocumentSnapshot snapshot in postsSnapshot.docs) {
      CollectionReference textPostRef =
          snapshot.reference.collection('Video Post');

      QuerySnapshot querySnapshot = await textPostRef.get();

      List<VideoPost> videoPosts = querySnapshot.docs
          .map((doc) => VideoPost.fromFirestore(doc))
          .toList();

      allVideoPosts.addAll(videoPosts);
    }

    PostsData.videoPostsData = allVideoPosts;

    for (var value in PostsData.videoPostsData!) {
      print("Data is : ${value.url}");
    }
  } catch (e) {
    print("Error fetching text posts: $e");
  }
  Navigator.pop(context);
}
