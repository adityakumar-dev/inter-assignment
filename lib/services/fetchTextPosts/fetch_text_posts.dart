import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intern_assignment/Data/posts_data.dart';
import 'package:intern_assignment/models/posts_model.dart';
import 'package:lottie/lottie.dart';

Future<void> fetchText(BuildContext context) async {
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

    List<TextPost> allTextPosts = [];

    for (QueryDocumentSnapshot snapshot in postsSnapshot.docs) {
      CollectionReference textPostRef =
          snapshot.reference.collection('Text Post');

      QuerySnapshot querySnapshot = await textPostRef.get();

      List<TextPost> textPosts =
          querySnapshot.docs.map((doc) => TextPost.fromFirestore(doc)).toList();

      allTextPosts.addAll(textPosts);
    }

    PostsData.textPostsData = allTextPosts;
    Navigator.pop(context);
    // for (var value in PostsData.textPostsData!) {
    //   print("Data is : ${value.desc}");
    // }
  } catch (e) {
    print("Error fetching text posts: $e");
  }
}
