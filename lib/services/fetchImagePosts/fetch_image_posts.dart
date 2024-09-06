import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern_assignment/Data/posts_data.dart';
import 'package:intern_assignment/models/posts_model.dart';

Future<void> fetchImage() async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Posts');

  try {
    QuerySnapshot postsSnapshot = await collectionReference.get();

    List<ImagePost> allImagePosts = [];

    for (QueryDocumentSnapshot snapshot in postsSnapshot.docs) {
      CollectionReference imagePostref =
          snapshot.reference.collection('Image Post');

      QuerySnapshot querySnapshot = await imagePostref.get();

      List<ImagePost> Imagepost = querySnapshot.docs
          .map((doc) => ImagePost.fromFirestore(doc))
          .toList();

      allImagePosts.addAll(Imagepost);
    }

    PostsData.imagePostsData = allImagePosts;

    for (var value in PostsData.imagePostsData!) {
      print("Data is : ${value.url}");
    }
  } catch (e) {
    print("Error fetching text posts: $e");
  }
}
